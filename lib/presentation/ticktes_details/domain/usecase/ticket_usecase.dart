import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_services/result_model.dart';
import '../model/maintenances_list_model.dart';
import '../model/params/create_material_params.dart';
import '../model/params/create_tools_params.dart';
import '../model/params/maintenanc_params.dart';
import '../model/tickets_details_model.dart';
import '../repoistory/maintenances_repoistory.dart';
import '../repoistory/material_repoistory.dart';
import '../repoistory/tickets_details_reoistory.dart';
import '../repoistory/tools_repoistory.dart';

class TicketUsecase {
  final TicketsDetailsReoistory ticketsDetailsReoistory;
  final MaterialReoistory materialReoistory;
  final ToolsReoistory toolsReoistory;
  final MaintenancesRepoistory maintenancesRepoistory;

  TicketUsecase({required this.maintenancesRepoistory, required this.ticketsDetailsReoistory, required this.toolsReoistory, required this.materialReoistory});

  // * ============================== Ticket Details ==============================
  Future<Either<Failure, Result<TicketsDetails>>> ticketDetails(String ticketId) async => await ticketsDetailsReoistory.ticketDetails(ticketId);
  Future<Either<Failure, Result<Unit>>> startTickets(String ticketId) async => await ticketsDetailsReoistory.startTickets(ticketId);
  Future<Either<Failure, Result<Unit>>> startTicketsWithAttachment(String ticketId, String attachmentUrl) async => await ticketsDetailsReoistory.startTicketsWithAttachment(ticketId, attachmentUrl);
  Future<Either<Failure, Result<Unit>>> completeTickets(String ticketId, String note, String signature, String link) async =>
      await ticketsDetailsReoistory.completeTicket(ticketId, note, signature, link);
  Future<Either<Failure, Result<Unit>>> createTicketImage(String ticketId, List<String> images) async =>
      await ticketsDetailsReoistory.createTicketImage(ticketId, images);

  // * ============================== Tools ==============================
  Future<Either<Failure, Result<List<TicketTool>>>> ticketTools() async => await toolsReoistory.ticketTools();
  Future<Either<Failure, Result<Unit>>> addTools(CreateToolsParams createToolsParams) async => await toolsReoistory.addTools(createToolsParams);

  // * ============================== Materials ==============================
  Future<Either<Failure, Result<List<TicketMaterial>>>> ticketMaterial(String ticketId) async => await materialReoistory.ticketMaterial(ticketId);
  Future<Either<Failure, Result<Unit>>> ticketDeleteMaterial(int ticketId) async => await materialReoistory.ticketDeleteMaterial(ticketId);
  Future<Either<Failure, Result<Unit>>> ticketAddMaterial(CreateMaterialParams createMaterialParams) async =>
      await materialReoistory.ticketAddMaterial(createMaterialParams);

  // * ============================== Completion CheckList ==============================
  Future<Either<Failure, Result<List<MaintenancesList>>>> getMaintenancesList(String ticketId) async =>
      await maintenancesRepoistory.getMaintenancesList(ticketId);
  Future<Either<Failure, Result<Unit>>> updateMaintenancesList(MaintenancParams params) async => await maintenancesRepoistory.updateMaintenancesList(params);
  Future<Either<Failure, Result<Unit>>> unSelectMaintenancesList(int id , int ticketId) async => await maintenancesRepoistory.unSelectMaintenancesList(id , ticketId);
  Future<Either<Failure, Result<List<dynamic>>>> getType() async => await maintenancesRepoistory.getType();
}
