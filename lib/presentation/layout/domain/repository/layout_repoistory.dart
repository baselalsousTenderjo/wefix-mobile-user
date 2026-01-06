import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constant/app_links.dart';
import '../../../../core/errors/dio_exp.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_services/api_client.dart';
import '../../../../core/services/api_services/dio_helper.dart';
import '../../../../core/services/api_services/result_model.dart';
import '../../../../core/services/hive_services/box_kes.dart';
import '../../../../injection_container.dart';
import '../../../auth/domain/model/user_model.dart';

abstract class LayoutRepoistory {
  Future<Either<Failure, Result<User>>> getProfile();
  Future<Either<Failure, Result<bool>>> checkAccess();
}

class LayoutRepoistoryImpl implements LayoutRepoistory {
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
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForTeam());
      
      // Use B2B route for B2B Team, B2C route for WeFix Team
      final String endpoint = (await _isB2BTeam()) ? AppLinks.b2bUserProfile : AppLinks.profile;
      final response = await client.getRequest(endpoint: endpoint, authorization: 'Bearer $token');
      if (response.response.statusCode == 200) {
        // Backend-tmms returns: { profile: {...} }
        final profileData = response.response.data['profile'] ?? response.response.data['data'] ?? response.response.data;
        User userModel = User.fromJson(profileData);
        return Right(Result.success(userModel));
      } else {
        return Left(ServerFailure.fromResponse(response.response.statusCode));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Result<bool>>> checkAccess() async {
    try {
      // Use team-based server: SERVER_TMMS for B2B Team, SERVER for WeFix Team
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForTeam());
      
      // Use B2B route for B2B Team, B2C route for WeFix Team
      final String endpoint = (await _isB2BTeam()) ? AppLinks.b2bUserMe : AppLinks.checkAccess;
      final response = await client.getRequest(endpoint: endpoint, authorization: 'Bearer $token');
      if (response.response.statusCode == 200) {
        // Check if user has valid role (Technician 21 or Sub-Technician 22)
        final userData = response.response.data['data'] ?? response.response.data['user'] ?? response.response.data;
        final userRoleId = userData['userRoleId'] as int?;
        if (userRoleId == 21 || userRoleId == 22) {
          return Right(Result.success(true));
        } else {
          return Right(Result.success(false));
        }
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
