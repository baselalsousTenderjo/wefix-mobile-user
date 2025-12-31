// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tickets_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TicketsDetailsModel _$TicketsDetailsModelFromJson(Map<String, dynamic> json) {
  return _TicketsDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$TicketsDetailsModel {
  @JsonKey(name: "objTickets")
  TicketsDetails? get ticketsDetails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TicketsDetailsModelCopyWith<TicketsDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketsDetailsModelCopyWith<$Res> {
  factory $TicketsDetailsModelCopyWith(
          TicketsDetailsModel value, $Res Function(TicketsDetailsModel) then) =
      _$TicketsDetailsModelCopyWithImpl<$Res, TicketsDetailsModel>;
  @useResult
  $Res call({@JsonKey(name: "objTickets") TicketsDetails? ticketsDetails});

  $TicketsDetailsCopyWith<$Res>? get ticketsDetails;
}

/// @nodoc
class _$TicketsDetailsModelCopyWithImpl<$Res, $Val extends TicketsDetailsModel>
    implements $TicketsDetailsModelCopyWith<$Res> {
  _$TicketsDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketsDetails = freezed,
  }) {
    return _then(_value.copyWith(
      ticketsDetails: freezed == ticketsDetails
          ? _value.ticketsDetails
          : ticketsDetails // ignore: cast_nullable_to_non_nullable
              as TicketsDetails?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TicketsDetailsCopyWith<$Res>? get ticketsDetails {
    if (_value.ticketsDetails == null) {
      return null;
    }

    return $TicketsDetailsCopyWith<$Res>(_value.ticketsDetails!, (value) {
      return _then(_value.copyWith(ticketsDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TicketsDetailsModelImplCopyWith<$Res>
    implements $TicketsDetailsModelCopyWith<$Res> {
  factory _$$TicketsDetailsModelImplCopyWith(_$TicketsDetailsModelImpl value,
          $Res Function(_$TicketsDetailsModelImpl) then) =
      __$$TicketsDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "objTickets") TicketsDetails? ticketsDetails});

  @override
  $TicketsDetailsCopyWith<$Res>? get ticketsDetails;
}

/// @nodoc
class __$$TicketsDetailsModelImplCopyWithImpl<$Res>
    extends _$TicketsDetailsModelCopyWithImpl<$Res, _$TicketsDetailsModelImpl>
    implements _$$TicketsDetailsModelImplCopyWith<$Res> {
  __$$TicketsDetailsModelImplCopyWithImpl(_$TicketsDetailsModelImpl _value,
      $Res Function(_$TicketsDetailsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketsDetails = freezed,
  }) {
    return _then(_$TicketsDetailsModelImpl(
      ticketsDetails: freezed == ticketsDetails
          ? _value.ticketsDetails
          : ticketsDetails // ignore: cast_nullable_to_non_nullable
              as TicketsDetails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketsDetailsModelImpl implements _TicketsDetailsModel {
  const _$TicketsDetailsModelImpl(
      {@JsonKey(name: "objTickets") this.ticketsDetails});

  factory _$TicketsDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketsDetailsModelImplFromJson(json);

  @override
  @JsonKey(name: "objTickets")
  final TicketsDetails? ticketsDetails;

  @override
  String toString() {
    return 'TicketsDetailsModel(ticketsDetails: $ticketsDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketsDetailsModelImpl &&
            (identical(other.ticketsDetails, ticketsDetails) ||
                other.ticketsDetails == ticketsDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ticketsDetails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketsDetailsModelImplCopyWith<_$TicketsDetailsModelImpl> get copyWith =>
      __$$TicketsDetailsModelImplCopyWithImpl<_$TicketsDetailsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketsDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _TicketsDetailsModel implements TicketsDetailsModel {
  const factory _TicketsDetailsModel(
          {@JsonKey(name: "objTickets") final TicketsDetails? ticketsDetails}) =
      _$TicketsDetailsModelImpl;

  factory _TicketsDetailsModel.fromJson(Map<String, dynamic> json) =
      _$TicketsDetailsModelImpl.fromJson;

  @override
  @JsonKey(name: "objTickets")
  TicketsDetails? get ticketsDetails;
  @override
  @JsonKey(ignore: true)
  _$$TicketsDetailsModelImplCopyWith<_$TicketsDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TicketsDetails _$TicketsDetailsFromJson(Map<String, dynamic> json) {
  return _TicketsDetails.fromJson(json);
}

/// @nodoc
mixin _$TicketsDetails {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketCodeId")
  String? get ticketCodeId => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: "time")
  String? get time => throw _privateConstructorUsedError;
  @JsonKey(name: "titleAr")
  String? get titleAr => throw _privateConstructorUsedError;
  @JsonKey(name: "type")
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "typeAr")
  String? get typeAr => throw _privateConstructorUsedError;
  @JsonKey(name: "userId")
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "date")
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: "reportLink")
  String? get reportLink => throw _privateConstructorUsedError;
  @JsonKey(name: "status")
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: "customerName")
  String? get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: "customerImage")
  String? get customerImage => throw _privateConstructorUsedError;
  @JsonKey(name: "customerAddress")
  String? get customerAddress => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "serviceDescription")
  String? get serviceDescription => throw _privateConstructorUsedError;
  @JsonKey(name: "isWithMaterial")
  bool? get isWithMaterial => throw _privateConstructorUsedError;
  @JsonKey(name: "isWithFemale")
  bool? get isWithFemale => throw _privateConstructorUsedError;
  @JsonKey(name: "latitudel")
  String? get latitudel => throw _privateConstructorUsedError;
  @JsonKey(name: "longitude")
  String? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: "mobile")
  String? get mobile => throw _privateConstructorUsedError;
  @JsonKey(name: "esitmatedTime")
  String? get esitmatedTime => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketAttatchments")
  List<TicketAttatchment>? get ticketAttatchments =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "technicianAttachments")
  List<TicketAttatchment>? get technicianAttachments =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "ticketTools")
  List<TicketTool>? get ticketTools => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketImages")
  List<String>? get ticketImages => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketMaterials")
  List<TicketMaterial>? get ticketMaterials =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "maintenanceTickets")
  List<MaintenanceTicket>? get maintenanceTickets =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "servcieTickets")
  List<ServiceTicket>? get serviceTickets => throw _privateConstructorUsedError;
  @JsonKey(name: "advantageTickets")
  List<AdvantageTickets>? get advantageTickets =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "createdBy")
  int? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: "creator")
  CreatorInfo? get creator => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TicketsDetailsCopyWith<TicketsDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketsDetailsCopyWith<$Res> {
  factory $TicketsDetailsCopyWith(
          TicketsDetails value, $Res Function(TicketsDetails) then) =
      _$TicketsDetailsCopyWithImpl<$Res, TicketsDetails>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "ticketCodeId") String? ticketCodeId,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "time") String? time,
      @JsonKey(name: "titleAr") String? titleAr,
      @JsonKey(name: "type") String? type,
      @JsonKey(name: "typeAr") String? typeAr,
      @JsonKey(name: "userId") int? userId,
      @JsonKey(name: "date") DateTime? date,
      @JsonKey(name: "reportLink") String? reportLink,
      @JsonKey(name: "status") String? status,
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
      @JsonKey(name: "ticketAttatchments")
      List<TicketAttatchment>? ticketAttatchments,
      @JsonKey(name: "technicianAttachments")
      List<TicketAttatchment>? technicianAttachments,
      @JsonKey(name: "ticketTools") List<TicketTool>? ticketTools,
      @JsonKey(name: "ticketImages") List<String>? ticketImages,
      @JsonKey(name: "ticketMaterials") List<TicketMaterial>? ticketMaterials,
      @JsonKey(name: "maintenanceTickets")
      List<MaintenanceTicket>? maintenanceTickets,
      @JsonKey(name: "servcieTickets") List<ServiceTicket>? serviceTickets,
      @JsonKey(name: "advantageTickets")
      List<AdvantageTickets>? advantageTickets,
      @JsonKey(name: "createdBy") int? createdBy,
      @JsonKey(name: "creator") CreatorInfo? creator});

  $CreatorInfoCopyWith<$Res>? get creator;
}

/// @nodoc
class _$TicketsDetailsCopyWithImpl<$Res, $Val extends TicketsDetails>
    implements $TicketsDetailsCopyWith<$Res> {
  _$TicketsDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ticketCodeId = freezed,
    Object? title = freezed,
    Object? time = freezed,
    Object? titleAr = freezed,
    Object? type = freezed,
    Object? typeAr = freezed,
    Object? userId = freezed,
    Object? date = freezed,
    Object? reportLink = freezed,
    Object? status = freezed,
    Object? customerName = freezed,
    Object? customerImage = freezed,
    Object? customerAddress = freezed,
    Object? description = freezed,
    Object? serviceDescription = freezed,
    Object? isWithMaterial = freezed,
    Object? isWithFemale = freezed,
    Object? latitudel = freezed,
    Object? longitude = freezed,
    Object? mobile = freezed,
    Object? esitmatedTime = freezed,
    Object? ticketAttatchments = freezed,
    Object? technicianAttachments = freezed,
    Object? ticketTools = freezed,
    Object? ticketImages = freezed,
    Object? ticketMaterials = freezed,
    Object? maintenanceTickets = freezed,
    Object? serviceTickets = freezed,
    Object? advantageTickets = freezed,
    Object? createdBy = freezed,
    Object? creator = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      ticketCodeId: freezed == ticketCodeId
          ? _value.ticketCodeId
          : ticketCodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      titleAr: freezed == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      typeAr: freezed == typeAr
          ? _value.typeAr
          : typeAr // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reportLink: freezed == reportLink
          ? _value.reportLink
          : reportLink // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerImage: freezed == customerImage
          ? _value.customerImage
          : customerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      customerAddress: freezed == customerAddress
          ? _value.customerAddress
          : customerAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceDescription: freezed == serviceDescription
          ? _value.serviceDescription
          : serviceDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      isWithMaterial: freezed == isWithMaterial
          ? _value.isWithMaterial
          : isWithMaterial // ignore: cast_nullable_to_non_nullable
              as bool?,
      isWithFemale: freezed == isWithFemale
          ? _value.isWithFemale
          : isWithFemale // ignore: cast_nullable_to_non_nullable
              as bool?,
      latitudel: freezed == latitudel
          ? _value.latitudel
          : latitudel // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      esitmatedTime: freezed == esitmatedTime
          ? _value.esitmatedTime
          : esitmatedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketAttatchments: freezed == ticketAttatchments
          ? _value.ticketAttatchments
          : ticketAttatchments // ignore: cast_nullable_to_non_nullable
              as List<TicketAttatchment>?,
      technicianAttachments: freezed == technicianAttachments
          ? _value.technicianAttachments
          : technicianAttachments // ignore: cast_nullable_to_non_nullable
              as List<TicketAttatchment>?,
      ticketTools: freezed == ticketTools
          ? _value.ticketTools
          : ticketTools // ignore: cast_nullable_to_non_nullable
              as List<TicketTool>?,
      ticketImages: freezed == ticketImages
          ? _value.ticketImages
          : ticketImages // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      ticketMaterials: freezed == ticketMaterials
          ? _value.ticketMaterials
          : ticketMaterials // ignore: cast_nullable_to_non_nullable
              as List<TicketMaterial>?,
      maintenanceTickets: freezed == maintenanceTickets
          ? _value.maintenanceTickets
          : maintenanceTickets // ignore: cast_nullable_to_non_nullable
              as List<MaintenanceTicket>?,
      serviceTickets: freezed == serviceTickets
          ? _value.serviceTickets
          : serviceTickets // ignore: cast_nullable_to_non_nullable
              as List<ServiceTicket>?,
      advantageTickets: freezed == advantageTickets
          ? _value.advantageTickets
          : advantageTickets // ignore: cast_nullable_to_non_nullable
              as List<AdvantageTickets>?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as int?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as CreatorInfo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CreatorInfoCopyWith<$Res>? get creator {
    if (_value.creator == null) {
      return null;
    }

    return $CreatorInfoCopyWith<$Res>(_value.creator!, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TicketsDetailsImplCopyWith<$Res>
    implements $TicketsDetailsCopyWith<$Res> {
  factory _$$TicketsDetailsImplCopyWith(_$TicketsDetailsImpl value,
          $Res Function(_$TicketsDetailsImpl) then) =
      __$$TicketsDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "ticketCodeId") String? ticketCodeId,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "time") String? time,
      @JsonKey(name: "titleAr") String? titleAr,
      @JsonKey(name: "type") String? type,
      @JsonKey(name: "typeAr") String? typeAr,
      @JsonKey(name: "userId") int? userId,
      @JsonKey(name: "date") DateTime? date,
      @JsonKey(name: "reportLink") String? reportLink,
      @JsonKey(name: "status") String? status,
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
      @JsonKey(name: "ticketAttatchments")
      List<TicketAttatchment>? ticketAttatchments,
      @JsonKey(name: "technicianAttachments")
      List<TicketAttatchment>? technicianAttachments,
      @JsonKey(name: "ticketTools") List<TicketTool>? ticketTools,
      @JsonKey(name: "ticketImages") List<String>? ticketImages,
      @JsonKey(name: "ticketMaterials") List<TicketMaterial>? ticketMaterials,
      @JsonKey(name: "maintenanceTickets")
      List<MaintenanceTicket>? maintenanceTickets,
      @JsonKey(name: "servcieTickets") List<ServiceTicket>? serviceTickets,
      @JsonKey(name: "advantageTickets")
      List<AdvantageTickets>? advantageTickets,
      @JsonKey(name: "createdBy") int? createdBy,
      @JsonKey(name: "creator") CreatorInfo? creator});

  @override
  $CreatorInfoCopyWith<$Res>? get creator;
}

/// @nodoc
class __$$TicketsDetailsImplCopyWithImpl<$Res>
    extends _$TicketsDetailsCopyWithImpl<$Res, _$TicketsDetailsImpl>
    implements _$$TicketsDetailsImplCopyWith<$Res> {
  __$$TicketsDetailsImplCopyWithImpl(
      _$TicketsDetailsImpl _value, $Res Function(_$TicketsDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ticketCodeId = freezed,
    Object? title = freezed,
    Object? time = freezed,
    Object? titleAr = freezed,
    Object? type = freezed,
    Object? typeAr = freezed,
    Object? userId = freezed,
    Object? date = freezed,
    Object? reportLink = freezed,
    Object? status = freezed,
    Object? customerName = freezed,
    Object? customerImage = freezed,
    Object? customerAddress = freezed,
    Object? description = freezed,
    Object? serviceDescription = freezed,
    Object? isWithMaterial = freezed,
    Object? isWithFemale = freezed,
    Object? latitudel = freezed,
    Object? longitude = freezed,
    Object? mobile = freezed,
    Object? esitmatedTime = freezed,
    Object? ticketAttatchments = freezed,
    Object? technicianAttachments = freezed,
    Object? ticketTools = freezed,
    Object? ticketImages = freezed,
    Object? ticketMaterials = freezed,
    Object? maintenanceTickets = freezed,
    Object? serviceTickets = freezed,
    Object? advantageTickets = freezed,
    Object? createdBy = freezed,
    Object? creator = freezed,
  }) {
    return _then(_$TicketsDetailsImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      ticketCodeId: freezed == ticketCodeId
          ? _value.ticketCodeId
          : ticketCodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      titleAr: freezed == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      typeAr: freezed == typeAr
          ? _value.typeAr
          : typeAr // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reportLink: freezed == reportLink
          ? _value.reportLink
          : reportLink // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerImage: freezed == customerImage
          ? _value.customerImage
          : customerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      customerAddress: freezed == customerAddress
          ? _value.customerAddress
          : customerAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceDescription: freezed == serviceDescription
          ? _value.serviceDescription
          : serviceDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      isWithMaterial: freezed == isWithMaterial
          ? _value.isWithMaterial
          : isWithMaterial // ignore: cast_nullable_to_non_nullable
              as bool?,
      isWithFemale: freezed == isWithFemale
          ? _value.isWithFemale
          : isWithFemale // ignore: cast_nullable_to_non_nullable
              as bool?,
      latitudel: freezed == latitudel
          ? _value.latitudel
          : latitudel // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      esitmatedTime: freezed == esitmatedTime
          ? _value.esitmatedTime
          : esitmatedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketAttatchments: freezed == ticketAttatchments
          ? _value._ticketAttatchments
          : ticketAttatchments // ignore: cast_nullable_to_non_nullable
              as List<TicketAttatchment>?,
      technicianAttachments: freezed == technicianAttachments
          ? _value._technicianAttachments
          : technicianAttachments // ignore: cast_nullable_to_non_nullable
              as List<TicketAttatchment>?,
      ticketTools: freezed == ticketTools
          ? _value._ticketTools
          : ticketTools // ignore: cast_nullable_to_non_nullable
              as List<TicketTool>?,
      ticketImages: freezed == ticketImages
          ? _value._ticketImages
          : ticketImages // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      ticketMaterials: freezed == ticketMaterials
          ? _value._ticketMaterials
          : ticketMaterials // ignore: cast_nullable_to_non_nullable
              as List<TicketMaterial>?,
      maintenanceTickets: freezed == maintenanceTickets
          ? _value._maintenanceTickets
          : maintenanceTickets // ignore: cast_nullable_to_non_nullable
              as List<MaintenanceTicket>?,
      serviceTickets: freezed == serviceTickets
          ? _value._serviceTickets
          : serviceTickets // ignore: cast_nullable_to_non_nullable
              as List<ServiceTicket>?,
      advantageTickets: freezed == advantageTickets
          ? _value._advantageTickets
          : advantageTickets // ignore: cast_nullable_to_non_nullable
              as List<AdvantageTickets>?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as int?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as CreatorInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketsDetailsImpl implements _TicketsDetails {
  const _$TicketsDetailsImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "ticketCodeId") this.ticketCodeId,
      @JsonKey(name: "title") this.title,
      @JsonKey(name: "time") this.time,
      @JsonKey(name: "titleAr") this.titleAr,
      @JsonKey(name: "type") this.type,
      @JsonKey(name: "typeAr") this.typeAr,
      @JsonKey(name: "userId") this.userId,
      @JsonKey(name: "date") this.date,
      @JsonKey(name: "reportLink") this.reportLink,
      @JsonKey(name: "status") this.status,
      @JsonKey(name: "customerName") this.customerName,
      @JsonKey(name: "customerImage") this.customerImage,
      @JsonKey(name: "customerAddress") this.customerAddress,
      @JsonKey(name: "description") this.description,
      @JsonKey(name: "serviceDescription") this.serviceDescription,
      @JsonKey(name: "isWithMaterial") this.isWithMaterial,
      @JsonKey(name: "isWithFemale") this.isWithFemale,
      @JsonKey(name: "latitudel") this.latitudel,
      @JsonKey(name: "longitude") this.longitude,
      @JsonKey(name: "mobile") this.mobile,
      @JsonKey(name: "esitmatedTime") this.esitmatedTime,
      @JsonKey(name: "ticketAttatchments")
      final List<TicketAttatchment>? ticketAttatchments,
      @JsonKey(name: "technicianAttachments")
      final List<TicketAttatchment>? technicianAttachments,
      @JsonKey(name: "ticketTools") final List<TicketTool>? ticketTools,
      @JsonKey(name: "ticketImages") final List<String>? ticketImages,
      @JsonKey(name: "ticketMaterials")
      final List<TicketMaterial>? ticketMaterials,
      @JsonKey(name: "maintenanceTickets")
      final List<MaintenanceTicket>? maintenanceTickets,
      @JsonKey(name: "servcieTickets")
      final List<ServiceTicket>? serviceTickets,
      @JsonKey(name: "advantageTickets")
      final List<AdvantageTickets>? advantageTickets,
      @JsonKey(name: "createdBy") this.createdBy,
      @JsonKey(name: "creator") this.creator})
      : _ticketAttatchments = ticketAttatchments,
        _technicianAttachments = technicianAttachments,
        _ticketTools = ticketTools,
        _ticketImages = ticketImages,
        _ticketMaterials = ticketMaterials,
        _maintenanceTickets = maintenanceTickets,
        _serviceTickets = serviceTickets,
        _advantageTickets = advantageTickets;

  factory _$TicketsDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketsDetailsImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "ticketCodeId")
  final String? ticketCodeId;
  @override
  @JsonKey(name: "title")
  final String? title;
  @override
  @JsonKey(name: "time")
  final String? time;
  @override
  @JsonKey(name: "titleAr")
  final String? titleAr;
  @override
  @JsonKey(name: "type")
  final String? type;
  @override
  @JsonKey(name: "typeAr")
  final String? typeAr;
  @override
  @JsonKey(name: "userId")
  final int? userId;
  @override
  @JsonKey(name: "date")
  final DateTime? date;
  @override
  @JsonKey(name: "reportLink")
  final String? reportLink;
  @override
  @JsonKey(name: "status")
  final String? status;
  @override
  @JsonKey(name: "customerName")
  final String? customerName;
  @override
  @JsonKey(name: "customerImage")
  final String? customerImage;
  @override
  @JsonKey(name: "customerAddress")
  final String? customerAddress;
  @override
  @JsonKey(name: "description")
  final String? description;
  @override
  @JsonKey(name: "serviceDescription")
  final String? serviceDescription;
  @override
  @JsonKey(name: "isWithMaterial")
  final bool? isWithMaterial;
  @override
  @JsonKey(name: "isWithFemale")
  final bool? isWithFemale;
  @override
  @JsonKey(name: "latitudel")
  final String? latitudel;
  @override
  @JsonKey(name: "longitude")
  final String? longitude;
  @override
  @JsonKey(name: "mobile")
  final String? mobile;
  @override
  @JsonKey(name: "esitmatedTime")
  final String? esitmatedTime;
  final List<TicketAttatchment>? _ticketAttatchments;
  @override
  @JsonKey(name: "ticketAttatchments")
  List<TicketAttatchment>? get ticketAttatchments {
    final value = _ticketAttatchments;
    if (value == null) return null;
    if (_ticketAttatchments is EqualUnmodifiableListView)
      return _ticketAttatchments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TicketAttatchment>? _technicianAttachments;
  @override
  @JsonKey(name: "technicianAttachments")
  List<TicketAttatchment>? get technicianAttachments {
    final value = _technicianAttachments;
    if (value == null) return null;
    if (_technicianAttachments is EqualUnmodifiableListView)
      return _technicianAttachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TicketTool>? _ticketTools;
  @override
  @JsonKey(name: "ticketTools")
  List<TicketTool>? get ticketTools {
    final value = _ticketTools;
    if (value == null) return null;
    if (_ticketTools is EqualUnmodifiableListView) return _ticketTools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _ticketImages;
  @override
  @JsonKey(name: "ticketImages")
  List<String>? get ticketImages {
    final value = _ticketImages;
    if (value == null) return null;
    if (_ticketImages is EqualUnmodifiableListView) return _ticketImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TicketMaterial>? _ticketMaterials;
  @override
  @JsonKey(name: "ticketMaterials")
  List<TicketMaterial>? get ticketMaterials {
    final value = _ticketMaterials;
    if (value == null) return null;
    if (_ticketMaterials is EqualUnmodifiableListView) return _ticketMaterials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<MaintenanceTicket>? _maintenanceTickets;
  @override
  @JsonKey(name: "maintenanceTickets")
  List<MaintenanceTicket>? get maintenanceTickets {
    final value = _maintenanceTickets;
    if (value == null) return null;
    if (_maintenanceTickets is EqualUnmodifiableListView)
      return _maintenanceTickets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ServiceTicket>? _serviceTickets;
  @override
  @JsonKey(name: "servcieTickets")
  List<ServiceTicket>? get serviceTickets {
    final value = _serviceTickets;
    if (value == null) return null;
    if (_serviceTickets is EqualUnmodifiableListView) return _serviceTickets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<AdvantageTickets>? _advantageTickets;
  @override
  @JsonKey(name: "advantageTickets")
  List<AdvantageTickets>? get advantageTickets {
    final value = _advantageTickets;
    if (value == null) return null;
    if (_advantageTickets is EqualUnmodifiableListView)
      return _advantageTickets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "createdBy")
  final int? createdBy;
  @override
  @JsonKey(name: "creator")
  final CreatorInfo? creator;

  @override
  String toString() {
    return 'TicketsDetails(id: $id, ticketCodeId: $ticketCodeId, title: $title, time: $time, titleAr: $titleAr, type: $type, typeAr: $typeAr, userId: $userId, date: $date, reportLink: $reportLink, status: $status, customerName: $customerName, customerImage: $customerImage, customerAddress: $customerAddress, description: $description, serviceDescription: $serviceDescription, isWithMaterial: $isWithMaterial, isWithFemale: $isWithFemale, latitudel: $latitudel, longitude: $longitude, mobile: $mobile, esitmatedTime: $esitmatedTime, ticketAttatchments: $ticketAttatchments, technicianAttachments: $technicianAttachments, ticketTools: $ticketTools, ticketImages: $ticketImages, ticketMaterials: $ticketMaterials, maintenanceTickets: $maintenanceTickets, serviceTickets: $serviceTickets, advantageTickets: $advantageTickets, createdBy: $createdBy, creator: $creator)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketsDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ticketCodeId, ticketCodeId) ||
                other.ticketCodeId == ticketCodeId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.titleAr, titleAr) || other.titleAr == titleAr) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.typeAr, typeAr) || other.typeAr == typeAr) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.reportLink, reportLink) ||
                other.reportLink == reportLink) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerImage, customerImage) ||
                other.customerImage == customerImage) &&
            (identical(other.customerAddress, customerAddress) ||
                other.customerAddress == customerAddress) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.serviceDescription, serviceDescription) ||
                other.serviceDescription == serviceDescription) &&
            (identical(other.isWithMaterial, isWithMaterial) ||
                other.isWithMaterial == isWithMaterial) &&
            (identical(other.isWithFemale, isWithFemale) ||
                other.isWithFemale == isWithFemale) &&
            (identical(other.latitudel, latitudel) ||
                other.latitudel == latitudel) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.esitmatedTime, esitmatedTime) ||
                other.esitmatedTime == esitmatedTime) &&
            const DeepCollectionEquality()
                .equals(other._ticketAttatchments, _ticketAttatchments) &&
            const DeepCollectionEquality()
                .equals(other._technicianAttachments, _technicianAttachments) &&
            const DeepCollectionEquality()
                .equals(other._ticketTools, _ticketTools) &&
            const DeepCollectionEquality()
                .equals(other._ticketImages, _ticketImages) &&
            const DeepCollectionEquality()
                .equals(other._ticketMaterials, _ticketMaterials) &&
            const DeepCollectionEquality()
                .equals(other._maintenanceTickets, _maintenanceTickets) &&
            const DeepCollectionEquality()
                .equals(other._serviceTickets, _serviceTickets) &&
            const DeepCollectionEquality()
                .equals(other._advantageTickets, _advantageTickets) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.creator, creator) || other.creator == creator));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        ticketCodeId,
        title,
        time,
        titleAr,
        type,
        typeAr,
        userId,
        date,
        reportLink,
        status,
        customerName,
        customerImage,
        customerAddress,
        description,
        serviceDescription,
        isWithMaterial,
        isWithFemale,
        latitudel,
        longitude,
        mobile,
        esitmatedTime,
        const DeepCollectionEquality().hash(_ticketAttatchments),
        const DeepCollectionEquality().hash(_technicianAttachments),
        const DeepCollectionEquality().hash(_ticketTools),
        const DeepCollectionEquality().hash(_ticketImages),
        const DeepCollectionEquality().hash(_ticketMaterials),
        const DeepCollectionEquality().hash(_maintenanceTickets),
        const DeepCollectionEquality().hash(_serviceTickets),
        const DeepCollectionEquality().hash(_advantageTickets),
        createdBy,
        creator
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketsDetailsImplCopyWith<_$TicketsDetailsImpl> get copyWith =>
      __$$TicketsDetailsImplCopyWithImpl<_$TicketsDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketsDetailsImplToJson(
      this,
    );
  }
}

abstract class _TicketsDetails implements TicketsDetails {
  const factory _TicketsDetails(
          {@JsonKey(name: "id") final int? id,
          @JsonKey(name: "ticketCodeId") final String? ticketCodeId,
          @JsonKey(name: "title") final String? title,
          @JsonKey(name: "time") final String? time,
          @JsonKey(name: "titleAr") final String? titleAr,
          @JsonKey(name: "type") final String? type,
          @JsonKey(name: "typeAr") final String? typeAr,
          @JsonKey(name: "userId") final int? userId,
          @JsonKey(name: "date") final DateTime? date,
          @JsonKey(name: "reportLink") final String? reportLink,
          @JsonKey(name: "status") final String? status,
          @JsonKey(name: "customerName") final String? customerName,
          @JsonKey(name: "customerImage") final String? customerImage,
          @JsonKey(name: "customerAddress") final String? customerAddress,
          @JsonKey(name: "description") final String? description,
          @JsonKey(name: "serviceDescription") final String? serviceDescription,
          @JsonKey(name: "isWithMaterial") final bool? isWithMaterial,
          @JsonKey(name: "isWithFemale") final bool? isWithFemale,
          @JsonKey(name: "latitudel") final String? latitudel,
          @JsonKey(name: "longitude") final String? longitude,
          @JsonKey(name: "mobile") final String? mobile,
          @JsonKey(name: "esitmatedTime") final String? esitmatedTime,
          @JsonKey(name: "ticketAttatchments")
          final List<TicketAttatchment>? ticketAttatchments,
          @JsonKey(name: "technicianAttachments")
          final List<TicketAttatchment>? technicianAttachments,
          @JsonKey(name: "ticketTools") final List<TicketTool>? ticketTools,
          @JsonKey(name: "ticketImages") final List<String>? ticketImages,
          @JsonKey(name: "ticketMaterials")
          final List<TicketMaterial>? ticketMaterials,
          @JsonKey(name: "maintenanceTickets")
          final List<MaintenanceTicket>? maintenanceTickets,
          @JsonKey(name: "servcieTickets")
          final List<ServiceTicket>? serviceTickets,
          @JsonKey(name: "advantageTickets")
          final List<AdvantageTickets>? advantageTickets,
          @JsonKey(name: "createdBy") final int? createdBy,
          @JsonKey(name: "creator") final CreatorInfo? creator}) =
      _$TicketsDetailsImpl;

  factory _TicketsDetails.fromJson(Map<String, dynamic> json) =
      _$TicketsDetailsImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "ticketCodeId")
  String? get ticketCodeId;
  @override
  @JsonKey(name: "title")
  String? get title;
  @override
  @JsonKey(name: "time")
  String? get time;
  @override
  @JsonKey(name: "titleAr")
  String? get titleAr;
  @override
  @JsonKey(name: "type")
  String? get type;
  @override
  @JsonKey(name: "typeAr")
  String? get typeAr;
  @override
  @JsonKey(name: "userId")
  int? get userId;
  @override
  @JsonKey(name: "date")
  DateTime? get date;
  @override
  @JsonKey(name: "reportLink")
  String? get reportLink;
  @override
  @JsonKey(name: "status")
  String? get status;
  @override
  @JsonKey(name: "customerName")
  String? get customerName;
  @override
  @JsonKey(name: "customerImage")
  String? get customerImage;
  @override
  @JsonKey(name: "customerAddress")
  String? get customerAddress;
  @override
  @JsonKey(name: "description")
  String? get description;
  @override
  @JsonKey(name: "serviceDescription")
  String? get serviceDescription;
  @override
  @JsonKey(name: "isWithMaterial")
  bool? get isWithMaterial;
  @override
  @JsonKey(name: "isWithFemale")
  bool? get isWithFemale;
  @override
  @JsonKey(name: "latitudel")
  String? get latitudel;
  @override
  @JsonKey(name: "longitude")
  String? get longitude;
  @override
  @JsonKey(name: "mobile")
  String? get mobile;
  @override
  @JsonKey(name: "esitmatedTime")
  String? get esitmatedTime;
  @override
  @JsonKey(name: "ticketAttatchments")
  List<TicketAttatchment>? get ticketAttatchments;
  @override
  @JsonKey(name: "technicianAttachments")
  List<TicketAttatchment>? get technicianAttachments;
  @override
  @JsonKey(name: "ticketTools")
  List<TicketTool>? get ticketTools;
  @override
  @JsonKey(name: "ticketImages")
  List<String>? get ticketImages;
  @override
  @JsonKey(name: "ticketMaterials")
  List<TicketMaterial>? get ticketMaterials;
  @override
  @JsonKey(name: "maintenanceTickets")
  List<MaintenanceTicket>? get maintenanceTickets;
  @override
  @JsonKey(name: "servcieTickets")
  List<ServiceTicket>? get serviceTickets;
  @override
  @JsonKey(name: "advantageTickets")
  List<AdvantageTickets>? get advantageTickets;
  @override
  @JsonKey(name: "createdBy")
  int? get createdBy;
  @override
  @JsonKey(name: "creator")
  CreatorInfo? get creator;
  @override
  @JsonKey(ignore: true)
  _$$TicketsDetailsImplCopyWith<_$TicketsDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TicketAttatchment _$TicketAttatchmentFromJson(Map<String, dynamic> json) {
  return _TicketAttatchment.fromJson(json);
}

/// @nodoc
mixin _$TicketAttatchment {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketId")
  int? get ticketId => throw _privateConstructorUsedError;
  @JsonKey(name: "size")
  dynamic get size => throw _privateConstructorUsedError;
  @JsonKey(name: "fileName")
  dynamic get fileName => throw _privateConstructorUsedError;
  @JsonKey(name: "filePath")
  String? get filePath => throw _privateConstructorUsedError;
  @JsonKey(name: "type")
  dynamic get type => throw _privateConstructorUsedError;
  @JsonKey(name: "createdDate")
  DateTime? get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: "ticket")
  dynamic get ticket => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TicketAttatchmentCopyWith<TicketAttatchment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketAttatchmentCopyWith<$Res> {
  factory $TicketAttatchmentCopyWith(
          TicketAttatchment value, $Res Function(TicketAttatchment) then) =
      _$TicketAttatchmentCopyWithImpl<$Res, TicketAttatchment>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "ticketId") int? ticketId,
      @JsonKey(name: "size") dynamic size,
      @JsonKey(name: "fileName") dynamic fileName,
      @JsonKey(name: "filePath") String? filePath,
      @JsonKey(name: "type") dynamic type,
      @JsonKey(name: "createdDate") DateTime? createdDate,
      @JsonKey(name: "ticket") dynamic ticket});
}

/// @nodoc
class _$TicketAttatchmentCopyWithImpl<$Res, $Val extends TicketAttatchment>
    implements $TicketAttatchmentCopyWith<$Res> {
  _$TicketAttatchmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ticketId = freezed,
    Object? size = freezed,
    Object? fileName = freezed,
    Object? filePath = freezed,
    Object? type = freezed,
    Object? createdDate = freezed,
    Object? ticket = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      ticketId: freezed == ticketId
          ? _value.ticketId
          : ticketId // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as dynamic,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as dynamic,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ticket: freezed == ticket
          ? _value.ticket
          : ticket // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TicketAttatchmentImplCopyWith<$Res>
    implements $TicketAttatchmentCopyWith<$Res> {
  factory _$$TicketAttatchmentImplCopyWith(_$TicketAttatchmentImpl value,
          $Res Function(_$TicketAttatchmentImpl) then) =
      __$$TicketAttatchmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "ticketId") int? ticketId,
      @JsonKey(name: "size") dynamic size,
      @JsonKey(name: "fileName") dynamic fileName,
      @JsonKey(name: "filePath") String? filePath,
      @JsonKey(name: "type") dynamic type,
      @JsonKey(name: "createdDate") DateTime? createdDate,
      @JsonKey(name: "ticket") dynamic ticket});
}

/// @nodoc
class __$$TicketAttatchmentImplCopyWithImpl<$Res>
    extends _$TicketAttatchmentCopyWithImpl<$Res, _$TicketAttatchmentImpl>
    implements _$$TicketAttatchmentImplCopyWith<$Res> {
  __$$TicketAttatchmentImplCopyWithImpl(_$TicketAttatchmentImpl _value,
      $Res Function(_$TicketAttatchmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ticketId = freezed,
    Object? size = freezed,
    Object? fileName = freezed,
    Object? filePath = freezed,
    Object? type = freezed,
    Object? createdDate = freezed,
    Object? ticket = freezed,
  }) {
    return _then(_$TicketAttatchmentImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      ticketId: freezed == ticketId
          ? _value.ticketId
          : ticketId // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as dynamic,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as dynamic,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ticket: freezed == ticket
          ? _value.ticket
          : ticket // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketAttatchmentImpl implements _TicketAttatchment {
  const _$TicketAttatchmentImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "ticketId") this.ticketId,
      @JsonKey(name: "size") this.size,
      @JsonKey(name: "fileName") this.fileName,
      @JsonKey(name: "filePath") this.filePath,
      @JsonKey(name: "type") this.type,
      @JsonKey(name: "createdDate") this.createdDate,
      @JsonKey(name: "ticket") this.ticket});

  factory _$TicketAttatchmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketAttatchmentImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "ticketId")
  final int? ticketId;
  @override
  @JsonKey(name: "size")
  final dynamic size;
  @override
  @JsonKey(name: "fileName")
  final dynamic fileName;
  @override
  @JsonKey(name: "filePath")
  final String? filePath;
  @override
  @JsonKey(name: "type")
  final dynamic type;
  @override
  @JsonKey(name: "createdDate")
  final DateTime? createdDate;
  @override
  @JsonKey(name: "ticket")
  final dynamic ticket;

  @override
  String toString() {
    return 'TicketAttatchment(id: $id, ticketId: $ticketId, size: $size, fileName: $fileName, filePath: $filePath, type: $type, createdDate: $createdDate, ticket: $ticket)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketAttatchmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ticketId, ticketId) ||
                other.ticketId == ticketId) &&
            const DeepCollectionEquality().equals(other.size, size) &&
            const DeepCollectionEquality().equals(other.fileName, fileName) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            const DeepCollectionEquality().equals(other.ticket, ticket));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      ticketId,
      const DeepCollectionEquality().hash(size),
      const DeepCollectionEquality().hash(fileName),
      filePath,
      const DeepCollectionEquality().hash(type),
      createdDate,
      const DeepCollectionEquality().hash(ticket));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketAttatchmentImplCopyWith<_$TicketAttatchmentImpl> get copyWith =>
      __$$TicketAttatchmentImplCopyWithImpl<_$TicketAttatchmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketAttatchmentImplToJson(
      this,
    );
  }
}

abstract class _TicketAttatchment implements TicketAttatchment {
  const factory _TicketAttatchment(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "ticketId") final int? ticketId,
      @JsonKey(name: "size") final dynamic size,
      @JsonKey(name: "fileName") final dynamic fileName,
      @JsonKey(name: "filePath") final String? filePath,
      @JsonKey(name: "type") final dynamic type,
      @JsonKey(name: "createdDate") final DateTime? createdDate,
      @JsonKey(name: "ticket") final dynamic ticket}) = _$TicketAttatchmentImpl;

  factory _TicketAttatchment.fromJson(Map<String, dynamic> json) =
      _$TicketAttatchmentImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "ticketId")
  int? get ticketId;
  @override
  @JsonKey(name: "size")
  dynamic get size;
  @override
  @JsonKey(name: "fileName")
  dynamic get fileName;
  @override
  @JsonKey(name: "filePath")
  String? get filePath;
  @override
  @JsonKey(name: "type")
  dynamic get type;
  @override
  @JsonKey(name: "createdDate")
  DateTime? get createdDate;
  @override
  @JsonKey(name: "ticket")
  dynamic get ticket;
  @override
  @JsonKey(ignore: true)
  _$$TicketAttatchmentImplCopyWith<_$TicketAttatchmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TicketMaterial _$TicketMaterialFromJson(Map<String, dynamic> json) {
  return _TicketMaterial.fromJson(json);
}

/// @nodoc
mixin _$TicketMaterial {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: "titleAr")
  String? get titleAr => throw _privateConstructorUsedError;
  @JsonKey(name: "status")
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: "price")
  double? get price => throw _privateConstructorUsedError;
  @JsonKey(name: "iSselected")
  bool? get iSselected => throw _privateConstructorUsedError;
  @JsonKey(name: "quantity")
  int? get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TicketMaterialCopyWith<TicketMaterial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketMaterialCopyWith<$Res> {
  factory $TicketMaterialCopyWith(
          TicketMaterial value, $Res Function(TicketMaterial) then) =
      _$TicketMaterialCopyWithImpl<$Res, TicketMaterial>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "titleAr") String? titleAr,
      @JsonKey(name: "status") String? status,
      @JsonKey(name: "price") double? price,
      @JsonKey(name: "iSselected") bool? iSselected,
      @JsonKey(name: "quantity") int? quantity});
}

/// @nodoc
class _$TicketMaterialCopyWithImpl<$Res, $Val extends TicketMaterial>
    implements $TicketMaterialCopyWith<$Res> {
  _$TicketMaterialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? titleAr = freezed,
    Object? status = freezed,
    Object? price = freezed,
    Object? iSselected = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      titleAr: freezed == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      iSselected: freezed == iSselected
          ? _value.iSselected
          : iSselected // ignore: cast_nullable_to_non_nullable
              as bool?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TicketMaterialImplCopyWith<$Res>
    implements $TicketMaterialCopyWith<$Res> {
  factory _$$TicketMaterialImplCopyWith(_$TicketMaterialImpl value,
          $Res Function(_$TicketMaterialImpl) then) =
      __$$TicketMaterialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "titleAr") String? titleAr,
      @JsonKey(name: "status") String? status,
      @JsonKey(name: "price") double? price,
      @JsonKey(name: "iSselected") bool? iSselected,
      @JsonKey(name: "quantity") int? quantity});
}

/// @nodoc
class __$$TicketMaterialImplCopyWithImpl<$Res>
    extends _$TicketMaterialCopyWithImpl<$Res, _$TicketMaterialImpl>
    implements _$$TicketMaterialImplCopyWith<$Res> {
  __$$TicketMaterialImplCopyWithImpl(
      _$TicketMaterialImpl _value, $Res Function(_$TicketMaterialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? titleAr = freezed,
    Object? status = freezed,
    Object? price = freezed,
    Object? iSselected = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_$TicketMaterialImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      titleAr: freezed == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      iSselected: freezed == iSselected
          ? _value.iSselected
          : iSselected // ignore: cast_nullable_to_non_nullable
              as bool?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketMaterialImpl implements _TicketMaterial {
  const _$TicketMaterialImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "title") this.title,
      @JsonKey(name: "titleAr") this.titleAr,
      @JsonKey(name: "status") this.status,
      @JsonKey(name: "price") this.price,
      @JsonKey(name: "iSselected") this.iSselected,
      @JsonKey(name: "quantity") this.quantity});

  factory _$TicketMaterialImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketMaterialImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "title")
  final String? title;
  @override
  @JsonKey(name: "titleAr")
  final String? titleAr;
  @override
  @JsonKey(name: "status")
  final String? status;
  @override
  @JsonKey(name: "price")
  final double? price;
  @override
  @JsonKey(name: "iSselected")
  final bool? iSselected;
  @override
  @JsonKey(name: "quantity")
  final int? quantity;

  @override
  String toString() {
    return 'TicketMaterial(id: $id, title: $title, titleAr: $titleAr, status: $status, price: $price, iSselected: $iSselected, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketMaterialImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.titleAr, titleAr) || other.titleAr == titleAr) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.iSselected, iSselected) ||
                other.iSselected == iSselected) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, titleAr, status, price, iSselected, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketMaterialImplCopyWith<_$TicketMaterialImpl> get copyWith =>
      __$$TicketMaterialImplCopyWithImpl<_$TicketMaterialImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketMaterialImplToJson(
      this,
    );
  }
}

abstract class _TicketMaterial implements TicketMaterial {
  const factory _TicketMaterial(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "title") final String? title,
      @JsonKey(name: "titleAr") final String? titleAr,
      @JsonKey(name: "status") final String? status,
      @JsonKey(name: "price") final double? price,
      @JsonKey(name: "iSselected") final bool? iSselected,
      @JsonKey(name: "quantity") final int? quantity}) = _$TicketMaterialImpl;

  factory _TicketMaterial.fromJson(Map<String, dynamic> json) =
      _$TicketMaterialImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "title")
  String? get title;
  @override
  @JsonKey(name: "titleAr")
  String? get titleAr;
  @override
  @JsonKey(name: "status")
  String? get status;
  @override
  @JsonKey(name: "price")
  double? get price;
  @override
  @JsonKey(name: "iSselected")
  bool? get iSselected;
  @override
  @JsonKey(name: "quantity")
  int? get quantity;
  @override
  @JsonKey(ignore: true)
  _$$TicketMaterialImplCopyWith<_$TicketMaterialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TicketTool _$TicketToolFromJson(Map<String, dynamic> json) {
  return _TicketTool.fromJson(json);
}

/// @nodoc
mixin _$TicketTool {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "toolId")
  int? get toolId => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: "titleAr")
  String? get titleAr => throw _privateConstructorUsedError;
  @JsonKey(name: "quantity")
  int? get quantity => throw _privateConstructorUsedError;
  bool get isSelect => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TicketToolCopyWith<TicketTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketToolCopyWith<$Res> {
  factory $TicketToolCopyWith(
          TicketTool value, $Res Function(TicketTool) then) =
      _$TicketToolCopyWithImpl<$Res, TicketTool>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "toolId") int? toolId,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "titleAr") String? titleAr,
      @JsonKey(name: "quantity") int? quantity,
      bool isSelect});
}

/// @nodoc
class _$TicketToolCopyWithImpl<$Res, $Val extends TicketTool>
    implements $TicketToolCopyWith<$Res> {
  _$TicketToolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? toolId = freezed,
    Object? title = freezed,
    Object? titleAr = freezed,
    Object? quantity = freezed,
    Object? isSelect = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      toolId: freezed == toolId
          ? _value.toolId
          : toolId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      titleAr: freezed == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      isSelect: null == isSelect
          ? _value.isSelect
          : isSelect // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TicketToolImplCopyWith<$Res>
    implements $TicketToolCopyWith<$Res> {
  factory _$$TicketToolImplCopyWith(
          _$TicketToolImpl value, $Res Function(_$TicketToolImpl) then) =
      __$$TicketToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "toolId") int? toolId,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "titleAr") String? titleAr,
      @JsonKey(name: "quantity") int? quantity,
      bool isSelect});
}

/// @nodoc
class __$$TicketToolImplCopyWithImpl<$Res>
    extends _$TicketToolCopyWithImpl<$Res, _$TicketToolImpl>
    implements _$$TicketToolImplCopyWith<$Res> {
  __$$TicketToolImplCopyWithImpl(
      _$TicketToolImpl _value, $Res Function(_$TicketToolImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? toolId = freezed,
    Object? title = freezed,
    Object? titleAr = freezed,
    Object? quantity = freezed,
    Object? isSelect = null,
  }) {
    return _then(_$TicketToolImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      toolId: freezed == toolId
          ? _value.toolId
          : toolId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      titleAr: freezed == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      isSelect: null == isSelect
          ? _value.isSelect
          : isSelect // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketToolImpl implements _TicketTool {
  const _$TicketToolImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "toolId") this.toolId,
      @JsonKey(name: "title") this.title,
      @JsonKey(name: "titleAr") this.titleAr,
      @JsonKey(name: "quantity") this.quantity,
      this.isSelect = false});

  factory _$TicketToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketToolImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "toolId")
  final int? toolId;
  @override
  @JsonKey(name: "title")
  final String? title;
  @override
  @JsonKey(name: "titleAr")
  final String? titleAr;
  @override
  @JsonKey(name: "quantity")
  final int? quantity;
  @override
  @JsonKey()
  final bool isSelect;

  @override
  String toString() {
    return 'TicketTool(id: $id, toolId: $toolId, title: $title, titleAr: $titleAr, quantity: $quantity, isSelect: $isSelect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketToolImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.toolId, toolId) || other.toolId == toolId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.titleAr, titleAr) || other.titleAr == titleAr) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.isSelect, isSelect) ||
                other.isSelect == isSelect));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, toolId, title, titleAr, quantity, isSelect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketToolImplCopyWith<_$TicketToolImpl> get copyWith =>
      __$$TicketToolImplCopyWithImpl<_$TicketToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketToolImplToJson(
      this,
    );
  }
}

abstract class _TicketTool implements TicketTool {
  const factory _TicketTool(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "toolId") final int? toolId,
      @JsonKey(name: "title") final String? title,
      @JsonKey(name: "titleAr") final String? titleAr,
      @JsonKey(name: "quantity") final int? quantity,
      final bool isSelect}) = _$TicketToolImpl;

  factory _TicketTool.fromJson(Map<String, dynamic> json) =
      _$TicketToolImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "toolId")
  int? get toolId;
  @override
  @JsonKey(name: "title")
  String? get title;
  @override
  @JsonKey(name: "titleAr")
  String? get titleAr;
  @override
  @JsonKey(name: "quantity")
  int? get quantity;
  @override
  bool get isSelect;
  @override
  @JsonKey(ignore: true)
  _$$TicketToolImplCopyWith<_$TicketToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MaintenanceTicket _$MaintenanceTicketFromJson(Map<String, dynamic> json) {
  return _MaintenanceTicket.fromJson(json);
}

/// @nodoc
mixin _$MaintenanceTicket {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "nameAr")
  String? get nameAr => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "note")
  dynamic get note => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MaintenanceTicketCopyWith<MaintenanceTicket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaintenanceTicketCopyWith<$Res> {
  factory $MaintenanceTicketCopyWith(
          MaintenanceTicket value, $Res Function(MaintenanceTicket) then) =
      _$MaintenanceTicketCopyWithImpl<$Res, MaintenanceTicket>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameAr") String? nameAr,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "note") dynamic note});
}

/// @nodoc
class _$MaintenanceTicketCopyWithImpl<$Res, $Val extends MaintenanceTicket>
    implements $MaintenanceTicketCopyWith<$Res> {
  _$MaintenanceTicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameAr = freezed,
    Object? description = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameAr: freezed == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MaintenanceTicketImplCopyWith<$Res>
    implements $MaintenanceTicketCopyWith<$Res> {
  factory _$$MaintenanceTicketImplCopyWith(_$MaintenanceTicketImpl value,
          $Res Function(_$MaintenanceTicketImpl) then) =
      __$$MaintenanceTicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameAr") String? nameAr,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "note") dynamic note});
}

/// @nodoc
class __$$MaintenanceTicketImplCopyWithImpl<$Res>
    extends _$MaintenanceTicketCopyWithImpl<$Res, _$MaintenanceTicketImpl>
    implements _$$MaintenanceTicketImplCopyWith<$Res> {
  __$$MaintenanceTicketImplCopyWithImpl(_$MaintenanceTicketImpl _value,
      $Res Function(_$MaintenanceTicketImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameAr = freezed,
    Object? description = freezed,
    Object? note = freezed,
  }) {
    return _then(_$MaintenanceTicketImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameAr: freezed == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MaintenanceTicketImpl implements _MaintenanceTicket {
  const _$MaintenanceTicketImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "nameAr") this.nameAr,
      @JsonKey(name: "description") this.description,
      @JsonKey(name: "note") this.note});

  factory _$MaintenanceTicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$MaintenanceTicketImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "nameAr")
  final String? nameAr;
  @override
  @JsonKey(name: "description")
  final String? description;
  @override
  @JsonKey(name: "note")
  final dynamic note;

  @override
  String toString() {
    return 'MaintenanceTicket(id: $id, name: $name, nameAr: $nameAr, description: $description, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaintenanceTicketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.note, note));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nameAr, description,
      const DeepCollectionEquality().hash(note));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MaintenanceTicketImplCopyWith<_$MaintenanceTicketImpl> get copyWith =>
      __$$MaintenanceTicketImplCopyWithImpl<_$MaintenanceTicketImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MaintenanceTicketImplToJson(
      this,
    );
  }
}

abstract class _MaintenanceTicket implements MaintenanceTicket {
  const factory _MaintenanceTicket(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "name") final String? name,
      @JsonKey(name: "nameAr") final String? nameAr,
      @JsonKey(name: "description") final String? description,
      @JsonKey(name: "note") final dynamic note}) = _$MaintenanceTicketImpl;

  factory _MaintenanceTicket.fromJson(Map<String, dynamic> json) =
      _$MaintenanceTicketImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "nameAr")
  String? get nameAr;
  @override
  @JsonKey(name: "description")
  String? get description;
  @override
  @JsonKey(name: "note")
  dynamic get note;
  @override
  @JsonKey(ignore: true)
  _$$MaintenanceTicketImplCopyWith<_$MaintenanceTicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceTicket _$ServiceTicketFromJson(Map<String, dynamic> json) {
  return _ServiceTicket.fromJson(json);
}

/// @nodoc
mixin _$ServiceTicket {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "nameAr")
  String? get nameAr => throw _privateConstructorUsedError;
  @JsonKey(name: "price")
  int? get price => throw _privateConstructorUsedError;
  @JsonKey(name: "quantity")
  int? get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceTicketCopyWith<ServiceTicket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceTicketCopyWith<$Res> {
  factory $ServiceTicketCopyWith(
          ServiceTicket value, $Res Function(ServiceTicket) then) =
      _$ServiceTicketCopyWithImpl<$Res, ServiceTicket>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameAr") String? nameAr,
      @JsonKey(name: "price") int? price,
      @JsonKey(name: "quantity") int? quantity});
}

/// @nodoc
class _$ServiceTicketCopyWithImpl<$Res, $Val extends ServiceTicket>
    implements $ServiceTicketCopyWith<$Res> {
  _$ServiceTicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameAr = freezed,
    Object? price = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameAr: freezed == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceTicketImplCopyWith<$Res>
    implements $ServiceTicketCopyWith<$Res> {
  factory _$$ServiceTicketImplCopyWith(
          _$ServiceTicketImpl value, $Res Function(_$ServiceTicketImpl) then) =
      __$$ServiceTicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameAr") String? nameAr,
      @JsonKey(name: "price") int? price,
      @JsonKey(name: "quantity") int? quantity});
}

/// @nodoc
class __$$ServiceTicketImplCopyWithImpl<$Res>
    extends _$ServiceTicketCopyWithImpl<$Res, _$ServiceTicketImpl>
    implements _$$ServiceTicketImplCopyWith<$Res> {
  __$$ServiceTicketImplCopyWithImpl(
      _$ServiceTicketImpl _value, $Res Function(_$ServiceTicketImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameAr = freezed,
    Object? price = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_$ServiceTicketImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameAr: freezed == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceTicketImpl implements _ServiceTicket {
  const _$ServiceTicketImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "nameAr") this.nameAr,
      @JsonKey(name: "price") this.price,
      @JsonKey(name: "quantity") this.quantity});

  factory _$ServiceTicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceTicketImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "nameAr")
  final String? nameAr;
  @override
  @JsonKey(name: "price")
  final int? price;
  @override
  @JsonKey(name: "quantity")
  final int? quantity;

  @override
  String toString() {
    return 'ServiceTicket(id: $id, name: $name, nameAr: $nameAr, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceTicketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, nameAr, price, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceTicketImplCopyWith<_$ServiceTicketImpl> get copyWith =>
      __$$ServiceTicketImplCopyWithImpl<_$ServiceTicketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceTicketImplToJson(
      this,
    );
  }
}

abstract class _ServiceTicket implements ServiceTicket {
  const factory _ServiceTicket(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "name") final String? name,
      @JsonKey(name: "nameAr") final String? nameAr,
      @JsonKey(name: "price") final int? price,
      @JsonKey(name: "quantity") final int? quantity}) = _$ServiceTicketImpl;

  factory _ServiceTicket.fromJson(Map<String, dynamic> json) =
      _$ServiceTicketImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "nameAr")
  String? get nameAr;
  @override
  @JsonKey(name: "price")
  int? get price;
  @override
  @JsonKey(name: "quantity")
  int? get quantity;
  @override
  @JsonKey(ignore: true)
  _$$ServiceTicketImplCopyWith<_$ServiceTicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdvantageTickets _$AdvantageTicketsFromJson(Map<String, dynamic> json) {
  return AadvantageTickets.fromJson(json);
}

/// @nodoc
mixin _$AdvantageTickets {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "nameAr")
  String? get nameAr => throw _privateConstructorUsedError;
  @JsonKey(name: "price")
  int? get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdvantageTicketsCopyWith<AdvantageTickets> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdvantageTicketsCopyWith<$Res> {
  factory $AdvantageTicketsCopyWith(
          AdvantageTickets value, $Res Function(AdvantageTickets) then) =
      _$AdvantageTicketsCopyWithImpl<$Res, AdvantageTickets>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameAr") String? nameAr,
      @JsonKey(name: "price") int? price});
}

/// @nodoc
class _$AdvantageTicketsCopyWithImpl<$Res, $Val extends AdvantageTickets>
    implements $AdvantageTicketsCopyWith<$Res> {
  _$AdvantageTicketsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameAr = freezed,
    Object? price = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameAr: freezed == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AadvantageTicketsImplCopyWith<$Res>
    implements $AdvantageTicketsCopyWith<$Res> {
  factory _$$AadvantageTicketsImplCopyWith(_$AadvantageTicketsImpl value,
          $Res Function(_$AadvantageTicketsImpl) then) =
      __$$AadvantageTicketsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameAr") String? nameAr,
      @JsonKey(name: "price") int? price});
}

/// @nodoc
class __$$AadvantageTicketsImplCopyWithImpl<$Res>
    extends _$AdvantageTicketsCopyWithImpl<$Res, _$AadvantageTicketsImpl>
    implements _$$AadvantageTicketsImplCopyWith<$Res> {
  __$$AadvantageTicketsImplCopyWithImpl(_$AadvantageTicketsImpl _value,
      $Res Function(_$AadvantageTicketsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameAr = freezed,
    Object? price = freezed,
  }) {
    return _then(_$AadvantageTicketsImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameAr: freezed == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AadvantageTicketsImpl implements AadvantageTickets {
  const _$AadvantageTicketsImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "nameAr") this.nameAr,
      @JsonKey(name: "price") this.price});

  factory _$AadvantageTicketsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AadvantageTicketsImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "nameAr")
  final String? nameAr;
  @override
  @JsonKey(name: "price")
  final int? price;

  @override
  String toString() {
    return 'AdvantageTickets(id: $id, name: $name, nameAr: $nameAr, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AadvantageTicketsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nameAr, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AadvantageTicketsImplCopyWith<_$AadvantageTicketsImpl> get copyWith =>
      __$$AadvantageTicketsImplCopyWithImpl<_$AadvantageTicketsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AadvantageTicketsImplToJson(
      this,
    );
  }
}

abstract class AadvantageTickets implements AdvantageTickets {
  const factory AadvantageTickets(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "name") final String? name,
      @JsonKey(name: "nameAr") final String? nameAr,
      @JsonKey(name: "price") final int? price}) = _$AadvantageTicketsImpl;

  factory AadvantageTickets.fromJson(Map<String, dynamic> json) =
      _$AadvantageTicketsImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "nameAr")
  String? get nameAr;
  @override
  @JsonKey(name: "price")
  int? get price;
  @override
  @JsonKey(ignore: true)
  _$$AadvantageTicketsImplCopyWith<_$AadvantageTicketsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatorInfo _$CreatorInfoFromJson(Map<String, dynamic> json) {
  return _CreatorInfo.fromJson(json);
}

/// @nodoc
mixin _$CreatorInfo {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "userNumber")
  String? get userNumber => throw _privateConstructorUsedError;
  @JsonKey(name: "mobileNumber")
  String? get mobileNumber => throw _privateConstructorUsedError;
  @JsonKey(name: "countryCode")
  String? get countryCode => throw _privateConstructorUsedError;
  @JsonKey(name: "image")
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatorInfoCopyWith<CreatorInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatorInfoCopyWith<$Res> {
  factory $CreatorInfoCopyWith(
          CreatorInfo value, $Res Function(CreatorInfo) then) =
      _$CreatorInfoCopyWithImpl<$Res, CreatorInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "userNumber") String? userNumber,
      @JsonKey(name: "mobileNumber") String? mobileNumber,
      @JsonKey(name: "countryCode") String? countryCode,
      @JsonKey(name: "image") String? image});
}

/// @nodoc
class _$CreatorInfoCopyWithImpl<$Res, $Val extends CreatorInfo>
    implements $CreatorInfoCopyWith<$Res> {
  _$CreatorInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? userNumber = freezed,
    Object? mobileNumber = freezed,
    Object? countryCode = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userNumber: freezed == userNumber
          ? _value.userNumber
          : userNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      mobileNumber: freezed == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatorInfoImplCopyWith<$Res>
    implements $CreatorInfoCopyWith<$Res> {
  factory _$$CreatorInfoImplCopyWith(
          _$CreatorInfoImpl value, $Res Function(_$CreatorInfoImpl) then) =
      __$$CreatorInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "userNumber") String? userNumber,
      @JsonKey(name: "mobileNumber") String? mobileNumber,
      @JsonKey(name: "countryCode") String? countryCode,
      @JsonKey(name: "image") String? image});
}

/// @nodoc
class __$$CreatorInfoImplCopyWithImpl<$Res>
    extends _$CreatorInfoCopyWithImpl<$Res, _$CreatorInfoImpl>
    implements _$$CreatorInfoImplCopyWith<$Res> {
  __$$CreatorInfoImplCopyWithImpl(
      _$CreatorInfoImpl _value, $Res Function(_$CreatorInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? userNumber = freezed,
    Object? mobileNumber = freezed,
    Object? countryCode = freezed,
    Object? image = freezed,
  }) {
    return _then(_$CreatorInfoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userNumber: freezed == userNumber
          ? _value.userNumber
          : userNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      mobileNumber: freezed == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatorInfoImpl implements _CreatorInfo {
  const _$CreatorInfoImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "userNumber") this.userNumber,
      @JsonKey(name: "mobileNumber") this.mobileNumber,
      @JsonKey(name: "countryCode") this.countryCode,
      @JsonKey(name: "image") this.image});

  factory _$CreatorInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatorInfoImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "userNumber")
  final String? userNumber;
  @override
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;
  @override
  @JsonKey(name: "countryCode")
  final String? countryCode;
  @override
  @JsonKey(name: "image")
  final String? image;

  @override
  String toString() {
    return 'CreatorInfo(id: $id, name: $name, userNumber: $userNumber, mobileNumber: $mobileNumber, countryCode: $countryCode, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatorInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userNumber, userNumber) ||
                other.userNumber == userNumber) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, userNumber, mobileNumber, countryCode, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatorInfoImplCopyWith<_$CreatorInfoImpl> get copyWith =>
      __$$CreatorInfoImplCopyWithImpl<_$CreatorInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatorInfoImplToJson(
      this,
    );
  }
}

abstract class _CreatorInfo implements CreatorInfo {
  const factory _CreatorInfo(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "name") final String? name,
      @JsonKey(name: "userNumber") final String? userNumber,
      @JsonKey(name: "mobileNumber") final String? mobileNumber,
      @JsonKey(name: "countryCode") final String? countryCode,
      @JsonKey(name: "image") final String? image}) = _$CreatorInfoImpl;

  factory _CreatorInfo.fromJson(Map<String, dynamic> json) =
      _$CreatorInfoImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "userNumber")
  String? get userNumber;
  @override
  @JsonKey(name: "mobileNumber")
  String? get mobileNumber;
  @override
  @JsonKey(name: "countryCode")
  String? get countryCode;
  @override
  @JsonKey(name: "image")
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$CreatorInfoImplCopyWith<_$CreatorInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
