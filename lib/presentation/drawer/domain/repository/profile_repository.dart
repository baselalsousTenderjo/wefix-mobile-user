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
  // Helper method to check if user is B2B Team
  Future<bool> _isB2BTeam() async {
    try {
      final userTeam = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.userTeam);
      return userTeam == 'B2B Team';
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, Result<User>>> getProfile() async {
    try {
      // Use team-based server: SERVER_TMMS for B2B Team, SERVER for WeFix Team
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForTeam());
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      
      // Use B2B route for B2B Team, B2C route for WeFix Team
      final String endpoint = (await _isB2BTeam()) ? AppLinks.b2bUserProfile : AppLinks.profile;
      final response = await client.getRequest(
        endpoint: endpoint,
        authorization: 'Bearer $token',
      );
      
      final responseData = response.response.data;
      final bool isB2B = await _isB2BTeam();
      
      // Handle different response formats based on team
      Map<String, dynamic> profileData;
      if (isB2B) {
        // B2B (backend-tmms) format: { profile: { ... } } or { data: { ... } }
        profileData = responseData['profile'] ?? responseData['data'] ?? responseData;
        
        // Map backend-tmms profile format to User model
        // Backend returns: { email, firstname, lastname, profileImage } or { email, fullName, fullNameEnglish, profileImage }
        final user = User(
          email: profileData['email'],
          fullName: profileData['firstname'] ?? profileData['fullNameArabic'] ?? profileData['fullName'],
          fullNameEnglish: profileData['lastname'] ?? profileData['fullNameEnglish'],
          profileImage: profileData['profileImage'],
          mobileNumber: profileData['mobileNumber'],
          countryCode: profileData['countryCode'],
          gender: profileData['gender'],
        );
        return Right(Result.success(user));
      } else {
        // B2C (backend-tjms) format: { serviceProvider: { id, name, email, mobile, image, address, age, profession, aboutMe, raring, createdDate } }
        profileData = responseData['serviceProvider'] ?? responseData;
        
        // Map backend-tjms serviceProvider format to User model
        // Backend returns: { name, email, mobile, image, address, age, profession, aboutMe, raring, createdDate }
        final user = User(
          id: profileData['id'],
          email: profileData['email']?.toString().trim(),
          fullName: profileData['name']?.toString().trim(),
          fullNameEnglish: profileData['name']?.toString().trim(), // B2C doesn't have separate English name
          mobileNumber: profileData['mobile']?.toString().trim(),
          profileImage: profileData['image'],
          // Map B2C fields to User model
          address: profileData['address'],
          age: profileData['age']?.toString(),
          profession: profileData['profession'],
          introduce: profileData['aboutMe'],
          rating: profileData['raring']?.toString(), // rating is String? in User model
          createdDate: profileData['createdDate'] != null 
              ? DateTime.tryParse(profileData['createdDate'].toString()) 
              : null,
          // Legacy field mappings
          name: profileData['name']?.toString().trim(),
          mobile: profileData['mobile']?.toString().trim(),
          image: profileData['image'],
        );
        return Right(Result.success(user));
      }
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
      // Use team-based server: SERVER_TMMS for B2B Team, SERVER for WeFix Team
      final dio = DioProvider().dio;
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      // AppLinks.getServerForTeam() already includes /api/v1, so use it directly
      final baseUrl = AppLinks.getServerForTeam();
      
      // Prepare form data
      final formData = FormData();
      final bool isB2B = await _isB2BTeam();
      
      // Add text fields - different field names for B2B vs B2C
      if (email != null) formData.fields.add(MapEntry('email', email));
      
      if (isB2B) {
        // B2B (backend-tmms) expects 'firstname' and 'lastname'
        if (fullNameArabic != null) formData.fields.add(MapEntry('firstname', fullNameArabic));
        if (fullNameEnglish != null) formData.fields.add(MapEntry('lastname', fullNameEnglish));
        if (mobileNumber != null) formData.fields.add(MapEntry('mobileNumber', mobileNumber));
        if (countryCode != null) formData.fields.add(MapEntry('countryCode', countryCode));
        if (gender != null) formData.fields.add(MapEntry('gender', gender));
      } else {
        // B2C (backend-tjms) expects 'name', 'mobile', 'address', 'age', 'profession', 'aboutMe'
        if (fullNameArabic != null || fullNameEnglish != null) {
          // Use fullNameArabic if available, otherwise fullNameEnglish, otherwise empty
          final name = fullNameArabic ?? fullNameEnglish ?? '';
          formData.fields.add(MapEntry('name', name));
        }
        if (mobileNumber != null) formData.fields.add(MapEntry('mobile', mobileNumber));
        // Note: B2C doesn't use countryCode, gender in the same way
      }
      
      // Add image file if provided
      if (profileImage != null) {
        final imageFieldName = isB2B ? 'profileImage' : 'image'; // B2C uses 'image', B2B uses 'profileImage'
        formData.files.add(
          MapEntry(
            imageFieldName,
            await MultipartFile.fromFile(
              profileImage.path,
              filename: profileImage.path.split('/').last,
            ),
          ),
        );
      }
      
      // Use B2B route for B2B Team, B2C route for WeFix Team
      final String endpoint = (await _isB2BTeam()) ? AppLinks.b2bUserProfile : AppLinks.profile;
      String cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      
      final response = await dio.put(
        '$cleanBaseUrl/$endpoint',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      
      // Handle different response formats based on team
      final responseData = response.data;
      
      if (isB2B) {
        // B2B (backend-tmms) format: { profile: { ... } } or { data: { ... } }
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
      } else {
        // B2C (backend-tjms) format: { serviceProvider: { ... } }
        final profileData = responseData['serviceProvider'] ?? responseData;
        
        // Map backend-tjms serviceProvider format to User model
        final user = User(
          id: profileData['id'],
          email: profileData['email']?.toString().trim(),
          fullName: profileData['name']?.toString().trim(),
          fullNameEnglish: profileData['name']?.toString().trim(),
          mobileNumber: profileData['mobile']?.toString().trim(),
          profileImage: profileData['image'],
          address: profileData['address'],
          age: profileData['age']?.toString(),
          profession: profileData['profession'],
          introduce: profileData['aboutMe'],
          rating: profileData['raring']?.toString(),
          createdDate: profileData['createdDate'] != null 
              ? DateTime.tryParse(profileData['createdDate'].toString()) 
              : null,
          name: profileData['name']?.toString().trim(),
          mobile: profileData['mobile']?.toString().trim(),
          image: profileData['image'],
        );
        return Right(Result.success(user));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

