// To parse this JSON data, do
//
//     final updateUserModel = updateUserModelFromJson(jsonString);

import 'dart:convert';

UpdateUserModel updateUserModelFromJson(String str) =>
    UpdateUserModel.fromJson(json.decode(str));

String updateUserModelToJson(UpdateUserModel data) =>
    json.encode(data.toJson());

class UpdateUserModel {
  int status;
  String message;
  User user;

  UpdateUserModel({
    required this.status,
    required this.message,
    required this.user,
  });

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  int userId;
  int societyId;
  String urole;
  String uname;
  String uemail;
  String upassword;
  String uphone;
  String approvalStatus;
  DateTime createdAt;

  User({
    required this.userId,
    required this.societyId,
    required this.urole,
    required this.uname,
    required this.uemail,
    required this.upassword,
    required this.uphone,
    required this.approvalStatus,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        societyId: json["society_id"],
        urole: json["urole"],
        uname: json["uname"],
        uemail: json["uemail"],
        upassword: json["upassword"],
        uphone: json["uphone"],
        approvalStatus: json["approval_status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "society_id": societyId,
        "urole": urole,
        "uname": uname,
        "uemail": uemail,
        "upassword": upassword,
        "uphone": uphone,
        "approval_status": approvalStatus,
        "created_at": createdAt.toIso8601String(),
      };
}
