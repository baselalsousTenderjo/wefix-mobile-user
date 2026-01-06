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
import '../../../ticktes_details/domain/model/tickets_details_model.dart';
import '../model/ticket_tools_model.dart';

abstract class ToolsRepoistory {
  Future<Either<Failure, Result<List<TicketTool>>>> getDriverTools();
  Future<Either<Failure, Unit>> deleteDriverTools(int id);
}

class ToolsRepoistoryImpl implements ToolsRepoistory {
  @override
  Future<Either<Failure, Result<List<TicketTool>>>> getDriverTools() async {
    try {
      // Use B2C server for driver tools (not team-dependent)
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForCommon());
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      final toolsResponse = await client.getRequest(endpoint: AppLinks.tools, authorization: 'Bearer $token');
      TicketToolsModel tools = TicketToolsModel.fromJson(toolsResponse.response.data);
      return Right(Result.success(tools.ticketTools));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDriverTools(int id) async {
    try {
      // Use B2C server for driver tools (not team-dependent)
      final ApiClient client = ApiClient(DioProvider().dio, baseUrl: AppLinks.getServerForCommon());
      final token = await sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.usertoken);
      await client.postRequest(endpoint: AppLinks.deleteTool, authorization: 'Bearer $token', body: {'Id': id});
      return const Right(unit);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
