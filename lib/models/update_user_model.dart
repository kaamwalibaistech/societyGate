// To parse this JSON data, do
//
//     final updateUserModel = updateUserModelFromJson(jsonString);

import 'dart:convert';

UpdateUserModel updateUserModelFromJson(String str) =>
    UpdateUserModel.fromJson(json.decode(str));

String updateUserModelToJson(UpdateUserModel data) =>
    json.encode(data.toJson());

class UpdateUserModel {
  int? status;
  String? message;
  User? user;

  UpdateUserModel({
    this.status,
    this.message,
    this.user,
  });

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserModel(
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
  String? urole;
  String? uname;
  String? uemail;
  String? uphone;
  String? profileImage;
  String? approvalStatus;

  User({
    this.userId,
    this.societyId,
    this.urole,
    this.uname,
    this.uemail,
    this.uphone,
    this.profileImage,
    this.approvalStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        societyId: json["society_id"],
        urole: json["urole"],
        uname: json["uname"],
        uemail: json["uemail"],
        uphone: json["uphone"],
        profileImage: json["profile_image"],
        approvalStatus: json["approval_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "society_id": societyId,
        "urole": urole,
        "uname": uname,
        "uemail": uemail,
        "uphone": uphone,
        "profile_image": profileImage,
        "approval_status": approvalStatus,
      };
}
