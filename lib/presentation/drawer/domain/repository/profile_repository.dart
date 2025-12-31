import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../../core/constant/app_links.dart';
import '../../../../core/errors/dio_exp.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_services/api_client.dart';
import '../../../../core/services/api_services/dio_helper.dart';
import '../../../../core/services/api_services/result_model.dart';
import '../../../../core/services/hive_services/box_kes.dart';
import '../../../../injection_container.dart';
import '../../../auth/domain/model/user_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Result<User>>> getProfile();
  Future<Either<Failure, Result<User>>> updateProfile({
    String? email,
    String? fullNameArabic,
    String? fullNameEnglish,
    String? mobileNumber,
    String? countryCode,
    String? gender,
    File? profileImage,
  });
}

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Either<Failure, Result<User>>> getProfile() async {
    try {
      // Use SERVER_TMMS for profile endpoint (backend-tmms)
      // AppLinks.serverTMMS already includes /api/v1, so endpoint should be relative
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.serverTMMS);
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      
      // Backend-tmms route: GET /api/v1/user/profile
      // endpoint is relative to baseUrl which already has /api/v1
      final response = await client.getRequest(
        endpoint: 'user/profile',
        authorization: 'Bearer $token',
      );
      
      // Handle response format: { profile: { email, fullNameArabic, fullNameEnglish, profileImage } }
      final responseData = response.response.data;
      final profileData = responseData['profile'] ?? responseData['data'] ?? responseData;
      
      // Map backend-tmms profile format to User model
      // Backend returns: { email, firstname, lastname, profileImage } or { email, fullName, fullNameEnglish, profileImage }
      // User model expects: { email, fullName, fullNameEnglish, profileImage, mobileNumber, countryCode }
      final user = User(
        email: profileData['email'],
        fullName: profileData['firstname'] ?? profileData['fullNameArabic'] ?? profileData['fullName'],
        fullNameEnglish: profileData['lastname'] ?? profileData['fullNameEnglish'],
        profileImage: profileData['profileImage'],
        // Get additional fields from stored user data if available
        mobileNumber: profileData['mobileNumber'],
        countryCode: profileData['countryCode'],
        gender: profileData['gender'],
      );
      
      return Right(Result.success(user));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Result<User>>> updateProfile({
    String? email,
    String? fullNameArabic,
    String? fullNameEnglish,
    String? mobileNumber,
    String? countryCode,
    String? gender,
    File? profileImage,
  }) async {
    try {
      // Use SERVER_TMMS for profile update endpoint (backend-tmms)
      final dio = DioProvider().dio;
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      // AppLinks.serverTMMS already includes /api/v1, so use it directly
      final baseUrl = AppLinks.serverTMMS;
      
      // Prepare form data
      final formData = FormData();
      
      // Add text fields
      // Backend expects 'firstname' and 'lastname', not 'fullNameArabic' and 'fullNameEnglish'
      if (email != null) formData.fields.add(MapEntry('email', email));
      if (fullNameArabic != null) formData.fields.add(MapEntry('firstname', fullNameArabic));
      if (fullNameEnglish != null) formData.fields.add(MapEntry('lastname', fullNameEnglish));
      if (mobileNumber != null) formData.fields.add(MapEntry('mobileNumber', mobileNumber));
      if (countryCode != null) formData.fields.add(MapEntry('countryCode', countryCode));
      if (gender != null) formData.fields.add(MapEntry('gender', gender));
      
      // Add image file if provided
      if (profileImage != null) {
        formData.files.add(
          MapEntry(
            'profileImage',
            await MultipartFile.fromFile(
              profileImage.path,
              filename: profileImage.path.split('/').last,
            ),
          ),
        );
      }
      
      // Backend-tmms route: PUT /api/v1/user/profile
      // baseUrl already includes /api/v1, so just append the endpoint
      String cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      
      final response = await dio.put(
        '$cleanBaseUrl/user/profile',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      
      // Handle response format: { success: true, profile: { ... } }
      final responseData = response.data;
      final profileData = responseData['profile'] ?? responseData['data'] ?? responseData;
      
      // Map backend-tmms profile format to User model
      // Backend returns 'firstname' and 'lastname', map them to fullName and fullNameEnglish
      final user = User(
        email: profileData['email'],
        fullName: profileData['firstname'] ?? profileData['fullNameArabic'],
        fullNameEnglish: profileData['lastname'] ?? profileData['fullNameEnglish'],
        profileImage: profileData['profileImage'],
        mobileNumber: profileData['mobileNumber'],
        countryCode: profileData['countryCode'],
        gender: profileData['gender'],
      );
      
      return Right(Result.success(user));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

