import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant/app_links.dart';
import '../../../../core/context/global.dart';
import '../../../../core/errors/dio_exp.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/providers/language_provider/l10n_provider.dart';
import '../../../../core/services/api_services/api_client.dart';
import '../../../../core/services/api_services/dio_helper.dart';
import '../../../../core/services/api_services/result_model.dart';
import '../../../../core/services/device_info_service.dart';
import '../../../../core/services/hive_services/box_kes.dart';
import '../model/contact_info_model.dart';
import '../model/user_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, Result<Map>>> login(String mobile, {String? team});
  Future<Either<Failure, Result<UserModel>>> checkOTPCode(String mobile, String code, String fcm, {String? team});
  Future<Either<Failure, Result<ContactInfoModel>>> getContactInfo();
}

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Either<Failure, Result<Map>>> login(String mobile, {String? team}) async {
    try {
      String lang = GlobalContext.context.read<LanguageProvider>().lang ?? 'en';
      // Use getServerForTeamParam() to get correct server based on team parameter
      // Uses AppLinks.serverTMMS for B2B Team, AppLinks.server for WeFix Team
      final String baseUrl = AppLinks.getServerForTeamParam(team);
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: baseUrl);
      
      // Normalize phone number - remove spaces and ensure proper format
      // The phone widget should already provide international format with country code
      String normalizedMobile = mobile.replaceAll(' ', '').replaceAll('-', '').trim();
      
      // If it doesn't start with +, it might be missing country code
      // In this case, we should reject it rather than assuming a country
      if (!normalizedMobile.startsWith('+')) {
        return Left(ServerFailure(
          message: lang == 'ar' 
            ? 'يرجى إدخال رقم الهاتف مع رمز الدولة (مثال: +1234567890)' 
            : 'Please enter phone number with country code (e.g., +1234567890)'
        ));
      }
      
      // Request OTP - use different endpoints based on team
      // B2B Team uses: B2B_REQUEST_OTP from .env (TMMS endpoint)
      // WeFix Team uses: SEND_OTP from .env (WeFix endpoint)
      final String endpoint = (team == 'B2B Team') ? AppLinks.b2bRequestOTP : AppLinks.login;
      final loginResponse = await client.postRequest(
        endpoint: endpoint,
        body: {"mobile": normalizedMobile},
      );
      
      if (loginResponse.response.statusCode == 200) {
        if (loginResponse.response.data['success'] == true || loginResponse.response.data['status'] == true) {
          return Right(Result.success(loginResponse.response.data));
        } else {
          String errorMessage = loginResponse.response.data['message'] ?? 
                               (lang == 'ar' ? loginResponse.response.data['messageAr'] : loginResponse.response.data['message']) ??
                               'Failed to send OTP';
          return Left(ServerFailure(message: errorMessage));
        }
      } else {
        // Handle different error status codes
        // Always try to extract message from response first
        String errorMessage = loginResponse.response.data['message']?.toString() ?? 
                             (lang == 'ar' ? loginResponse.response.data['messageAr']?.toString() : null) ??
                             'Failed to send OTP';
        
        // Only use default messages if no message was found in response
        if (errorMessage == 'Failed to send OTP') {
          if (loginResponse.response.statusCode == 404) {
            errorMessage = lang == 'ar' ? 'الحساب غير موجود' : 'Account does not exist';
          } else if (loginResponse.response.statusCode == 403) {
            // 403 Forbidden - Role not allowed
            errorMessage = lang == 'ar' ? 'تم رفض الوصول. هذا التطبيق متاح فقط للفنيين' : 'Access denied. This app is only available for Technicians';
          } else if (loginResponse.response.statusCode == 423) {
            errorMessage = lang == 'ar' ? 'الحساب مؤقتاً مقفل' : 'Account temporarily locked';
          } else if (loginResponse.response.statusCode == 429) {
            errorMessage = lang == 'ar' ? 'يرجى الانتظار قبل طلب رمز جديد' : 'Please wait before requesting a new code';
          } else if (loginResponse.response.statusCode == 400) {
            errorMessage = lang == 'ar' ? 'رقم الهاتف غير صحيح' : 'Invalid phone number format';
          }
        }
        
        return Left(ServerFailure(message: errorMessage));
      }
    } on DioException catch (e) {
      // Handle network errors
      if (e.type == DioExceptionType.connectionTimeout || 
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        String lang = GlobalContext.context.read<LanguageProvider>().lang ?? 'en';
        return Left(ServerFailure(
          message: lang == 'ar' 
            ? 'خطأ في الاتصال بالخادم. يرجى المحاولة مرة أخرى' 
            : 'Network or service error. Please try again'
        ));
      }
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Result<UserModel>>> checkOTPCode(String mobile, String code, String fcm, {String? team}) async {
    try {
      String lang = GlobalContext.context.read<LanguageProvider>().lang ?? 'en';
      // Use getServerForTeamParam() to get correct server based on team parameter
      // Uses AppLinks.serverTMMS for B2B Team, AppLinks.server for WeFix Team
      final String baseUrl = AppLinks.getServerForTeamParam(team);
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: baseUrl);
      
      // Normalize phone number - remove spaces and ensure proper format
      // The phone widget should already provide international format with country code
      String normalizedMobile = mobile.replaceAll(' ', '').replaceAll('-', '').trim();
      
      // If it doesn't start with +, it might be missing country code
      if (!normalizedMobile.startsWith('+')) {
        return Left(ServerFailure(
          message: lang == 'ar' 
            ? 'يرجى إدخال رقم الهاتف مع رمز الدولة' 
            : 'Please enter phone number with country code'
        ));
      }
      
      // Verify OTP - use different endpoints based on team
      // B2B Team uses: B2B_VERIFY_OTP from .env (TMMS endpoint)
      // WeFix Team uses: VERIFY_OTP from .env (backend-tjms endpoint for technicians)
      final String endpoint = (team == 'B2B Team') ? AppLinks.b2bVerifyOTP : AppLinks.sendOTP;
      
      // Prepare request body based on team
      Map<String, dynamic> requestBody;
      if (team == 'B2B Team') {
        // B2B Team (backend-tmms) expects: mobile, otp, fcmToken, deviceId
        final deviceMetadata = await DeviceInfoService.getDeviceMetadata();
        final deviceId = jsonEncode(deviceMetadata);
        requestBody = {
          "mobile": normalizedMobile,
          "otp": code,
          "fcmToken": fcm,
          "deviceId": deviceId,
        };
      } else {
        // WeFix Team (backend-tjms) expects: Mobile, Otp (capitalized, OTP as int)
        requestBody = {
          "Mobile": normalizedMobile,
          "Otp": int.tryParse(code) ?? 0, // backend-tjms expects OTP as integer
        };
      }
      
      final sendOtpResponse = await client.postRequest(
        endpoint: endpoint,
        body: requestBody,
      );
      
      if (sendOtpResponse.response.statusCode == 200) {
        if (sendOtpResponse.response.data['success'] == true || sendOtpResponse.response.data['status'] == true) {
          final responseData = sendOtpResponse.response.data;
          
          // Handle different response formats based on team
          if (team == 'B2B Team') {
            // Transform SERVER_TMMS response to UserModel format
            final userData = responseData['user'];
            final tokenData = responseData['token'];
            
            // Extract token information (can be object or string)
            String? accessToken;
            Map<String, dynamic>? tokenInfo;
            
            if (tokenData is Map) {
              accessToken = tokenData['accessToken']?.toString() ?? tokenData['token']?.toString();
              tokenInfo = Map<String, dynamic>.from(tokenData);
            } else if (tokenData is String) {
              accessToken = tokenData;
            }
            
            // Map the response to UserModel structure - matching backend user.model.ts
            final userModelData = {
              'status': true,
              'token': accessToken,
              'message': responseData['message'] ?? 'Authentication successful',
              'user': userData != null ? {
                // Core backend fields
                'id': userData['id'],
                'userNumber': userData['userNumber'],
                'fullName': userData['fullName'],
                'fullNameEnglish': userData['fullNameEnglish'],
                'email': userData['email'],
                'mobileNumber': userData['mobileNumber'],
                'countryCode': userData['countryCode'],
                'username': userData['username'],
                'userRoleId': userData['userRoleId'],
                'companyId': userData['companyId'],
                'profileImage': userData['profileImage'],
                'gender': userData['gender'],
                // Legacy fields for backward compatibility
                'name': userData['fullName'] ?? userData['fullNameEnglish'],
                'mobile': userData['mobileNumber'],
                'image': userData['profileImage'],
              } : null,
            };
            
            UserModel userModel = UserModel.fromJson(userModelData);
            
            // Store token info separately in Hive for token management
            // This is done here because we have access to the raw response
            if (tokenInfo != null && team == 'B2B Team') {
              try {
                final box = await Hive.openBox(BoxKeys.appBox);
                final refreshToken = tokenInfo['refreshToken'];
                final expiresIn = tokenInfo['expiresIn'];
                
                if (refreshToken != null) {
                  await box.put('${BoxKeys.usertoken}_refresh', refreshToken);
                }
                
                if (expiresIn != null) {
                  final expiresInSeconds = expiresIn is int 
                      ? expiresIn 
                      : int.tryParse(expiresIn.toString()) ?? AppLinks.tokenFallbackExpirationSeconds;
                  final tokenExpiresAt = DateTime.now().add(Duration(seconds: expiresInSeconds));
                  await box.put('${BoxKeys.usertoken}_expiresAt', tokenExpiresAt.toIso8601String());
                }
              } catch (e) {
                // Silent fail - token info saving is optional
              }
            }
            
            return Right(Result.success(userModel));
          } else {
            // WeFix Team (backend-tjms) response format
            // Response: { status: true, token: string, message: string, User: {...} }
            final token = responseData['token']?.toString();
            final userData = responseData['User'] ?? responseData['user'];
            
            // Map backend-tjms response to UserModel format
            final userModelData = {
              'status': responseData['status'] ?? true,
              'token': token,
              'message': responseData['message'] ?? 'Authentication successful',
              'user': userData != null ? {
                'id': userData['id'],
                'name': userData['Name'] ?? userData['name'],
                'email': userData['Email'] ?? userData['email'],
                'mobile': userData['Mobile'] ?? userData['mobile'],
                'image': userData['Image'] ?? userData['image'],
                'rating': userData['rating'] ?? 0.0,
                'address': userData['Address'] ?? userData['address'],
                'profession': userData['Profession'] ?? userData['profession'],
                'age': userData['Age'] ?? userData['age'],
                'introduce': userData['Introduce'] ?? userData['introduce'],
                'dateOfBirth': userData['DateOfBirth'] ?? userData['dateOfBirth'],
                'createdDate': userData['CreatedDate'] ?? userData['createdDate'],
                // Map to standard fields
                'fullName': userData['Name'] ?? userData['name'],
                'fullNameEnglish': userData['Name'] ?? userData['name'],
                'mobileNumber': userData['Mobile'] ?? userData['mobile'],
                'profileImage': userData['Image'] ?? userData['image'],
              } : null,
            };
            
            UserModel userModel = UserModel.fromJson(userModelData);
            return Right(Result.success(userModel));
          }
        } else {
          String errorMessage = sendOtpResponse.response.data['message'] ?? 
                               (lang == 'ar' ? sendOtpResponse.response.data['messageAr'] : sendOtpResponse.response.data['message']) ??
                               'OTP verification failed';
          return Left(ServerFailure(message: errorMessage));
        }
      } else {
        // Handle different error status codes
        String errorMessage = sendOtpResponse.response.data['message'] ?? 'OTP verification failed';
        
        // Map status codes to user-friendly messages
        if (sendOtpResponse.response.statusCode == 410) {
          errorMessage = lang == 'ar' ? 'انتهت صلاحية رمز التحقق. يرجى طلب رمز جديد' : 'OTP has expired. Please request a new OTP';
        } else if (sendOtpResponse.response.statusCode == 423) {
          errorMessage = lang == 'ar' ? 'تم قفل الحساب مؤقتاً بسبب محاولات فاشلة كثيرة' : 'Account temporarily locked due to too many failed attempts';
        } else if (sendOtpResponse.response.statusCode == 403) {
          // 403 Forbidden - Role not allowed
          errorMessage = sendOtpResponse.response.data['message'] ?? 
                        (lang == 'ar' ? 'تم رفض الوصول. هذا التطبيق متاح فقط للفنيين' : 'Access denied. This app is only available for Technicians');
        } else if (sendOtpResponse.response.statusCode == 401) {
          errorMessage = sendOtpResponse.response.data['message'] ?? 
                        (lang == 'ar' ? 'رمز التحقق غير صحيح' : 'Invalid OTP');
        } else if (sendOtpResponse.response.statusCode == 400) {
          errorMessage = sendOtpResponse.response.data['message'] ?? 
                        (lang == 'ar' ? 'بيانات غير صحيحة' : 'Invalid data');
        }
        
        return Left(ServerFailure(message: errorMessage));
      }
    } on DioException catch (e) {
      // Handle network errors
      if (e.type == DioExceptionType.connectionTimeout || 
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        String lang = GlobalContext.context.read<LanguageProvider>().lang ?? 'en';
        return Left(ServerFailure(
          message: lang == 'ar' 
            ? 'خطأ في الاتصال بالخادم. يرجى المحاولة مرة أخرى' 
            : 'Network or service error. Please try again'
        ));
      }
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Result<ContactInfoModel>>> getContactInfo() async {
    try {
      final ApiClient client = ApiClient(DioProvider().dio);
      final response = await client.getRequest(endpoint: AppLinks.contactInfo);
      if (response.response.statusCode == 200) {
        ContactInfoModel contactInfoModel = ContactInfoModel.fromJson(response.response.data);
        return Right(Result.success(contactInfoModel));
      } else {
        return Left(ServerFailure.fromResponse(response.response.statusCode));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
