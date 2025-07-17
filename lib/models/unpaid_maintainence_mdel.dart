// To parse this JSON data, do
//
//     final unPaidMaintainenceModel = unPaidMaintainenceModelFromJson(jsonString);

import 'dart:convert';

UnPaidMaintainenceModel unPaidMaintainenceModelFromJson(String str) =>
    UnPaidMaintainenceModel.fromJson(json.decode(str));

String unPaidMaintainenceModelToJson(UnPaidMaintainenceModel data) =>
    json.encode(data.toJson());

class UnPaidMaintainenceModel {
  int? status;
  String? message;
  List<Datum>? data;

  UnPaidMaintainenceModel({
    this.status,
    this.message,
    this.data,
  });

  factory UnPaidMaintainenceModel.fromJson(Map<String, dynamic> json) =>
      UnPaidMaintainenceModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? societyId;
  String? userId;
  List<Maintenance>? maintenance;
  List<Fine>? fines;

  Datum({
    this.societyId,
    this.userId,
    this.maintenance,
    this.fines,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        societyId: json["society_id"],
        userId: json["user_id"],
        maintenance: json["maintenance"] == null
            ? []
            : List<Maintenance>.from(
                json["maintenance"]!.map((x) => Maintenance.fromJson(x))),
        fines: json["fines"] == null
            ? []
            : List<Fine>.from(json["fines"]!.map((x) => Fine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "user_id": userId,
        "maintenance": maintenance == null
            ? []
            : List<dynamic>.from(maintenance!.map((x) => x.toJson())),
        "fines": fines == null
            ? []
            : List<dynamic>.from(fines!.map((x) => x.toJson())),
      };
}

class Fine {
  int? fineId;
  int? societyId;
  int? userId;
  int? flatId;
  String? fineTitle;
  String? fineReason;
  String? fineAmount;
  DateTime? fineDate;
  String? status;
  dynamic attachment;
  dynamic paidAt;
  bool? isChecked;

  Fine({
    this.fineId,
    this.societyId,
    this.userId,
    this.flatId,
    this.fineTitle,
    this.fineReason,
    this.fineAmount,
    this.fineDate,
    this.status,
    this.attachment,
    this.paidAt,
    this.isChecked,
  });

  factory Fine.fromJson(Map<String, dynamic> json) => Fine(
        fineId: json["fine_id"],
        societyId: json["society_id"],
        userId: json["user_id"],
        flatId: json["flat_id"],
        fineTitle: json["fine_title"],
        fineReason: json["fine_reason"],
        fineAmount: json["fine_amount"],
        fineDate: json["fine_date"] == null
            ? null
            : DateTime.parse(json["fine_date"]),
        status: json["status"],
        attachment: json["attachment"],
        paidAt: json["paid_at"],
        isChecked: false,
      );

  Map<String, dynamic> toJson() => {
        "fine_id": fineId,
        "society_id": societyId,
        "user_id": userId,
        "flat_id": flatId,
        "fine_title": fineTitle,
        "fine_reason": fineReason,
        "fine_amount": fineAmount,
        "fine_date":
            "${fineDate!.year.toString().padLeft(4, '0')}-${fineDate!.month.toString().padLeft(2, '0')}-${fineDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "attachment": attachment,
        "paid_at": paidAt,
        "isChecked": false,
      };
}

class Maintenance {
  int? id;
  int? userId;
  int? societyId;
  int? flatId;
  String? type;
  String? roomSize;
  String? ratePerMonth;
  String? totalAmount;
  DateTime? date;
  String? status;
  bool? isChecked;

  Maintenance({
    this.id,
    this.userId,
    this.societyId,
    this.flatId,
    this.type,
    this.roomSize,
    this.ratePerMonth,
    this.totalAmount,
    this.date,
    this.status,
    this.isChecked,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) => Maintenance(
        id: json["id"],
        userId: json["user_id"],
        societyId: json["society_id"],
        flatId: json["flat_id"],
        type: json["type"],
        roomSize: json["room_size"],
        ratePerMonth: json["rate_per_month"],
        totalAmount: json["total_amount"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        status: json["status"],
        isChecked: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "society_id": societyId,
        "flat_id": flatId,
        "type": type,
        "room_size": roomSize,
        "rate_per_month": ratePerMonth,
        "total_amount": totalAmount,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "status": status,
      };
}
