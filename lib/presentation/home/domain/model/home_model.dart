import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_model.freezed.dart';
part 'home_model.g.dart';

@freezed
class HomeModel with _$HomeModel {
  const factory HomeModel({
    @JsonKey(name: "tickets") List<Tickets>? tickets,
    @JsonKey(name: "ticketsTomorrow") List<Tickets>? ticketsTomorrow,
    @JsonKey(name: "emergency") List<Tickets>? emergency,
    @JsonKey(name: "technician") TechnicianInfo? technician,
  }) = _HomeModel;

  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);
}

@freezed
class TechnicianInfo with _$TechnicianInfo {
  const factory TechnicianInfo({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "nameEnglish") String? nameEnglish,
    @JsonKey(name: "image") String? image,
    @JsonKey(name: "company") CompanyInfo? company,
  }) = _TechnicianInfo;

  factory TechnicianInfo.fromJson(Map<String, dynamic> json) => _$TechnicianInfoFromJson(json);
}

@freezed
class CompanyInfo with _$CompanyInfo {
  const factory CompanyInfo({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "nameArabic") String? nameArabic,
    @JsonKey(name: "nameEnglish") String? nameEnglish,
    @JsonKey(name: "logo") String? logo,
  }) = _CompanyInfo;

  factory CompanyInfo.fromJson(Map<String, dynamic> json) => _$CompanyInfoFromJson(json);
}

@freezed
class Tickets with _$Tickets {
  const factory Tickets({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "ticketCodeId") String? ticketCodeId,
    @JsonKey(name: "image") String? image,
    @JsonKey(name: "customer") String? customer,
    @JsonKey(name: "date") DateTime? date,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "statusAr") String? statusAr,
    @JsonKey(name: "time") String? time,
    @JsonKey(name: "ticketType") String? ticketType,
    @JsonKey(name: "ticketTypeAr") String? ticketTypeAr,
    @JsonKey(name: "ticketTitle") String? ticketTitle,
    @JsonKey(name: "ticketDescription") String? ticketDescription,
    @JsonKey(name: "serviceDescription") String? serviceDescription,
    @JsonKey(name: "locationMap") String? locationMap,
    @JsonKey(name: "havingFemaleEngineer") bool? havingFemaleEngineer,
    @JsonKey(name: "withMaterial") bool? withMaterial,
    @JsonKey(name: "tools") List<int>? tools,
    @JsonKey(name: "ticketTimeTo") String? ticketTimeTo,
    @JsonKey(name: "mainService") MainServiceInfo? mainService,
    @JsonKey(name: "subService") SubServiceInfo? subService,
    @JsonKey(name: "branch") BranchInfo? branch,
    @JsonKey(name: "zone") ZoneInfo? zone,
    @JsonKey(name: "contract") ContractInfo? contract,
  }) = _Tickets;

  factory Tickets.fromJson(Map<String, dynamic> json) => _$TicketsFromJson(json);
}

@freezed
class MainServiceInfo with _$MainServiceInfo {
  const factory MainServiceInfo({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "nameArabic") String? nameArabic,
    @JsonKey(name: "image") String? image,
  }) = _MainServiceInfo;

  factory MainServiceInfo.fromJson(Map<String, dynamic> json) => _$MainServiceInfoFromJson(json);
}

@freezed
class SubServiceInfo with _$SubServiceInfo {
  const factory SubServiceInfo({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "nameArabic") String? nameArabic,
    @JsonKey(name: "image") String? image,
  }) = _SubServiceInfo;

  factory SubServiceInfo.fromJson(Map<String, dynamic> json) => _$SubServiceInfoFromJson(json);
}

@freezed
class BranchInfo with _$BranchInfo {
  const factory BranchInfo({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "nameArabic") String? nameArabic,
    @JsonKey(name: "nameEnglish") String? nameEnglish,
  }) = _BranchInfo;

  factory BranchInfo.fromJson(Map<String, dynamic> json) => _$BranchInfoFromJson(json);
}

@freezed
class ZoneInfo with _$ZoneInfo {
  const factory ZoneInfo({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "number") String? number,
  }) = _ZoneInfo;

  factory ZoneInfo.fromJson(Map<String, dynamic> json) => _$ZoneInfoFromJson(json);
}

@freezed
class ContractInfo with _$ContractInfo {
  const factory ContractInfo({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "reference") String? reference,
  }) = _ContractInfo;

  factory ContractInfo.fromJson(Map<String, dynamic> json) => _$ContractInfoFromJson(json);
}
