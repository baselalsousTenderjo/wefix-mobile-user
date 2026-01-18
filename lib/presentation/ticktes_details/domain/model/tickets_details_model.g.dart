// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketsDetailsModelImpl _$$TicketsDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TicketsDetailsModelImpl(
      ticketsDetails: json['objTickets'] == null
          ? null
          : TicketsDetails.fromJson(json['objTickets'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TicketsDetailsModelImplToJson(
        _$TicketsDetailsModelImpl instance) =>
    <String, dynamic>{
      'objTickets': instance.ticketsDetails,
    };

_$TicketsDetailsImpl _$$TicketsDetailsImplFromJson(Map<String, dynamic> json) =>
    _$TicketsDetailsImpl(
      id: (json['id'] as num?)?.toInt(),
      ticketCodeId: json['ticketCodeId'] as String?,
      title: json['title'] as String?,
      time: json['time'] as String?,
      titleAr: json['titleAr'] as String?,
      type: json['type'] as String?,
      typeAr: json['typeAr'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      timeTo: json['timeTo'] as String?,
      reportLink: json['reportLink'] as String?,
      status: json['status'] as String?,
      statusAr: json['statusAr'] as String?,
      customerName: json['customerName'] as String?,
      customerImage: json['customerImage'] as String?,
      customerAddress: json['customerAddress'] as String?,
      description: json['description'] as String?,
      serviceDescription: json['serviceDescription'] as String?,
      isWithMaterial: json['isWithMaterial'] as bool?,
      isWithFemale: json['isWithFemale'] as bool?,
      latitudel: json['latitudel'] as String?,
      longitude: json['longitude'] as String?,
      mobile: json['mobile'] as String?,
      esitmatedTime: json['esitmatedTime'] as String?,
      ticketAttatchments: (json['ticketAttatchments'] as List<dynamic>?)
          ?.map((e) => TicketAttatchment.fromJson(e as Map<String, dynamic>))
          .toList(),
      technicianAttachments: (json['technicianAttachments'] as List<dynamic>?)
          ?.map((e) => TicketAttatchment.fromJson(e as Map<String, dynamic>))
          .toList(),
      ticketTools: (json['ticketTools'] as List<dynamic>?)
          ?.map((e) => TicketTool.fromJson(e as Map<String, dynamic>))
          .toList(),
      ticketImages: (json['ticketImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ticketMaterials: (json['ticketMaterials'] as List<dynamic>?)
          ?.map((e) => TicketMaterial.fromJson(e as Map<String, dynamic>))
          .toList(),
      maintenanceTickets: (json['maintenanceTickets'] as List<dynamic>?)
          ?.map((e) => MaintenanceTicket.fromJson(e as Map<String, dynamic>))
          .toList(),
      serviceTickets: (json['servcieTickets'] as List<dynamic>?)
          ?.map((e) => ServiceTicket.fromJson(e as Map<String, dynamic>))
          .toList(),
      advantageTickets: (json['advantageTickets'] as List<dynamic>?)
          ?.map((e) => AdvantageTickets.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainService: json['mainService'] == null
          ? null
          : MainServiceInfo.fromJson(
              json['mainService'] as Map<String, dynamic>),
      subService: json['subService'] == null
          ? null
          : SubServiceInfo.fromJson(json['subService'] as Map<String, dynamic>),
      createdBy: (json['createdBy'] as num?)?.toInt(),
      creator: json['creator'] == null
          ? null
          : CreatorInfo.fromJson(json['creator'] as Map<String, dynamic>),
      company: json['company'] as Map<String, dynamic>?,
      branch: json['branch'] as Map<String, dynamic>?,
      zone: json['zone'] as Map<String, dynamic>?,
      teamLeader: json['teamLeader'] as Map<String, dynamic>?,
      technician: json['technician'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$TicketsDetailsImplToJson(
        _$TicketsDetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticketCodeId': instance.ticketCodeId,
      'title': instance.title,
      'time': instance.time,
      'titleAr': instance.titleAr,
      'type': instance.type,
      'typeAr': instance.typeAr,
      'userId': instance.userId,
      'date': instance.date?.toIso8601String(),
      'timeTo': instance.timeTo,
      'reportLink': instance.reportLink,
      'status': instance.status,
      'statusAr': instance.statusAr,
      'customerName': instance.customerName,
      'customerImage': instance.customerImage,
      'customerAddress': instance.customerAddress,
      'description': instance.description,
      'serviceDescription': instance.serviceDescription,
      'isWithMaterial': instance.isWithMaterial,
      'isWithFemale': instance.isWithFemale,
      'latitudel': instance.latitudel,
      'longitude': instance.longitude,
      'mobile': instance.mobile,
      'esitmatedTime': instance.esitmatedTime,
      'ticketAttatchments': instance.ticketAttatchments,
      'technicianAttachments': instance.technicianAttachments,
      'ticketTools': instance.ticketTools,
      'ticketImages': instance.ticketImages,
      'ticketMaterials': instance.ticketMaterials,
      'maintenanceTickets': instance.maintenanceTickets,
      'servcieTickets': instance.serviceTickets,
      'advantageTickets': instance.advantageTickets,
      'mainService': instance.mainService,
      'subService': instance.subService,
      'createdBy': instance.createdBy,
      'creator': instance.creator,
      'company': instance.company,
      'branch': instance.branch,
      'zone': instance.zone,
      'teamLeader': instance.teamLeader,
      'technician': instance.technician,
    };

_$TicketAttatchmentImpl _$$TicketAttatchmentImplFromJson(
        Map<String, dynamic> json) =>
    _$TicketAttatchmentImpl(
      id: (json['id'] as num?)?.toInt(),
      ticketId: (json['ticketId'] as num?)?.toInt(),
      size: json['size'],
      fileName: json['fileName'],
      filePath: json['filePath'] as String?,
      type: json['type'],
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      ticket: json['ticket'],
    );

Map<String, dynamic> _$$TicketAttatchmentImplToJson(
        _$TicketAttatchmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticketId': instance.ticketId,
      'size': instance.size,
      'fileName': instance.fileName,
      'filePath': instance.filePath,
      'type': instance.type,
      'createdDate': instance.createdDate?.toIso8601String(),
      'ticket': instance.ticket,
    };

_$TicketMaterialImpl _$$TicketMaterialImplFromJson(Map<String, dynamic> json) =>
    _$TicketMaterialImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      titleAr: json['titleAr'] as String?,
      status: json['status'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      iSselected: json['iSselected'] as bool?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TicketMaterialImplToJson(
        _$TicketMaterialImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'titleAr': instance.titleAr,
      'status': instance.status,
      'price': instance.price,
      'iSselected': instance.iSselected,
      'quantity': instance.quantity,
    };

_$TicketToolImpl _$$TicketToolImplFromJson(Map<String, dynamic> json) =>
    _$TicketToolImpl(
      id: (json['id'] as num?)?.toInt(),
      toolId: (json['toolId'] as num?)?.toInt(),
      title: json['title'] as String?,
      titleAr: json['titleAr'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      isSelect: json['isSelect'] as bool? ?? false,
    );

Map<String, dynamic> _$$TicketToolImplToJson(_$TicketToolImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'toolId': instance.toolId,
      'title': instance.title,
      'titleAr': instance.titleAr,
      'quantity': instance.quantity,
      'isSelect': instance.isSelect,
    };

_$MaintenanceTicketImpl _$$MaintenanceTicketImplFromJson(
        Map<String, dynamic> json) =>
    _$MaintenanceTicketImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameAr: json['nameAr'] as String?,
      description: json['description'] as String?,
      note: json['note'],
    );

Map<String, dynamic> _$$MaintenanceTicketImplToJson(
        _$MaintenanceTicketImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'description': instance.description,
      'note': instance.note,
    };

_$ServiceTicketImpl _$$ServiceTicketImplFromJson(Map<String, dynamic> json) =>
    _$ServiceTicketImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameAr: json['nameAr'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ServiceTicketImplToJson(_$ServiceTicketImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'image': instance.image,
      'price': instance.price,
      'quantity': instance.quantity,
    };

_$AadvantageTicketsImpl _$$AadvantageTicketsImplFromJson(
        Map<String, dynamic> json) =>
    _$AadvantageTicketsImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameAr: json['nameAr'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AadvantageTicketsImplToJson(
        _$AadvantageTicketsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'price': instance.price,
    };

_$CreatorInfoImpl _$$CreatorInfoImplFromJson(Map<String, dynamic> json) =>
    _$CreatorInfoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEnglish: json['nameEnglish'] as String?,
      userNumber: json['userNumber'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      countryCode: json['countryCode'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$CreatorInfoImplToJson(_$CreatorInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameEnglish': instance.nameEnglish,
      'userNumber': instance.userNumber,
      'mobileNumber': instance.mobileNumber,
      'countryCode': instance.countryCode,
      'image': instance.image,
    };
