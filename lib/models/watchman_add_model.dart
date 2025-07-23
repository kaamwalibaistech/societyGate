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
  dynamic message;
  Data? data;

  WatchManAddModel({
    this.status,
    this.message,
    this.data,
  });

  factory WatchManAddModel.fromJson(Map<String, dynamic> json) =>
      WatchManAddModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? societyId;
  String? urole;
  String? uname;
  String? uemail;
  String? uphone;
  String? approvalStatus;
  String? profileImage;
  String? uniqueCode;
  int? userId;

  Data({
    this.societyId,
    this.urole,
    this.uname,
    this.uemail,
    this.uphone,
    this.approvalStatus,
    this.profileImage,
    this.uniqueCode,
    this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        societyId: json["society_id"],
        urole: json["urole"],
        uname: json["uname"],
        uemail: json["uemail"],
        uphone: json["uphone"],
        approvalStatus: json["approval_status"],
        profileImage: json["profile_image"],
        uniqueCode: json["unique_code"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "urole": urole,
        "uname": uname,
        "uemail": uemail,
        "uphone": uphone,
        "approval_status": approvalStatus,
        "profile_image": profileImage,
        "unique_code": uniqueCode,
        "user_id": userId,
      };
}
