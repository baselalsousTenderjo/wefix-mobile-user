// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) {
  return _HomeModel.fromJson(json);
}

/// @nodoc
mixin _$HomeModel {
  @JsonKey(name: "tickets")
  List<Tickets>? get tickets => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketsTomorrow")
  List<Tickets>? get ticketsTomorrow => throw _privateConstructorUsedError;
  @JsonKey(name: "emergency")
  List<Tickets>? get emergency => throw _privateConstructorUsedError;
  @JsonKey(name: "technician")
  TechnicianInfo? get technician => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeModelCopyWith<HomeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeModelCopyWith<$Res> {
  factory $HomeModelCopyWith(HomeModel value, $Res Function(HomeModel) then) =
      _$HomeModelCopyWithImpl<$Res, HomeModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "tickets") List<Tickets>? tickets,
      @JsonKey(name: "ticketsTomorrow") List<Tickets>? ticketsTomorrow,
      @JsonKey(name: "emergency") List<Tickets>? emergency,
      @JsonKey(name: "technician") TechnicianInfo? technician});

  $TechnicianInfoCopyWith<$Res>? get technician;
}

/// @nodoc
class _$HomeModelCopyWithImpl<$Res, $Val extends HomeModel>
    implements $HomeModelCopyWith<$Res> {
  _$HomeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tickets = freezed,
    Object? ticketsTomorrow = freezed,
    Object? emergency = freezed,
    Object? technician = freezed,
  }) {
    return _then(_value.copyWith(
      tickets: freezed == tickets
          ? _value.tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as List<Tickets>?,
      ticketsTomorrow: freezed == ticketsTomorrow
          ? _value.ticketsTomorrow
          : ticketsTomorrow // ignore: cast_nullable_to_non_nullable
              as List<Tickets>?,
      emergency: freezed == emergency
          ? _value.emergency
          : emergency // ignore: cast_nullable_to_non_nullable
              as List<Tickets>?,
      technician: freezed == technician
          ? _value.technician
          : technician // ignore: cast_nullable_to_non_nullable
              as TechnicianInfo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TechnicianInfoCopyWith<$Res>? get technician {
    if (_value.technician == null) {
      return null;
    }

    return $TechnicianInfoCopyWith<$Res>(_value.technician!, (value) {
      return _then(_value.copyWith(technician: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeModelImplCopyWith<$Res>
    implements $HomeModelCopyWith<$Res> {
  factory _$$HomeModelImplCopyWith(
          _$HomeModelImpl value, $Res Function(_$HomeModelImpl) then) =
      __$$HomeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "tickets") List<Tickets>? tickets,
      @JsonKey(name: "ticketsTomorrow") List<Tickets>? ticketsTomorrow,
      @JsonKey(name: "emergency") List<Tickets>? emergency,
      @JsonKey(name: "technician") TechnicianInfo? technician});

  @override
  $TechnicianInfoCopyWith<$Res>? get technician;
}

/// @nodoc
class __$$HomeModelImplCopyWithImpl<$Res>
    extends _$HomeModelCopyWithImpl<$Res, _$HomeModelImpl>
    implements _$$HomeModelImplCopyWith<$Res> {
  __$$HomeModelImplCopyWithImpl(
      _$HomeModelImpl _value, $Res Function(_$HomeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tickets = freezed,
    Object? ticketsTomorrow = freezed,
    Object? emergency = freezed,
    Object? technician = freezed,
  }) {
    return _then(_$HomeModelImpl(
      tickets: freezed == tickets
          ? _value._tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as List<Tickets>?,
      ticketsTomorrow: freezed == ticketsTomorrow
          ? _value._ticketsTomorrow
          : ticketsTomorrow // ignore: cast_nullable_to_non_nullable
              as List<Tickets>?,
      emergency: freezed == emergency
          ? _value._emergency
          : emergency // ignore: cast_nullable_to_non_nullable
              as List<Tickets>?,
      technician: freezed == technician
          ? _value.technician
          : technician // ignore: cast_nullable_to_non_nullable
              as TechnicianInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeModelImpl implements _HomeModel {
  const _$HomeModelImpl(
      {@JsonKey(name: "tickets") final List<Tickets>? tickets,
      @JsonKey(name: "ticketsTomorrow") final List<Tickets>? ticketsTomorrow,
      @JsonKey(name: "emergency") final List<Tickets>? emergency,
      @JsonKey(name: "technician") this.technician})
      : _tickets = tickets,
        _ticketsTomorrow = ticketsTomorrow,
        _emergency = emergency;

  factory _$HomeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeModelImplFromJson(json);

  final List<Tickets>? _tickets;
  @override
  @JsonKey(name: "tickets")
  List<Tickets>? get tickets {
    final value = _tickets;
    if (value == null) return null;
    if (_tickets is EqualUnmodifiableListView) return _tickets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Tickets>? _ticketsTomorrow;
  @override
  @JsonKey(name: "ticketsTomorrow")
  List<Tickets>? get ticketsTomorrow {
    final value = _ticketsTomorrow;
    if (value == null) return null;
    if (_ticketsTomorrow is EqualUnmodifiableListView) return _ticketsTomorrow;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Tickets>? _emergency;
  @override
  @JsonKey(name: "emergency")
  List<Tickets>? get emergency {
    final value = _emergency;
    if (value == null) return null;
    if (_emergency is EqualUnmodifiableListView) return _emergency;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "technician")
  final TechnicianInfo? technician;

  @override
  String toString() {
    return 'HomeModel(tickets: $tickets, ticketsTomorrow: $ticketsTomorrow, emergency: $emergency, technician: $technician)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeModelImpl &&
            const DeepCollectionEquality().equals(other._tickets, _tickets) &&
            const DeepCollectionEquality()
                .equals(other._ticketsTomorrow, _ticketsTomorrow) &&
            const DeepCollectionEquality()
                .equals(other._emergency, _emergency) &&
            (identical(other.technician, technician) ||
                other.technician == technician));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tickets),
      const DeepCollectionEquality().hash(_ticketsTomorrow),
      const DeepCollectionEquality().hash(_emergency),
      technician);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeModelImplCopyWith<_$HomeModelImpl> get copyWith =>
      __$$HomeModelImplCopyWithImpl<_$HomeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeModelImplToJson(
      this,
    );
  }
}

abstract class _HomeModel implements HomeModel {
  const factory _HomeModel(
      {@JsonKey(name: "tickets") final List<Tickets>? tickets,
      @JsonKey(name: "ticketsTomorrow") final List<Tickets>? ticketsTomorrow,
      @JsonKey(name: "emergency") final List<Tickets>? emergency,
      @JsonKey(name: "technician")
      final TechnicianInfo? technician}) = _$HomeModelImpl;

  factory _HomeModel.fromJson(Map<String, dynamic> json) =
      _$HomeModelImpl.fromJson;

  @override
  @JsonKey(name: "tickets")
  List<Tickets>? get tickets;
  @override
  @JsonKey(name: "ticketsTomorrow")
  List<Tickets>? get ticketsTomorrow;
  @override
  @JsonKey(name: "emergency")
  List<Tickets>? get emergency;
  @override
  @JsonKey(name: "technician")
  TechnicianInfo? get technician;
  @override
  @JsonKey(ignore: true)
  _$$HomeModelImplCopyWith<_$HomeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TechnicianInfo _$TechnicianInfoFromJson(Map<String, dynamic> json) {
  return _TechnicianInfo.fromJson(json);
}

/// @nodoc
mixin _$TechnicianInfo {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "nameEnglish")
  String? get nameEnglish => throw _privateConstructorUsedError;
  @JsonKey(name: "image")
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: "company")
  CompanyInfo? get company => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TechnicianInfoCopyWith<TechnicianInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TechnicianInfoCopyWith<$Res> {
  factory $TechnicianInfoCopyWith(
          TechnicianInfo value, $Res Function(TechnicianInfo) then) =
      _$TechnicianInfoCopyWithImpl<$Res, TechnicianInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameEnglish") String? nameEnglish,
      @JsonKey(name: "image") String? image,
      @JsonKey(name: "company") CompanyInfo? company});

  $CompanyInfoCopyWith<$Res>? get company;
}

/// @nodoc
class _$TechnicianInfoCopyWithImpl<$Res, $Val extends TechnicianInfo>
    implements $TechnicianInfoCopyWith<$Res> {
  _$TechnicianInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameEnglish = freezed,
    Object? image = freezed,
    Object? company = freezed,
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
      nameEnglish: freezed == nameEnglish
          ? _value.nameEnglish
          : nameEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as CompanyInfo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CompanyInfoCopyWith<$Res>? get company {
    if (_value.company == null) {
      return null;
    }

    return $CompanyInfoCopyWith<$Res>(_value.company!, (value) {
      return _then(_value.copyWith(company: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TechnicianInfoImplCopyWith<$Res>
    implements $TechnicianInfoCopyWith<$Res> {
  factory _$$TechnicianInfoImplCopyWith(_$TechnicianInfoImpl value,
          $Res Function(_$TechnicianInfoImpl) then) =
      __$$TechnicianInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameEnglish") String? nameEnglish,
      @JsonKey(name: "image") String? image,
      @JsonKey(name: "company") CompanyInfo? company});

  @override
  $CompanyInfoCopyWith<$Res>? get company;
}

/// @nodoc
class __$$TechnicianInfoImplCopyWithImpl<$Res>
    extends _$TechnicianInfoCopyWithImpl<$Res, _$TechnicianInfoImpl>
    implements _$$TechnicianInfoImplCopyWith<$Res> {
  __$$TechnicianInfoImplCopyWithImpl(
      _$TechnicianInfoImpl _value, $Res Function(_$TechnicianInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameEnglish = freezed,
    Object? image = freezed,
    Object? company = freezed,
  }) {
    return _then(_$TechnicianInfoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameEnglish: freezed == nameEnglish
          ? _value.nameEnglish
          : nameEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as CompanyInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TechnicianInfoImpl implements _TechnicianInfo {
  const _$TechnicianInfoImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "nameEnglish") this.nameEnglish,
      @JsonKey(name: "image") this.image,
      @JsonKey(name: "company") this.company});

  factory _$TechnicianInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TechnicianInfoImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "nameEnglish")
  final String? nameEnglish;
  @override
  @JsonKey(name: "image")
  final String? image;
  @override
  @JsonKey(name: "company")
  final CompanyInfo? company;

  @override
  String toString() {
    return 'TechnicianInfo(id: $id, name: $name, nameEnglish: $nameEnglish, image: $image, company: $company)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TechnicianInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEnglish, nameEnglish) ||
                other.nameEnglish == nameEnglish) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.company, company) || other.company == company));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, nameEnglish, image, company);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TechnicianInfoImplCopyWith<_$TechnicianInfoImpl> get copyWith =>
      __$$TechnicianInfoImplCopyWithImpl<_$TechnicianInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TechnicianInfoImplToJson(
      this,
    );
  }
}

abstract class _TechnicianInfo implements TechnicianInfo {
  const factory _TechnicianInfo(
          {@JsonKey(name: "id") final int? id,
          @JsonKey(name: "name") final String? name,
          @JsonKey(name: "nameEnglish") final String? nameEnglish,
          @JsonKey(name: "image") final String? image,
          @JsonKey(name: "company") final CompanyInfo? company}) =
      _$TechnicianInfoImpl;

  factory _TechnicianInfo.fromJson(Map<String, dynamic> json) =
      _$TechnicianInfoImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "nameEnglish")
  String? get nameEnglish;
  @override
  @JsonKey(name: "image")
  String? get image;
  @override
  @JsonKey(name: "company")
  CompanyInfo? get company;
  @override
  @JsonKey(ignore: true)
  _$$TechnicianInfoImplCopyWith<_$TechnicianInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompanyInfo _$CompanyInfoFromJson(Map<String, dynamic> json) {
  return _CompanyInfo.fromJson(json);
}

/// @nodoc
mixin _$CompanyInfo {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "nameArabic")
  String? get nameArabic => throw _privateConstructorUsedError;
  @JsonKey(name: "nameEnglish")
  String? get nameEnglish => throw _privateConstructorUsedError;
  @JsonKey(name: "logo")
  String? get logo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyInfoCopyWith<CompanyInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyInfoCopyWith<$Res> {
  factory $CompanyInfoCopyWith(
          CompanyInfo value, $Res Function(CompanyInfo) then) =
      _$CompanyInfoCopyWithImpl<$Res, CompanyInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameArabic") String? nameArabic,
      @JsonKey(name: "nameEnglish") String? nameEnglish,
      @JsonKey(name: "logo") String? logo});
}

/// @nodoc
class _$CompanyInfoCopyWithImpl<$Res, $Val extends CompanyInfo>
    implements $CompanyInfoCopyWith<$Res> {
  _$CompanyInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameArabic = freezed,
    Object? nameEnglish = freezed,
    Object? logo = freezed,
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
      nameArabic: freezed == nameArabic
          ? _value.nameArabic
          : nameArabic // ignore: cast_nullable_to_non_nullable
              as String?,
      nameEnglish: freezed == nameEnglish
          ? _value.nameEnglish
          : nameEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompanyInfoImplCopyWith<$Res>
    implements $CompanyInfoCopyWith<$Res> {
  factory _$$CompanyInfoImplCopyWith(
          _$CompanyInfoImpl value, $Res Function(_$CompanyInfoImpl) then) =
      __$$CompanyInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameArabic") String? nameArabic,
      @JsonKey(name: "nameEnglish") String? nameEnglish,
      @JsonKey(name: "logo") String? logo});
}

/// @nodoc
class __$$CompanyInfoImplCopyWithImpl<$Res>
    extends _$CompanyInfoCopyWithImpl<$Res, _$CompanyInfoImpl>
    implements _$$CompanyInfoImplCopyWith<$Res> {
  __$$CompanyInfoImplCopyWithImpl(
      _$CompanyInfoImpl _value, $Res Function(_$CompanyInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameArabic = freezed,
    Object? nameEnglish = freezed,
    Object? logo = freezed,
  }) {
    return _then(_$CompanyInfoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameArabic: freezed == nameArabic
          ? _value.nameArabic
          : nameArabic // ignore: cast_nullable_to_non_nullable
              as String?,
      nameEnglish: freezed == nameEnglish
          ? _value.nameEnglish
          : nameEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyInfoImpl implements _CompanyInfo {
  const _$CompanyInfoImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "nameArabic") this.nameArabic,
      @JsonKey(name: "nameEnglish") this.nameEnglish,
      @JsonKey(name: "logo") this.logo});

  factory _$CompanyInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyInfoImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "nameArabic")
  final String? nameArabic;
  @override
  @JsonKey(name: "nameEnglish")
  final String? nameEnglish;
  @override
  @JsonKey(name: "logo")
  final String? logo;

  @override
  String toString() {
    return 'CompanyInfo(id: $id, name: $name, nameArabic: $nameArabic, nameEnglish: $nameEnglish, logo: $logo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameArabic, nameArabic) ||
                other.nameArabic == nameArabic) &&
            (identical(other.nameEnglish, nameEnglish) ||
                other.nameEnglish == nameEnglish) &&
            (identical(other.logo, logo) || other.logo == logo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, nameArabic, nameEnglish, logo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyInfoImplCopyWith<_$CompanyInfoImpl> get copyWith =>
      __$$CompanyInfoImplCopyWithImpl<_$CompanyInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyInfoImplToJson(
      this,
    );
  }
}

abstract class _CompanyInfo implements CompanyInfo {
  const factory _CompanyInfo(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "name") final String? name,
      @JsonKey(name: "nameArabic") final String? nameArabic,
      @JsonKey(name: "nameEnglish") final String? nameEnglish,
      @JsonKey(name: "logo") final String? logo}) = _$CompanyInfoImpl;

  factory _CompanyInfo.fromJson(Map<String, dynamic> json) =
      _$CompanyInfoImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "nameArabic")
  String? get nameArabic;
  @override
  @JsonKey(name: "nameEnglish")
  String? get nameEnglish;
  @override
  @JsonKey(name: "logo")
  String? get logo;
  @override
  @JsonKey(ignore: true)
  _$$CompanyInfoImplCopyWith<_$CompanyInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Tickets _$TicketsFromJson(Map<String, dynamic> json) {
  return _Tickets.fromJson(json);
}

/// @nodoc
mixin _$Tickets {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketCodeId")
  String? get ticketCodeId => throw _privateConstructorUsedError;
  @JsonKey(name: "image")
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: "customer")
  String? get customer => throw _privateConstructorUsedError;
  @JsonKey(name: "date")
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: "status")
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: "statusAr")
  String? get statusAr => throw _privateConstructorUsedError;
  @JsonKey(name: "time")
  String? get time => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketType")
  String? get ticketType => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketTypeAr")
  String? get ticketTypeAr => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketTitle")
  String? get ticketTitle => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketDescription")
  String? get ticketDescription => throw _privateConstructorUsedError;
  @JsonKey(name: "serviceDescription")
  String? get serviceDescription => throw _privateConstructorUsedError;
  @JsonKey(name: "locationMap")
  String? get locationMap => throw _privateConstructorUsedError;
  @JsonKey(name: "havingFemaleEngineer")
  bool? get havingFemaleEngineer => throw _privateConstructorUsedError;
  @JsonKey(name: "withMaterial")
  bool? get withMaterial => throw _privateConstructorUsedError;
  @JsonKey(name: "tools")
  List<int>? get tools => throw _privateConstructorUsedError;
  @JsonKey(name: "ticketTimeTo")
  String? get ticketTimeTo => throw _privateConstructorUsedError;
  @JsonKey(name: "mainService")
  MainServiceInfo? get mainService => throw _privateConstructorUsedError;
  @JsonKey(name: "subService")
  SubServiceInfo? get subService => throw _privateConstructorUsedError;
  @JsonKey(name: "branch")
  BranchInfo? get branch => throw _privateConstructorUsedError;
  @JsonKey(name: "zone")
  ZoneInfo? get zone => throw _privateConstructorUsedError;
  @JsonKey(name: "contract")
  ContractInfo? get contract => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TicketsCopyWith<Tickets> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketsCopyWith<$Res> {
  factory $TicketsCopyWith(Tickets value, $Res Function(Tickets) then) =
      _$TicketsCopyWithImpl<$Res, Tickets>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
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
      @JsonKey(name: "contract") ContractInfo? contract});

  $MainServiceInfoCopyWith<$Res>? get mainService;
  $SubServiceInfoCopyWith<$Res>? get subService;
  $BranchInfoCopyWith<$Res>? get branch;
  $ZoneInfoCopyWith<$Res>? get zone;
  $ContractInfoCopyWith<$Res>? get contract;
}

/// @nodoc
class _$TicketsCopyWithImpl<$Res, $Val extends Tickets>
    implements $TicketsCopyWith<$Res> {
  _$TicketsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ticketCodeId = freezed,
    Object? image = freezed,
    Object? customer = freezed,
    Object? date = freezed,
    Object? status = freezed,
    Object? statusAr = freezed,
    Object? time = freezed,
    Object? ticketType = freezed,
    Object? ticketTypeAr = freezed,
    Object? ticketTitle = freezed,
    Object? ticketDescription = freezed,
    Object? serviceDescription = freezed,
    Object? locationMap = freezed,
    Object? havingFemaleEngineer = freezed,
    Object? withMaterial = freezed,
    Object? tools = freezed,
    Object? ticketTimeTo = freezed,
    Object? mainService = freezed,
    Object? subService = freezed,
    Object? branch = freezed,
    Object? zone = freezed,
    Object? contract = freezed,
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
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      statusAr: freezed == statusAr
          ? _value.statusAr
          : statusAr // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketType: freezed == ticketType
          ? _value.ticketType
          : ticketType // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketTypeAr: freezed == ticketTypeAr
          ? _value.ticketTypeAr
          : ticketTypeAr // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketTitle: freezed == ticketTitle
          ? _value.ticketTitle
          : ticketTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketDescription: freezed == ticketDescription
          ? _value.ticketDescription
          : ticketDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceDescription: freezed == serviceDescription
          ? _value.serviceDescription
          : serviceDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      locationMap: freezed == locationMap
          ? _value.locationMap
          : locationMap // ignore: cast_nullable_to_non_nullable
              as String?,
      havingFemaleEngineer: freezed == havingFemaleEngineer
          ? _value.havingFemaleEngineer
          : havingFemaleEngineer // ignore: cast_nullable_to_non_nullable
              as bool?,
      withMaterial: freezed == withMaterial
          ? _value.withMaterial
          : withMaterial // ignore: cast_nullable_to_non_nullable
              as bool?,
      tools: freezed == tools
          ? _value.tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      ticketTimeTo: freezed == ticketTimeTo
          ? _value.ticketTimeTo
          : ticketTimeTo // ignore: cast_nullable_to_non_nullable
              as String?,
      mainService: freezed == mainService
          ? _value.mainService
          : mainService // ignore: cast_nullable_to_non_nullable
              as MainServiceInfo?,
      subService: freezed == subService
          ? _value.subService
          : subService // ignore: cast_nullable_to_non_nullable
              as SubServiceInfo?,
      branch: freezed == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as BranchInfo?,
      zone: freezed == zone
          ? _value.zone
          : zone // ignore: cast_nullable_to_non_nullable
              as ZoneInfo?,
      contract: freezed == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as ContractInfo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MainServiceInfoCopyWith<$Res>? get mainService {
    if (_value.mainService == null) {
      return null;
    }

    return $MainServiceInfoCopyWith<$Res>(_value.mainService!, (value) {
      return _then(_value.copyWith(mainService: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SubServiceInfoCopyWith<$Res>? get subService {
    if (_value.subService == null) {
      return null;
    }

    return $SubServiceInfoCopyWith<$Res>(_value.subService!, (value) {
      return _then(_value.copyWith(subService: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BranchInfoCopyWith<$Res>? get branch {
    if (_value.branch == null) {
      return null;
    }

    return $BranchInfoCopyWith<$Res>(_value.branch!, (value) {
      return _then(_value.copyWith(branch: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ZoneInfoCopyWith<$Res>? get zone {
    if (_value.zone == null) {
      return null;
    }

    return $ZoneInfoCopyWith<$Res>(_value.zone!, (value) {
      return _then(_value.copyWith(zone: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ContractInfoCopyWith<$Res>? get contract {
    if (_value.contract == null) {
      return null;
    }

    return $ContractInfoCopyWith<$Res>(_value.contract!, (value) {
      return _then(_value.copyWith(contract: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TicketsImplCopyWith<$Res> implements $TicketsCopyWith<$Res> {
  factory _$$TicketsImplCopyWith(
          _$TicketsImpl value, $Res Function(_$TicketsImpl) then) =
      __$$TicketsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
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
      @JsonKey(name: "contract") ContractInfo? contract});

  @override
  $MainServiceInfoCopyWith<$Res>? get mainService;
  @override
  $SubServiceInfoCopyWith<$Res>? get subService;
  @override
  $BranchInfoCopyWith<$Res>? get branch;
  @override
  $ZoneInfoCopyWith<$Res>? get zone;
  @override
  $ContractInfoCopyWith<$Res>? get contract;
}

/// @nodoc
class __$$TicketsImplCopyWithImpl<$Res>
    extends _$TicketsCopyWithImpl<$Res, _$TicketsImpl>
    implements _$$TicketsImplCopyWith<$Res> {
  __$$TicketsImplCopyWithImpl(
      _$TicketsImpl _value, $Res Function(_$TicketsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ticketCodeId = freezed,
    Object? image = freezed,
    Object? customer = freezed,
    Object? date = freezed,
    Object? status = freezed,
    Object? statusAr = freezed,
    Object? time = freezed,
    Object? ticketType = freezed,
    Object? ticketTypeAr = freezed,
    Object? ticketTitle = freezed,
    Object? ticketDescription = freezed,
    Object? serviceDescription = freezed,
    Object? locationMap = freezed,
    Object? havingFemaleEngineer = freezed,
    Object? withMaterial = freezed,
    Object? tools = freezed,
    Object? ticketTimeTo = freezed,
    Object? mainService = freezed,
    Object? subService = freezed,
    Object? branch = freezed,
    Object? zone = freezed,
    Object? contract = freezed,
  }) {
    return _then(_$TicketsImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      ticketCodeId: freezed == ticketCodeId
          ? _value.ticketCodeId
          : ticketCodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      statusAr: freezed == statusAr
          ? _value.statusAr
          : statusAr // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketType: freezed == ticketType
          ? _value.ticketType
          : ticketType // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketTypeAr: freezed == ticketTypeAr
          ? _value.ticketTypeAr
          : ticketTypeAr // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketTitle: freezed == ticketTitle
          ? _value.ticketTitle
          : ticketTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketDescription: freezed == ticketDescription
          ? _value.ticketDescription
          : ticketDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceDescription: freezed == serviceDescription
          ? _value.serviceDescription
          : serviceDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      locationMap: freezed == locationMap
          ? _value.locationMap
          : locationMap // ignore: cast_nullable_to_non_nullable
              as String?,
      havingFemaleEngineer: freezed == havingFemaleEngineer
          ? _value.havingFemaleEngineer
          : havingFemaleEngineer // ignore: cast_nullable_to_non_nullable
              as bool?,
      withMaterial: freezed == withMaterial
          ? _value.withMaterial
          : withMaterial // ignore: cast_nullable_to_non_nullable
              as bool?,
      tools: freezed == tools
          ? _value._tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      ticketTimeTo: freezed == ticketTimeTo
          ? _value.ticketTimeTo
          : ticketTimeTo // ignore: cast_nullable_to_non_nullable
              as String?,
      mainService: freezed == mainService
          ? _value.mainService
          : mainService // ignore: cast_nullable_to_non_nullable
              as MainServiceInfo?,
      subService: freezed == subService
          ? _value.subService
          : subService // ignore: cast_nullable_to_non_nullable
              as SubServiceInfo?,
      branch: freezed == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as BranchInfo?,
      zone: freezed == zone
          ? _value.zone
          : zone // ignore: cast_nullable_to_non_nullable
              as ZoneInfo?,
      contract: freezed == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as ContractInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketsImpl implements _Tickets {
  const _$TicketsImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "ticketCodeId") this.ticketCodeId,
      @JsonKey(name: "image") this.image,
      @JsonKey(name: "customer") this.customer,
      @JsonKey(name: "date") this.date,
      @JsonKey(name: "status") this.status,
      @JsonKey(name: "statusAr") this.statusAr,
      @JsonKey(name: "time") this.time,
      @JsonKey(name: "ticketType") this.ticketType,
      @JsonKey(name: "ticketTypeAr") this.ticketTypeAr,
      @JsonKey(name: "ticketTitle") this.ticketTitle,
      @JsonKey(name: "ticketDescription") this.ticketDescription,
      @JsonKey(name: "serviceDescription") this.serviceDescription,
      @JsonKey(name: "locationMap") this.locationMap,
      @JsonKey(name: "havingFemaleEngineer") this.havingFemaleEngineer,
      @JsonKey(name: "withMaterial") this.withMaterial,
      @JsonKey(name: "tools") final List<int>? tools,
      @JsonKey(name: "ticketTimeTo") this.ticketTimeTo,
      @JsonKey(name: "mainService") this.mainService,
      @JsonKey(name: "subService") this.subService,
      @JsonKey(name: "branch") this.branch,
      @JsonKey(name: "zone") this.zone,
      @JsonKey(name: "contract") this.contract})
      : _tools = tools;

  factory _$TicketsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketsImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "ticketCodeId")
  final String? ticketCodeId;
  @override
  @JsonKey(name: "image")
  final String? image;
  @override
  @JsonKey(name: "customer")
  final String? customer;
  @override
  @JsonKey(name: "date")
  final DateTime? date;
  @override
  @JsonKey(name: "status")
  final String? status;
  @override
  @JsonKey(name: "statusAr")
  final String? statusAr;
  @override
  @JsonKey(name: "time")
  final String? time;
  @override
  @JsonKey(name: "ticketType")
  final String? ticketType;
  @override
  @JsonKey(name: "ticketTypeAr")
  final String? ticketTypeAr;
  @override
  @JsonKey(name: "ticketTitle")
  final String? ticketTitle;
  @override
  @JsonKey(name: "ticketDescription")
  final String? ticketDescription;
  @override
  @JsonKey(name: "serviceDescription")
  final String? serviceDescription;
  @override
  @JsonKey(name: "locationMap")
  final String? locationMap;
  @override
  @JsonKey(name: "havingFemaleEngineer")
  final bool? havingFemaleEngineer;
  @override
  @JsonKey(name: "withMaterial")
  final bool? withMaterial;
  final List<int>? _tools;
  @override
  @JsonKey(name: "tools")
  List<int>? get tools {
    final value = _tools;
    if (value == null) return null;
    if (_tools is EqualUnmodifiableListView) return _tools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "ticketTimeTo")
  final String? ticketTimeTo;
  @override
  @JsonKey(name: "mainService")
  final MainServiceInfo? mainService;
  @override
  @JsonKey(name: "subService")
  final SubServiceInfo? subService;
  @override
  @JsonKey(name: "branch")
  final BranchInfo? branch;
  @override
  @JsonKey(name: "zone")
  final ZoneInfo? zone;
  @override
  @JsonKey(name: "contract")
  final ContractInfo? contract;

  @override
  String toString() {
    return 'Tickets(id: $id, ticketCodeId: $ticketCodeId, image: $image, customer: $customer, date: $date, status: $status, statusAr: $statusAr, time: $time, ticketType: $ticketType, ticketTypeAr: $ticketTypeAr, ticketTitle: $ticketTitle, ticketDescription: $ticketDescription, serviceDescription: $serviceDescription, locationMap: $locationMap, havingFemaleEngineer: $havingFemaleEngineer, withMaterial: $withMaterial, tools: $tools, ticketTimeTo: $ticketTimeTo, mainService: $mainService, subService: $subService, branch: $branch, zone: $zone, contract: $contract)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ticketCodeId, ticketCodeId) ||
                other.ticketCodeId == ticketCodeId) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusAr, statusAr) ||
                other.statusAr == statusAr) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.ticketType, ticketType) ||
                other.ticketType == ticketType) &&
            (identical(other.ticketTypeAr, ticketTypeAr) ||
                other.ticketTypeAr == ticketTypeAr) &&
            (identical(other.ticketTitle, ticketTitle) ||
                other.ticketTitle == ticketTitle) &&
            (identical(other.ticketDescription, ticketDescription) ||
                other.ticketDescription == ticketDescription) &&
            (identical(other.serviceDescription, serviceDescription) ||
                other.serviceDescription == serviceDescription) &&
            (identical(other.locationMap, locationMap) ||
                other.locationMap == locationMap) &&
            (identical(other.havingFemaleEngineer, havingFemaleEngineer) ||
                other.havingFemaleEngineer == havingFemaleEngineer) &&
            (identical(other.withMaterial, withMaterial) ||
                other.withMaterial == withMaterial) &&
            const DeepCollectionEquality().equals(other._tools, _tools) &&
            (identical(other.ticketTimeTo, ticketTimeTo) ||
                other.ticketTimeTo == ticketTimeTo) &&
            (identical(other.mainService, mainService) ||
                other.mainService == mainService) &&
            (identical(other.subService, subService) ||
                other.subService == subService) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.zone, zone) || other.zone == zone) &&
            (identical(other.contract, contract) ||
                other.contract == contract));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        ticketCodeId,
        image,
        customer,
        date,
        status,
        statusAr,
        time,
        ticketType,
        ticketTypeAr,
        ticketTitle,
        ticketDescription,
        serviceDescription,
        locationMap,
        havingFemaleEngineer,
        withMaterial,
        const DeepCollectionEquality().hash(_tools),
        ticketTimeTo,
        mainService,
        subService,
        branch,
        zone,
        contract
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketsImplCopyWith<_$TicketsImpl> get copyWith =>
      __$$TicketsImplCopyWithImpl<_$TicketsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketsImplToJson(
      this,
    );
  }
}

abstract class _Tickets implements Tickets {
  const factory _Tickets(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "ticketCodeId") final String? ticketCodeId,
      @JsonKey(name: "image") final String? image,
      @JsonKey(name: "customer") final String? customer,
      @JsonKey(name: "date") final DateTime? date,
      @JsonKey(name: "status") final String? status,
      @JsonKey(name: "statusAr") final String? statusAr,
      @JsonKey(name: "time") final String? time,
      @JsonKey(name: "ticketType") final String? ticketType,
      @JsonKey(name: "ticketTypeAr") final String? ticketTypeAr,
      @JsonKey(name: "ticketTitle") final String? ticketTitle,
      @JsonKey(name: "ticketDescription") final String? ticketDescription,
      @JsonKey(name: "serviceDescription") final String? serviceDescription,
      @JsonKey(name: "locationMap") final String? locationMap,
      @JsonKey(name: "havingFemaleEngineer") final bool? havingFemaleEngineer,
      @JsonKey(name: "withMaterial") final bool? withMaterial,
      @JsonKey(name: "tools") final List<int>? tools,
      @JsonKey(name: "ticketTimeTo") final String? ticketTimeTo,
      @JsonKey(name: "mainService") final MainServiceInfo? mainService,
      @JsonKey(name: "subService") final SubServiceInfo? subService,
      @JsonKey(name: "branch") final BranchInfo? branch,
      @JsonKey(name: "zone") final ZoneInfo? zone,
      @JsonKey(name: "contract") final ContractInfo? contract}) = _$TicketsImpl;

  factory _Tickets.fromJson(Map<String, dynamic> json) = _$TicketsImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "ticketCodeId")
  String? get ticketCodeId;
  @override
  @JsonKey(name: "image")
  String? get image;
  @override
  @JsonKey(name: "customer")
  String? get customer;
  @override
  @JsonKey(name: "date")
  DateTime? get date;
  @override
  @JsonKey(name: "status")
  String? get status;
  @override
  @JsonKey(name: "statusAr")
  String? get statusAr;
  @override
  @JsonKey(name: "time")
  String? get time;
  @override
  @JsonKey(name: "ticketType")
  String? get ticketType;
  @override
  @JsonKey(name: "ticketTypeAr")
  String? get ticketTypeAr;
  @override
  @JsonKey(name: "ticketTitle")
  String? get ticketTitle;
  @override
  @JsonKey(name: "ticketDescription")
  String? get ticketDescription;
  @override
  @JsonKey(name: "serviceDescription")
  String? get serviceDescription;
  @override
  @JsonKey(name: "locationMap")
  String? get locationMap;
  @override
  @JsonKey(name: "havingFemaleEngineer")
  bool? get havingFemaleEngineer;
  @override
  @JsonKey(name: "withMaterial")
  bool? get withMaterial;
  @override
  @JsonKey(name: "tools")
  List<int>? get tools;
  @override
  @JsonKey(name: "ticketTimeTo")
  String? get ticketTimeTo;
  @override
  @JsonKey(name: "mainService")
  MainServiceInfo? get mainService;
  @override
  @JsonKey(name: "subService")
  SubServiceInfo? get subService;
  @override
  @JsonKey(name: "branch")
  BranchInfo? get branch;
  @override
  @JsonKey(name: "zone")
  ZoneInfo? get zone;
  @override
  @JsonKey(name: "contract")
  ContractInfo? get contract;
  @override
  @JsonKey(ignore: true)
  _$$TicketsImplCopyWith<_$TicketsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MainServiceInfo _$MainServiceInfoFromJson(Map<String, dynamic> json) {
  return _MainServiceInfo.fromJson(json);
}

/// @nodoc
mixin _$MainServiceInfo {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "nameArabic")
  String? get nameArabic => throw _privateConstructorUsedError;
  @JsonKey(name: "image")
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MainServiceInfoCopyWith<MainServiceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainServiceInfoCopyWith<$Res> {
  factory $MainServiceInfoCopyWith(
          MainServiceInfo value, $Res Function(MainServiceInfo) then) =
      _$MainServiceInfoCopyWithImpl<$Res, MainServiceInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameArabic") String? nameArabic,
      @JsonKey(name: "image") String? image});
}

/// @nodoc
class _$MainServiceInfoCopyWithImpl<$Res, $Val extends MainServiceInfo>
    implements $MainServiceInfoCopyWith<$Res> {
  _$MainServiceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameArabic = freezed,
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
      nameArabic: freezed == nameArabic
          ? _value.nameArabic
          : nameArabic // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainServiceInfoImplCopyWith<$Res>
    implements $MainServiceInfoCopyWith<$Res> {
  factory _$$MainServiceInfoImplCopyWith(_$MainServiceInfoImpl value,
          $Res Function(_$MainServiceInfoImpl) then) =
      __$$MainServiceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameArabic") String? nameArabic,
      @JsonKey(name: "image") String? image});
}

/// @nodoc
class __$$MainServiceInfoImplCopyWithImpl<$Res>
    extends _$MainServiceInfoCopyWithImpl<$Res, _$MainServiceInfoImpl>
    implements _$$MainServiceInfoImplCopyWith<$Res> {
  __$$MainServiceInfoImplCopyWithImpl(
      _$MainServiceInfoImpl _value, $Res Function(_$MainServiceInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameArabic = freezed,
    Object? image = freezed,
  }) {
    return _then(_$MainServiceInfoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameArabic: freezed == nameArabic
          ? _value.nameArabic
          : nameArabic // ignore: cast_nullable_to_non_nullable
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
class _$MainServiceInfoImpl implements _MainServiceInfo {
  const _$MainServiceInfoImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "nameArabic") this.nameArabic,
      @JsonKey(name: "image") this.image});

  factory _$MainServiceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MainServiceInfoImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "nameArabic")
  final String? nameArabic;
  @override
  @JsonKey(name: "image")
  final String? image;

  @override
  String toString() {
    return 'MainServiceInfo(id: $id, name: $name, nameArabic: $nameArabic, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainServiceInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameArabic, nameArabic) ||
                other.nameArabic == nameArabic) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nameArabic, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainServiceInfoImplCopyWith<_$MainServiceInfoImpl> get copyWith =>
      __$$MainServiceInfoImplCopyWithImpl<_$MainServiceInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MainServiceInfoImplToJson(
      this,
    );
  }
}

abstract class _MainServiceInfo implements MainServiceInfo {
  const factory _MainServiceInfo(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "name") final String? name,
      @JsonKey(name: "nameArabic") final String? nameArabic,
      @JsonKey(name: "image") final String? image}) = _$MainServiceInfoImpl;

  factory _MainServiceInfo.fromJson(Map<String, dynamic> json) =
      _$MainServiceInfoImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "nameArabic")
  String? get nameArabic;
  @override
  @JsonKey(name: "image")
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$MainServiceInfoImplCopyWith<_$MainServiceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubServiceInfo _$SubServiceInfoFromJson(Map<String, dynamic> json) {
  return _SubServiceInfo.fromJson(json);
}

/// @nodoc
mixin _$SubServiceInfo {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "nameArabic")
  String? get nameArabic => throw _privateConstructorUsedError;
  @JsonKey(name: "image")
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubServiceInfoCopyWith<SubServiceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubServiceInfoCopyWith<$Res> {
  factory $SubServiceInfoCopyWith(
          SubServiceInfo value, $Res Function(SubServiceInfo) then) =
      _$SubServiceInfoCopyWithImpl<$Res, SubServiceInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameArabic") String? nameArabic,
      @JsonKey(name: "image") String? image});
}

/// @nodoc
class _$SubServiceInfoCopyWithImpl<$Res, $Val extends SubServiceInfo>
    implements $SubServiceInfoCopyWith<$Res> {
  _$SubServiceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameArabic = freezed,
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
      nameArabic: freezed == nameArabic
          ? _value.nameArabic
          : nameArabic // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubServiceInfoImplCopyWith<$Res>
    implements $SubServiceInfoCopyWith<$Res> {
  factory _$$SubServiceInfoImplCopyWith(_$SubServiceInfoImpl value,
          $Res Function(_$SubServiceInfoImpl) then) =
      __$$SubServiceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "nameArabic") String? nameArabic,
      @JsonKey(name: "image") String? image});
}

/// @nodoc
class __$$SubServiceInfoImplCopyWithImpl<$Res>
    extends _$SubServiceInfoCopyWithImpl<$Res, _$SubServiceInfoImpl>
    implements _$$SubServiceInfoImplCopyWith<$Res> {
  __$$SubServiceInfoImplCopyWithImpl(
      _$SubServiceInfoImpl _value, $Res Function(_$SubServiceInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameArabic = freezed,
    Object? image = freezed,
  }) {
    return _then(_$SubServiceInfoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameArabic: freezed == nameArabic
          ? _value.nameArabic
          : nameArabic // ignore: cast_nullable_to_non_nullable
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
class _$SubServiceInfoImpl implements _SubServiceInfo {
  const _$SubServiceInfoImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "nameArabic") this.nameArabic,
      @JsonKey(name: "image") this.image});

  factory _$SubServiceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubServiceInfoImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "nameArabic")
  final String? nameArabic;
  @override
  @JsonKey(name: "image")
  final String? image;

  @override
  String toString() {
    return 'SubServiceInfo(id: $id, name: $name, nameArabic: $nameArabic, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubServiceInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameArabic, nameArabic) ||
                other.nameArabic == nameArabic) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nameArabic, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubServiceInfoImplCopyWith<_$SubServiceInfoImpl> get copyWith =>
      __$$SubServiceInfoImplCopyWithImpl<_$SubServiceInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubServiceInfoImplToJson(
      this,
    );
  }
}

abstract class _SubServiceInfo implements SubServiceInfo {
  const factory _SubServiceInfo(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "name") final String? name,
      @JsonKey(name: "nameArabic") final String? nameArabic,
      @JsonKey(name: "image") final String? image}) = _$SubServiceInfoImpl;

  factory _SubServiceInfo.fromJson(Map<String, dynamic> json) =
      _$SubServiceInfoImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "nameArabic")
  String? get nameArabic;
  @override
  @JsonKey(name: "image")
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$SubServiceInfoImplCopyWith<_$SubServiceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BranchInfo _$BranchInfoFromJson(Map<String, dynamic> json) {
  return _BranchInfo.fromJson(json);
}

/// @nodoc
mixin _$BranchInfo {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: "nameArabic")
  String? get nameArabic => throw _privateConstructorUsedError;
  @JsonKey(name: "nameEnglish")
  String? get nameEnglish => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BranchInfoCopyWith<BranchInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchInfoCopyWith<$Res> {
  factory $BranchInfoCopyWith(
          BranchInfo value, $Res Function(BranchInfo) then) =
      _$BranchInfoCopyWithImpl<$Res, BranchInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "nameArabic") String? nameArabic,
      @JsonKey(name: "nameEnglish") String? nameEnglish});
}

/// @nodoc
class _$BranchInfoCopyWithImpl<$Res, $Val extends BranchInfo>
    implements $BranchInfoCopyWith<$Res> {
  _$BranchInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? nameArabic = freezed,
    Object? nameEnglish = freezed,
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
      nameArabic: freezed == nameArabic
          ? _value.nameArabic
          : nameArabic // ignore: cast_nullable_to_non_nullable
              as String?,
      nameEnglish: freezed == nameEnglish
          ? _value.nameEnglish
          : nameEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BranchInfoImplCopyWith<$Res>
    implements $BranchInfoCopyWith<$Res> {
  factory _$$BranchInfoImplCopyWith(
          _$BranchInfoImpl value, $Res Function(_$BranchInfoImpl) then) =
      __$$BranchInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "nameArabic") String? nameArabic,
      @JsonKey(name: "nameEnglish") String? nameEnglish});
}

/// @nodoc
class __$$BranchInfoImplCopyWithImpl<$Res>
    extends _$BranchInfoCopyWithImpl<$Res, _$BranchInfoImpl>
    implements _$$BranchInfoImplCopyWith<$Res> {
  __$$BranchInfoImplCopyWithImpl(
      _$BranchInfoImpl _value, $Res Function(_$BranchInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? nameArabic = freezed,
    Object? nameEnglish = freezed,
  }) {
    return _then(_$BranchInfoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      nameArabic: freezed == nameArabic
          ? _value.nameArabic
          : nameArabic // ignore: cast_nullable_to_non_nullable
              as String?,
      nameEnglish: freezed == nameEnglish
          ? _value.nameEnglish
          : nameEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchInfoImpl implements _BranchInfo {
  const _$BranchInfoImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "title") this.title,
      @JsonKey(name: "nameArabic") this.nameArabic,
      @JsonKey(name: "nameEnglish") this.nameEnglish});

  factory _$BranchInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchInfoImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "title")
  final String? title;
  @override
  @JsonKey(name: "nameArabic")
  final String? nameArabic;
  @override
  @JsonKey(name: "nameEnglish")
  final String? nameEnglish;

  @override
  String toString() {
    return 'BranchInfo(id: $id, title: $title, nameArabic: $nameArabic, nameEnglish: $nameEnglish)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.nameArabic, nameArabic) ||
                other.nameArabic == nameArabic) &&
            (identical(other.nameEnglish, nameEnglish) ||
                other.nameEnglish == nameEnglish));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, nameArabic, nameEnglish);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchInfoImplCopyWith<_$BranchInfoImpl> get copyWith =>
      __$$BranchInfoImplCopyWithImpl<_$BranchInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchInfoImplToJson(
      this,
    );
  }
}

abstract class _BranchInfo implements BranchInfo {
  const factory _BranchInfo(
          {@JsonKey(name: "id") final int? id,
          @JsonKey(name: "title") final String? title,
          @JsonKey(name: "nameArabic") final String? nameArabic,
          @JsonKey(name: "nameEnglish") final String? nameEnglish}) =
      _$BranchInfoImpl;

  factory _BranchInfo.fromJson(Map<String, dynamic> json) =
      _$BranchInfoImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "title")
  String? get title;
  @override
  @JsonKey(name: "nameArabic")
  String? get nameArabic;
  @override
  @JsonKey(name: "nameEnglish")
  String? get nameEnglish;
  @override
  @JsonKey(ignore: true)
  _$$BranchInfoImplCopyWith<_$BranchInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ZoneInfo _$ZoneInfoFromJson(Map<String, dynamic> json) {
  return _ZoneInfo.fromJson(json);
}

/// @nodoc
mixin _$ZoneInfo {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: "number")
  String? get number => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ZoneInfoCopyWith<ZoneInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZoneInfoCopyWith<$Res> {
  factory $ZoneInfoCopyWith(ZoneInfo value, $Res Function(ZoneInfo) then) =
      _$ZoneInfoCopyWithImpl<$Res, ZoneInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "number") String? number});
}

/// @nodoc
class _$ZoneInfoCopyWithImpl<$Res, $Val extends ZoneInfo>
    implements $ZoneInfoCopyWith<$Res> {
  _$ZoneInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? number = freezed,
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
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ZoneInfoImplCopyWith<$Res>
    implements $ZoneInfoCopyWith<$Res> {
  factory _$$ZoneInfoImplCopyWith(
          _$ZoneInfoImpl value, $Res Function(_$ZoneInfoImpl) then) =
      __$$ZoneInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "number") String? number});
}

/// @nodoc
class __$$ZoneInfoImplCopyWithImpl<$Res>
    extends _$ZoneInfoCopyWithImpl<$Res, _$ZoneInfoImpl>
    implements _$$ZoneInfoImplCopyWith<$Res> {
  __$$ZoneInfoImplCopyWithImpl(
      _$ZoneInfoImpl _value, $Res Function(_$ZoneInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? number = freezed,
  }) {
    return _then(_$ZoneInfoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ZoneInfoImpl implements _ZoneInfo {
  const _$ZoneInfoImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "title") this.title,
      @JsonKey(name: "number") this.number});

  factory _$ZoneInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ZoneInfoImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "title")
  final String? title;
  @override
  @JsonKey(name: "number")
  final String? number;

  @override
  String toString() {
    return 'ZoneInfo(id: $id, title: $title, number: $number)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ZoneInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.number, number) || other.number == number));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, number);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ZoneInfoImplCopyWith<_$ZoneInfoImpl> get copyWith =>
      __$$ZoneInfoImplCopyWithImpl<_$ZoneInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ZoneInfoImplToJson(
      this,
    );
  }
}

abstract class _ZoneInfo implements ZoneInfo {
  const factory _ZoneInfo(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "title") final String? title,
      @JsonKey(name: "number") final String? number}) = _$ZoneInfoImpl;

  factory _ZoneInfo.fromJson(Map<String, dynamic> json) =
      _$ZoneInfoImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "title")
  String? get title;
  @override
  @JsonKey(name: "number")
  String? get number;
  @override
  @JsonKey(ignore: true)
  _$$ZoneInfoImplCopyWith<_$ZoneInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContractInfo _$ContractInfoFromJson(Map<String, dynamic> json) {
  return _ContractInfo.fromJson(json);
}

/// @nodoc
mixin _$ContractInfo {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: "reference")
  String? get reference => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContractInfoCopyWith<ContractInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContractInfoCopyWith<$Res> {
  factory $ContractInfoCopyWith(
          ContractInfo value, $Res Function(ContractInfo) then) =
      _$ContractInfoCopyWithImpl<$Res, ContractInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "reference") String? reference});
}

/// @nodoc
class _$ContractInfoCopyWithImpl<$Res, $Val extends ContractInfo>
    implements $ContractInfoCopyWith<$Res> {
  _$ContractInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? reference = freezed,
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
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContractInfoImplCopyWith<$Res>
    implements $ContractInfoCopyWith<$Res> {
  factory _$$ContractInfoImplCopyWith(
          _$ContractInfoImpl value, $Res Function(_$ContractInfoImpl) then) =
      __$$ContractInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "reference") String? reference});
}

/// @nodoc
class __$$ContractInfoImplCopyWithImpl<$Res>
    extends _$ContractInfoCopyWithImpl<$Res, _$ContractInfoImpl>
    implements _$$ContractInfoImplCopyWith<$Res> {
  __$$ContractInfoImplCopyWithImpl(
      _$ContractInfoImpl _value, $Res Function(_$ContractInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? reference = freezed,
  }) {
    return _then(_$ContractInfoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContractInfoImpl implements _ContractInfo {
  const _$ContractInfoImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "title") this.title,
      @JsonKey(name: "reference") this.reference});

  factory _$ContractInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContractInfoImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "title")
  final String? title;
  @override
  @JsonKey(name: "reference")
  final String? reference;

  @override
  String toString() {
    return 'ContractInfo(id: $id, title: $title, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, reference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContractInfoImplCopyWith<_$ContractInfoImpl> get copyWith =>
      __$$ContractInfoImplCopyWithImpl<_$ContractInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContractInfoImplToJson(
      this,
    );
  }
}

abstract class _ContractInfo implements ContractInfo {
  const factory _ContractInfo(
          {@JsonKey(name: "id") final int? id,
          @JsonKey(name: "title") final String? title,
          @JsonKey(name: "reference") final String? reference}) =
      _$ContractInfoImpl;

  factory _ContractInfo.fromJson(Map<String, dynamic> json) =
      _$ContractInfoImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "title")
  String? get title;
  @override
  @JsonKey(name: "reference")
  String? get reference;
  @override
  @JsonKey(ignore: true)
  _$$ContractInfoImplCopyWith<_$ContractInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
