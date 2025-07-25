// To parse this JSON data, do
//
//     final paidMaintainenceModel = paidMaintainenceModelFromJson(jsonString);

import 'dart:convert';

PaidMaintainenceModel paidMaintainenceModelFromJson(String str) =>
    PaidMaintainenceModel.fromJson(json.decode(str));

String paidMaintainenceModelToJson(PaidMaintainenceModel data) =>
    json.encode(data.toJson());

class PaidMaintainenceModel {
  int? status;
  List<Maintenance>? maintenance;
  List<Fine>? fines;

  PaidMaintainenceModel({
    this.status,
    this.maintenance,
    this.fines,
  });

  factory PaidMaintainenceModel.fromJson(Map<String, dynamic> json) =>
      PaidMaintainenceModel(
        status: json["status"],
        maintenance: json["maintenance"] == null
            ? []
            : List<Maintenance>.from(
                json["maintenance"]!.map((x) => Maintenance.fromJson(x))),
        fines: json["fines"] == null
            ? []
            : List<Fine>.from(json["fines"]!.map((x) => Fine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
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
  String? attachment;
  dynamic paidAt;

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
      };
}

class Maintenance {
  int? maintenanceId;
  int? userId;
  int? societyId;
  int? flatId;
  String? type;
  String? roomSqFt;
  String? ratePerSqFt;
  String? totalAmount;
  DateTime? date;
  String? status;
  dynamic paidAt;

  Maintenance({
    this.maintenanceId,
    this.userId,
    this.societyId,
    this.flatId,
    this.type,
    this.roomSqFt,
    this.ratePerSqFt,
    this.totalAmount,
    this.date,
    this.status,
    this.paidAt,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) => Maintenance(
        maintenanceId: json["maintenance_id"],
        userId: json["user_id"],
        societyId: json["society_id"],
        flatId: json["flat_id"],
        type: json["type"],
        roomSqFt: json["room_sq_ft"],
        ratePerSqFt: json["rate_per_sq_ft"],
        totalAmount: json["total_amount"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        status: json["status"],
        paidAt: json["paid_at"],
      );

  Map<String, dynamic> toJson() => {
        "maintenance_id": maintenanceId,
        "user_id": userId,
        "society_id": societyId,
        "flat_id": flatId,
        "type": type,
        "room_sq_ft": roomSqFt,
        "rate_per_sq_ft": ratePerSqFt,
        "total_amount": totalAmount,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "status": status,
        "paid_at": paidAt,
      };
}
