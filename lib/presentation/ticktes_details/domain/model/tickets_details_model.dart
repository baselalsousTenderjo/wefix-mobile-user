import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../presentation/home/domain/model/home_model.dart';

part 'tickets_details_model.freezed.dart';
part 'tickets_details_model.g.dart';

@freezed
class TicketsDetailsModel with _$TicketsDetailsModel {
  const factory TicketsDetailsModel({@JsonKey(name: "objTickets") TicketsDetails? ticketsDetails}) = _TicketsDetailsModel;

  factory TicketsDetailsModel.fromJson(Map<String, dynamic> json) => _$TicketsDetailsModelFromJson(json);
}

@freezed
class TicketsDetails with _$TicketsDetails {
  const factory TicketsDetails({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "ticketCodeId") String? ticketCodeId,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "time") String? time,
    @JsonKey(name: "titleAr") String? titleAr,
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "typeAr") String? typeAr,
    @JsonKey(name: "userId") int? userId,
    @JsonKey(name: "date") DateTime? date,
    @JsonKey(name: "timeTo") String? timeTo,
    @JsonKey(name: "reportLink") String? reportLink,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "statusAr") String? statusAr,
    @JsonKey(name: "customerName") String? customerName,
    @JsonKey(name: "customerImage") String? customerImage,
    @JsonKey(name: "customerAddress") String? customerAddress,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "serviceDescription") String? serviceDescription,
    @JsonKey(name: "isWithMaterial") bool? isWithMaterial,
    @JsonKey(name: "isWithFemale") bool? isWithFemale,
    @JsonKey(name: "latitudel") String? latitudel,
    @JsonKey(name: "longitude") String? longitude,
    @JsonKey(name: "mobile") String? mobile,
    @JsonKey(name: "esitmatedTime") String? esitmatedTime,
    @JsonKey(name: "ticketAttatchments") List<TicketAttatchment>? ticketAttatchments,
    @JsonKey(name: "technicianAttachments") List<TicketAttatchment>? technicianAttachments,
    @JsonKey(name: "ticketTools") List<TicketTool>? ticketTools,
    @JsonKey(name: "ticketImages") List<String>? ticketImages,
    @JsonKey(name: "ticketMaterials") List<TicketMaterial>? ticketMaterials,
    @JsonKey(name: "maintenanceTickets") List<MaintenanceTicket>? maintenanceTickets,
    @JsonKey(name: "servcieTickets") List<ServiceTicket>? serviceTickets,
    @JsonKey(name: "advantageTickets") List<AdvantageTickets>? advantageTickets,
    @JsonKey(name: "mainService") MainServiceInfo? mainService,
    @JsonKey(name: "subService") SubServiceInfo? subService,
    @JsonKey(name: "createdBy") int? createdBy,
    @JsonKey(name: "creator") CreatorInfo? creator,
    @JsonKey(name: "company") Map<String, dynamic>? company,
    @JsonKey(name: "branch") Map<String, dynamic>? branch,
    @JsonKey(name: "zone") Map<String, dynamic>? zone,
    @JsonKey(name: "teamLeader") Map<String, dynamic>? teamLeader,
    @JsonKey(name: "technician") Map<String, dynamic>? technician,
  }) = _TicketsDetails;

  factory TicketsDetails.fromJson(Map<String, dynamic> json) => _$TicketsDetailsFromJson(json);
}

@freezed
class TicketAttatchment with _$TicketAttatchment {
  const factory TicketAttatchment({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "ticketId") int? ticketId,
    @JsonKey(name: "size") dynamic size,
    @JsonKey(name: "fileName") dynamic fileName,
    @JsonKey(name: "filePath") String? filePath,
    @JsonKey(name: "type") dynamic type,
    @JsonKey(name: "createdDate") DateTime? createdDate,
    @JsonKey(name: "ticket") dynamic ticket,
  }) = _TicketAttatchment;

  factory TicketAttatchment.fromJson(Map<String, dynamic> json) => _$TicketAttatchmentFromJson(json);
}

@freezed
class TicketMaterial with _$TicketMaterial {
  const factory TicketMaterial({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "titleAr") String? titleAr,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "price") double? price,
    @JsonKey(name: "iSselected") bool? iSselected, 
    @JsonKey(name: "quantity") int? quantity,
  }) = _TicketMaterial;

  factory TicketMaterial.fromJson(Map<String, dynamic> json) => _$TicketMaterialFromJson(json);
}

@freezed
class TicketTool with _$TicketTool {
  const factory TicketTool({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "toolId") int? toolId,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "titleAr") String? titleAr,
    @JsonKey(name: "quantity") int? quantity,
    @Default(false) bool isSelect,
  }) = _TicketTool;

  factory TicketTool.fromJson(Map<String, dynamic> json) => _$TicketToolFromJson(json);
}

@freezed
class MaintenanceTicket with _$MaintenanceTicket {
  const factory MaintenanceTicket({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "nameAr") String? nameAr,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "note") dynamic note,
  }) = _MaintenanceTicket;

  factory MaintenanceTicket.fromJson(Map<String, dynamic> json) => _$MaintenanceTicketFromJson(json);
}

@freezed
class ServiceTicket with _$ServiceTicket {
  const factory ServiceTicket({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "nameAr") String? nameAr,
    @JsonKey(name: "image") String? image,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "quantity") int? quantity,
  }) = _ServiceTicket;

  factory ServiceTicket.fromJson(Map<String, dynamic> json) => _$ServiceTicketFromJson(json);
}

@freezed
class AdvantageTickets with _$AdvantageTickets {
  const factory AdvantageTickets({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "nameAr") String? nameAr,
    @JsonKey(name: "price") int? price,
  }) = AadvantageTickets;

  factory AdvantageTickets.fromJson(Map<String, dynamic> json) => _$AdvantageTicketsFromJson(json);
}

@freezed
class CreatorInfo with _$CreatorInfo {
  const factory CreatorInfo({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "nameEnglish") String? nameEnglish,
    @JsonKey(name: "userNumber") String? userNumber,
    @JsonKey(name: "mobileNumber") String? mobileNumber,
    @JsonKey(name: "countryCode") String? countryCode,
    @JsonKey(name: "image") String? image,
  }) = _CreatorInfo;

  factory CreatorInfo.fromJson(Map<String, dynamic> json) => _$CreatorInfoFromJson(json);
}
