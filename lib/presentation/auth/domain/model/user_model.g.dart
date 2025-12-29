// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int?,
      userNumber: fields[1] as String?,
      fullName: fields[2] as String?,
      fullNameEnglish: fields[3] as String?,
      email: fields[4] as String?,
      mobileNumber: fields[5] as String?,
      countryCode: fields[6] as String?,
      username: fields[7] as String?,
      userRoleId: fields[8] as int?,
      companyId: fields[9] as int?,
      profileImage: fields[10] as String?,
      gender: fields[11] as String?,
      createdAt: fields[12] as DateTime?,
      updatedAt: fields[13] as DateTime?,
      isActive: fields[14] as bool?,
      name: fields[15] as String?,
      mobile: fields[16] as String?,
      image: fields[17] as String?,
      age: fields[18] as String?,
      profession: fields[19] as String?,
      introduce: fields[20] as String?,
      address: fields[21] as String?,
      dateOfBirth: fields[22] as DateTime?,
      rating: fields[23] as String?,
      createdDate: fields[24] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userNumber)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.fullNameEnglish)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.mobileNumber)
      ..writeByte(6)
      ..write(obj.countryCode)
      ..writeByte(7)
      ..write(obj.username)
      ..writeByte(8)
      ..write(obj.userRoleId)
      ..writeByte(9)
      ..write(obj.companyId)
      ..writeByte(10)
      ..write(obj.profileImage)
      ..writeByte(11)
      ..write(obj.gender)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.isActive)
      ..writeByte(15)
      ..write(obj.name)
      ..writeByte(16)
      ..write(obj.mobile)
      ..writeByte(17)
      ..write(obj.image)
      ..writeByte(18)
      ..write(obj.age)
      ..writeByte(19)
      ..write(obj.profession)
      ..writeByte(20)
      ..write(obj.introduce)
      ..writeByte(21)
      ..write(obj.address)
      ..writeByte(22)
      ..write(obj.dateOfBirth)
      ..writeByte(23)
      ..write(obj.rating)
      ..writeByte(24)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      status: json['status'] as bool?,
      token: json['token'] as String?,
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'token': instance.token,
      'message': instance.message,
      'user': instance.user,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num?)?.toInt(),
      userNumber: json['userNumber'] as String?,
      fullName: json['fullName'] as String?,
      fullNameEnglish: json['fullNameEnglish'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      countryCode: json['countryCode'] as String?,
      username: json['username'] as String?,
      userRoleId: (json['userRoleId'] as num?)?.toInt(),
      companyId: (json['companyId'] as num?)?.toInt(),
      profileImage: json['profileImage'] as String?,
      gender: json['gender'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isActive: json['isActive'] as bool?,
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      image: json['image'] as String?,
      age: json['age'] as String?,
      profession: json['profession'] as String?,
      introduce: json['introduce'] as String?,
      address: json['address'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      rating: json['raring'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userNumber': instance.userNumber,
      'fullName': instance.fullName,
      'fullNameEnglish': instance.fullNameEnglish,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'countryCode': instance.countryCode,
      'username': instance.username,
      'userRoleId': instance.userRoleId,
      'companyId': instance.companyId,
      'profileImage': instance.profileImage,
      'gender': instance.gender,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isActive': instance.isActive,
      'name': instance.name,
      'mobile': instance.mobile,
      'image': instance.image,
      'age': instance.age,
      'profession': instance.profession,
      'introduce': instance.introduce,
      'address': instance.address,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'raring': instance.rating,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
