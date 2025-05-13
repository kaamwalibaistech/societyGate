// To parse this JSON data, do
//
//     final watchManAddModel = watchManAddModelFromJson(jsonString);

import 'dart:convert';

WatchManAddModel watchManAddModelFromJson(String str) =>
    WatchManAddModel.fromJson(json.decode(str));

String watchManAddModelToJson(WatchManAddModel data) =>
    json.encode(data.toJson());

class WatchManAddModel {
  int? status;
  String? message;
  Data? data;

  WatchManAddModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory WatchManAddModel.fromJson(Map<String, dynamic> json) =>
      WatchManAddModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status ?? 0,
        "message": message ?? "",
        "data": data?.toJson() ?? {},
      };
}

class Data {
  String? societyId;
  String? urole;
  String? uname;
  String? uemail;
  String? upassword;
  String? uphone;
  String? approvalStatus;
  int? userId;

  Data({
    required this.societyId,
    required this.urole,
    required this.uname,
    required this.uemail,
    required this.upassword,
    required this.uphone,
    required this.approvalStatus,
    required this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        societyId: json["society_id"] ?? "",
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
