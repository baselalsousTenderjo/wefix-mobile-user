// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: "status") bool? status,
    @JsonKey(name: "token") String? token,
    @JsonKey(name: "message") String? message,
    @JsonKey(name: "user") User? user,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@freezed
@HiveType(typeId: 0)
class User with _$User {
  const factory User({
    // Core fields from backend user.model.ts
    @HiveField(0) @JsonKey(name: "id") int? id,
    @HiveField(1) @JsonKey(name: "userNumber") String? userNumber,
    @HiveField(2) @JsonKey(name: "fullName") String? fullName,
    @HiveField(3) @JsonKey(name: "fullNameEnglish") String? fullNameEnglish,
    @HiveField(4) @JsonKey(name: "email") String? email,
    @HiveField(5) @JsonKey(name: "mobileNumber") String? mobileNumber,
    @HiveField(6) @JsonKey(name: "countryCode") String? countryCode,
    @HiveField(7) @JsonKey(name: "username") String? username,
    @HiveField(8) @JsonKey(name: "userRoleId") int? userRoleId,
    @HiveField(9) @JsonKey(name: "companyId") int? companyId,
    @HiveField(10) @JsonKey(name: "profileImage") String? profileImage,
    @HiveField(11) @JsonKey(name: "gender") String? gender,
    @HiveField(12) @JsonKey(name: "createdAt") DateTime? createdAt,
    @HiveField(13) @JsonKey(name: "updatedAt") DateTime? updatedAt,
    @HiveField(14) @JsonKey(name: "isActive") bool? isActive,
    
    // Legacy fields (kept for backward compatibility)
    @HiveField(15) @JsonKey(name: "name") String? name, // Maps to fullName/fullNameEnglish
    @HiveField(16) @JsonKey(name: "mobile") String? mobile, // Maps to mobileNumber
    @HiveField(17) @JsonKey(name: "image") String? image, // Maps to profileImage
    @HiveField(18) @JsonKey(name: "age") String? age,
    @HiveField(19) @JsonKey(name: "profession") String? profession,
    @HiveField(20) @JsonKey(name: "introduce") String? introduce,
    @HiveField(21) @JsonKey(name: "address") String? address,
    @HiveField(22) @JsonKey(name: "dateOfBirth") DateTime? dateOfBirth,
    @HiveField(23) @JsonKey(name: "raring") String? rating,
    @HiveField(24) @JsonKey(name: "createdDate") DateTime? createdDate, // Maps to createdAt
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
