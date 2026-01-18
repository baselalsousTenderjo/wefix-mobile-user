// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeModelImpl _$$HomeModelImplFromJson(Map<String, dynamic> json) =>
    _$HomeModelImpl(
      tickets: (json['tickets'] as List<dynamic>?)
          ?.map((e) => Tickets.fromJson(e as Map<String, dynamic>))
          .toList(),
      ticketsTomorrow: (json['ticketsTomorrow'] as List<dynamic>?)
          ?.map((e) => Tickets.fromJson(e as Map<String, dynamic>))
          .toList(),
      emergency: (json['emergency'] as List<dynamic>?)
          ?.map((e) => Tickets.fromJson(e as Map<String, dynamic>))
          .toList(),
      technician: json['technician'] == null
          ? null
          : TechnicianInfo.fromJson(json['technician'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HomeModelImplToJson(_$HomeModelImpl instance) =>
    <String, dynamic>{
      'tickets': instance.tickets,
      'ticketsTomorrow': instance.ticketsTomorrow,
      'emergency': instance.emergency,
      'technician': instance.technician,
    };

_$TechnicianInfoImpl _$$TechnicianInfoImplFromJson(Map<String, dynamic> json) =>
    _$TechnicianInfoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEnglish: json['nameEnglish'] as String?,
      image: json['image'] as String?,
      company: json['company'] == null
          ? null
          : CompanyInfo.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TechnicianInfoImplToJson(
        _$TechnicianInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameEnglish': instance.nameEnglish,
      'image': instance.image,
      'company': instance.company,
    };

_$CompanyInfoImpl _$$CompanyInfoImplFromJson(Map<String, dynamic> json) =>
    _$CompanyInfoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameArabic: json['nameArabic'] as String?,
      nameEnglish: json['nameEnglish'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$$CompanyInfoImplToJson(_$CompanyInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameArabic': instance.nameArabic,
      'nameEnglish': instance.nameEnglish,
      'logo': instance.logo,
    };

_$TicketsImpl _$$TicketsImplFromJson(Map<String, dynamic> json) =>
    _$TicketsImpl(
      id: (json['id'] as num?)?.toInt(),
      ticketCodeId: json['ticketCodeId'] as String?,
      image: json['image'] as String?,
      customer: json['customer'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      status: json['status'] as String?,
      statusAr: json['statusAr'] as String?,
      time: json['time'] as String?,
      ticketType: json['ticketType'] as String?,
      ticketTypeAr: json['ticketTypeAr'] as String?,
      ticketTitle: json['ticketTitle'] as String?,
      ticketDescription: json['ticketDescription'] as String?,
      serviceDescription: json['serviceDescription'] as String?,
      locationMap: json['locationMap'] as String?,
      havingFemaleEngineer: json['havingFemaleEngineer'] as bool?,
      withMaterial: json['withMaterial'] as bool?,
      tools: (json['tools'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      ticketTimeTo: json['ticketTimeTo'] as String?,
      mainService: json['mainService'] == null
          ? null
          : MainServiceInfo.fromJson(
              json['mainService'] as Map<String, dynamic>),
      subService: json['subService'] == null
          ? null
          : SubServiceInfo.fromJson(json['subService'] as Map<String, dynamic>),
      branch: json['branch'] == null
          ? null
          : BranchInfo.fromJson(json['branch'] as Map<String, dynamic>),
      zone: json['zone'] == null
          ? null
          : ZoneInfo.fromJson(json['zone'] as Map<String, dynamic>),
      contract: json['contract'] == null
          ? null
          : ContractInfo.fromJson(json['contract'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TicketsImplToJson(_$TicketsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticketCodeId': instance.ticketCodeId,
      'image': instance.image,
      'customer': instance.customer,
      'date': instance.date?.toIso8601String(),
      'status': instance.status,
      'statusAr': instance.statusAr,
      'time': instance.time,
      'ticketType': instance.ticketType,
      'ticketTypeAr': instance.ticketTypeAr,
      'ticketTitle': instance.ticketTitle,
      'ticketDescription': instance.ticketDescription,
      'serviceDescription': instance.serviceDescription,
      'locationMap': instance.locationMap,
      'havingFemaleEngineer': instance.havingFemaleEngineer,
      'withMaterial': instance.withMaterial,
      'tools': instance.tools,
      'ticketTimeTo': instance.ticketTimeTo,
      'mainService': instance.mainService,
      'subService': instance.subService,
      'branch': instance.branch,
      'zone': instance.zone,
      'contract': instance.contract,
    };

_$MainServiceInfoImpl _$$MainServiceInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$MainServiceInfoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameArabic: json['nameArabic'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$MainServiceInfoImplToJson(
        _$MainServiceInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameArabic': instance.nameArabic,
      'image': instance.image,
    };

_$SubServiceInfoImpl _$$SubServiceInfoImplFromJson(Map<String, dynamic> json) =>
    _$SubServiceInfoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameArabic: json['nameArabic'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$SubServiceInfoImplToJson(
        _$SubServiceInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameArabic': instance.nameArabic,
      'image': instance.image,
    };

_$BranchInfoImpl _$$BranchInfoImplFromJson(Map<String, dynamic> json) =>
    _$BranchInfoImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      nameArabic: json['nameArabic'] as String?,
      nameEnglish: json['nameEnglish'] as String?,
    );

Map<String, dynamic> _$$BranchInfoImplToJson(_$BranchInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'nameArabic': instance.nameArabic,
      'nameEnglish': instance.nameEnglish,
    };

_$ZoneInfoImpl _$$ZoneInfoImplFromJson(Map<String, dynamic> json) =>
    _$ZoneInfoImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      number: json['number'] as String?,
    );

Map<String, dynamic> _$$ZoneInfoImplToJson(_$ZoneInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'number': instance.number,
    };

_$ContractInfoImpl _$$ContractInfoImplFromJson(Map<String, dynamic> json) =>
    _$ContractInfoImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$$ContractInfoImplToJson(_$ContractInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'reference': instance.reference,
    };
