// To parse this JSON data, do
//
//     final memberRegisterModel = memberRegisterModelFromJson(jsonString);

import 'dart:convert';

MemberRegisterModel memberRegisterModelFromJson(String str) =>
    MemberRegisterModel.fromJson(json.decode(str));

String memberRegisterModelToJson(MemberRegisterModel data) =>
    json.encode(data.toJson());

class MemberRegisterModel {
  int? status;
  Message? message;
  Data? data;

  MemberRegisterModel({
    this.status,
    this.message,
    this.data,
  });

  factory MemberRegisterModel.fromJson(Map<String, dynamic> json) =>
      MemberRegisterModel(
        status: json["status"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  User? user;
  Flat? flat;

  Data({
    this.user,
    this.flat,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        flat: json["flat"] == null ? null : Flat.fromJson(json["flat"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "flat": flat?.toJson(),
      };
}

class Flat {
  int? societyId;
  int? memberId;
  String? ownerName;
  String? phone;
  String? flatNumber;
  String? block;
  String? floor;
  String? occupancy;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? flatId;

  Flat({
    this.societyId,
    this.memberId,
    this.ownerName,
    this.phone,
    this.flatNumber,
    this.block,
    this.floor,
    this.occupancy,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.flatId,
  });

  factory Flat.fromJson(Map<String, dynamic> json) => Flat(
        societyId: json["society_id"],
        memberId: json["member_id"],
        ownerName: json["owner_name"],
        phone: json["phone"],
        flatNumber: json["flat_number"],
        block: json["block"],
        floor: json["floor"],
        occupancy: json["occupancy"],
        status: json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        flatId: json["flat_id"],
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "member_id": memberId,
        "owner_name": ownerName,
        "phone": phone,
        "flat_number": flatNumber,
        "block": block,
        "floor": floor,
        "occupancy": occupancy,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "flat_id": flatId,
      };
}

class User {
  int? societyId;
  String? urole;
  String? uname;
  String? uemail;
  String? uphone;
  String? approvalStatus;
  int? userId;

  User({
    this.societyId,
    this.urole,
    this.uname,
    this.uemail,
    this.uphone,
    this.approvalStatus,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        societyId: json["society_id"],
        urole: json["urole"],
        uname: json["uname"],
        uemail: json["uemail"],
        uphone: json["uphone"],
        approvalStatus: json["approval_status"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "urole": urole,
        "uname": uname,
        "uemail": uemail,
        "uphone": uphone,
        "approval_status": approvalStatus,
        "user_id": userId,
      };
}

class Message {
  List<String>? success;
  List<String>? uemail;
  List<String>? uphone;
  List<String>? sregistration_no;

  Message({this.success, this.uemail, this.uphone, this.sregistration_no});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      success: json["success"] == null
          ? []
          : List<String>.from(json["success"]!.map((x) => x)),
      uemail: json["uemail"] == null
          ? []
          : List<String>.from(json["uemail"]!.map((x) => x)),
      uphone: json["uphone"] == null
          ? []
          : List<String>.from(json["uphone"]!.map((x) => x)),
      sregistration_no: json["sregistration_no"] == null
          ? []
          : List<String>.from(json["sregistration_no"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "success":
            success == null ? [] : List<dynamic>.from(success!.map((x) => x)),
        "uemail":
            uemail == null ? [] : List<dynamic>.from(uemail!.map((x) => x)),
        "uphone":
            uphone == null ? [] : List<dynamic>.from(uphone!.map((x) => x)),
        "sregistration_no": sregistration_no == null
            ? []
            : List<dynamic>.from(sregistration_no!.map((x) => x)),
      };
}
