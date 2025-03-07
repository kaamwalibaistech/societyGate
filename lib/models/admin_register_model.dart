// To parse this JSON data, do
//
//     final adminRegister = adminRegisterFromJson(jsonString);

import 'dart:convert';

AdminRegister adminRegisterFromJson(String str) =>
    AdminRegister.fromJson(json.decode(str));

String adminRegisterToJson(AdminRegister data) => json.encode(data.toJson());

class AdminRegister {
  int status;
  String? message;
  Data? data;

  AdminRegister({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AdminRegister.fromJson(Map<String, dynamic> json) => AdminRegister(
        status: json["status"] ?? 0,
        message: json["message"] ?? "",
        data: Data.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message ?? "",
        "data": data?.toJson() ?? {},
      };
}

class Data {
  Society? society;
  User? user;

  Data({
    required this.society,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        society: Society.fromJson(json["society"] ?? {}),
        user: User.fromJson(json["user"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "society": society?.toJson() ?? {},
        "user": user?.toJson() ?? {},
      };
}

class Society {
  String? name;
  String? address;
  String? registrationNo;
  String? totalWings;
  String? totalFlats;
  dynamic aminities;
  String? approvalStatus;
  int? societyId;

  Society({
    required this.name,
    required this.address,
    required this.registrationNo,
    required this.totalWings,
    required this.totalFlats,
    required this.aminities,
    required this.approvalStatus,
    required this.societyId,
  });

  factory Society.fromJson(Map<String, dynamic> json) => Society(
        name: json["name"] ?? "",
        address: json["address"] ?? "",
        registrationNo: json["registration_no"] ?? "",
        totalWings: json["total_wings"] ?? "",
        totalFlats: json["total_flats"] ?? "",
        aminities: json["aminities"],
        approvalStatus: json["approval_status"] ?? "",
        societyId: json["society_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "registration_no": registrationNo,
        "total_wings": totalWings,
        "total_flats": totalFlats,
        "aminities": aminities,
        "approval_status": approvalStatus,
        "society_id": societyId,
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
        "society_id": societyId,
        "urole": urole,
        "uname": uname,
        "uemail": uemail,
        "upassword": upassword,
        "uphone": uphone,
        "approval_status": approvalStatus,
        "user_id": userId,
      };
}
