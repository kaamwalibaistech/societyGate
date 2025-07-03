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
  int? id;
  int? userId;
  int? societyId;
  int? flatId;
  String? type;
  String? roomSize;
  String? ratePerMonth;
  String? totalAmount;
  String? date;
  String? status;
  bool? isChecked;

  Datum(
      {this.id,
      this.userId,
      this.societyId,
      this.flatId,
      this.type,
      this.roomSize,
      this.ratePerMonth,
      this.totalAmount,
      this.date,
      this.status,
      this.isChecked = false});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"],
      userId: json["user_id"],
      societyId: json["society_id"],
      flatId: json["flat_id"],
      type: json["type"],
      roomSize: json["room_size"],
      ratePerMonth: json["rate_per_month"],
      totalAmount: json["total_amount"],
      date: json["date"],
      status: json["status"],
      isChecked: false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "society_id": societyId,
        "flat_id": flatId,
        "type": type,
        "room_size": roomSize,
        "rate_per_month": ratePerMonth,
        "total_amount": totalAmount,
        "date": date,
        // "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "status": status,
      };
}
