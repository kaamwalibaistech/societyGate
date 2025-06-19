// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? status;
  String? message;
  User? user;

  LoginModel({
    this.status,
    this.message,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson(),
      };
}

class User {
  int? userId;
  int? societyId;
  String? societyName;
  dynamic flatId;
  dynamic flatNumber;
  dynamic block;
  String? role;
  String? uname;
  String? uemail;
  String? uphone;
  String? profileImage;
  DateTime? createdAt;

  User({
    this.userId,
    this.societyId,
    this.societyName,
    this.flatId,
    this.flatNumber,
    this.block,
    this.role,
    this.uname,
    this.uemail,
    this.uphone,
    this.profileImage,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        societyId: json["society_id"],
        societyName: json["society_name"],
        flatId: json["flat_id"],
        flatNumber: json["flat_number"],
        block: json["block"],
        role: json["role"],
        uname: json["uname"],
        uemail: json["uemail"],
        uphone: json["uphone"],
        profileImage: json["profile_image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "society_id": societyId,
        "society_name": societyName,
        "flat_id": flatId,
        "flat_number": flatNumber,
        "block": block,
        "role": role,
        "uname": uname,
        "uemail": uemail,
        "uphone": uphone,
        "profile_image": profileImage,
        "created_at": createdAt?.toIso8601String(),
      };
}
