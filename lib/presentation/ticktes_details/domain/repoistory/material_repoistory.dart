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
import '../model/material_model.dart';
import '../model/params/create_material_params.dart';
import '../model/tickets_details_model.dart';

abstract class MaterialReoistory {
  Future<Either<Failure, Result<List<TicketMaterial>>>> ticketMaterial(String ticketId);
  Future<Either<Failure, Result<Unit>>> ticketAddMaterial(CreateMaterialParams createMaterialParams);
  Future<Either<Failure, Result<Unit>>> ticketDeleteMaterial(int id);
}

class MaterialReoistoryImpl implements MaterialReoistory {
  @override
  Future<Either<Failure, Result<List<TicketMaterial>>>> ticketMaterial(String ticketId) async {
    try {
      // Use team-based server: SERVER_TMMS for B2B Team, SERVER for WeFix Team
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForTeam());
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      final ticketMaterialResponse = await client.getRequest(endpoint: AppLinks.ticketsMaterials + ticketId, authorization: 'Bearer $token');
      MaterialModel ticketMaterial = MaterialModel.fromJson(ticketMaterialResponse.response.data);
      return Right(Result.success(ticketMaterial.materials));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Result<Unit>>> ticketAddMaterial(CreateMaterialParams createMaterialParams) async {
    try {
      // Use team-based server: SERVER_TMMS for B2B Team, SERVER for WeFix Team
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForTeam());
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      final ticketAddMaterialResponse = await client.postRequest(
        endpoint: AppLinks.ticketsAddMaterials,
        body: createMaterialParams.toJson(),
        authorization: 'Bearer $token',
      );
      if (ticketAddMaterialResponse.response.data['status'] == false) {
        return Left(ServerFailure.fromResponse(ticketAddMaterialResponse.response.statusCode, message: ticketAddMaterialResponse.response.data['message']));
      }
      return Right(Result.success(unit));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Result<Unit>>> ticketDeleteMaterial(int id) async {
    try {
      // Use team-based server: SERVER_TMMS for B2B Team, SERVER for WeFix Team
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForTeam());
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      final ticketAddMaterialResponse = await client.postRequest(endpoint: AppLinks.ticketsDeleteMaterials, body: {"Id": id}, authorization: 'Bearer $token');
      if (ticketAddMaterialResponse.response.data['status'] == false) {
        return Left(ServerFailure.fromResponse(ticketAddMaterialResponse.response.statusCode, message: ticketAddMaterialResponse.response.data['message']));
      }
      return Right(Result.success(unit));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
