// To parse this JSON data, do
//
//     final memberRegisterModel = memberRegisterModelFromJson(jsonString);

import 'dart:convert';

MemberRegisterModel memberRegisterModelFromJson(String str) =>
    MemberRegisterModel.fromJson(json.decode(str));

String memberRegisterModelToJson(MemberRegisterModel data) =>
    json.encode(data.toJson());

class MemberRegisterModel {
  int status;
  String message;
  User? user;

  MemberRegisterModel({
    required this.status,
    required this.message,
    required this.user,
  });

  factory MemberRegisterModel.fromJson(Map<String, dynamic> json) =>
      MemberRegisterModel(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        user: User?.fromJson(json["user"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson() ?? {},
      };
}

class User {
  int? societyId;
  String? urole;
  String? uname;
  String? uemail;
  String? upassword;
  String? uphone;
  String? approvalStatus;
  int? userId;

  User({
    required this.societyId,
    required this.urole,
    required this.uname,
    required this.uemail,
    required this.upassword,
    required this.uphone,
    required this.approvalStatus,
    required this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        societyId: json["society_id"] ?? 0,
        urole: json["urole"] ?? "",
        uname: json["uname"] ?? "",
        uemail: json["uemail"] ?? "",
        upassword: json["upassword"] ?? "",
        uphone: json["uphone"] ?? "",
        approvalStatus: json["approval_status"] ?? "",
        userId: json["user_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId ?? "",
        "urole": urole ?? "",
        "uname": uname ?? "",
        "uemail": uemail ?? "",
        "upassword": upassword ?? "",
        "uphone": uphone ?? "",
        "approval_status": approvalStatus ?? "",
        "user_id": userId ?? "",
      };
}
