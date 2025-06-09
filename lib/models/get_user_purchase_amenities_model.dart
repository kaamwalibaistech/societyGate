// To parse this JSON data, do
//
//     final getUserPurchaseAmenitiesModel = getUserPurchaseAmenitiesModelFromJson(jsonString);

import 'dart:convert';

GetUserPurchaseAmenitiesModel getUserPurchaseAmenitiesModelFromJson(
        String str) =>
    GetUserPurchaseAmenitiesModel.fromJson(json.decode(str));

String getUserPurchaseAmenitiesModelToJson(
        GetUserPurchaseAmenitiesModel data) =>
    json.encode(data.toJson());

class GetUserPurchaseAmenitiesModel {
  int? status;
  List<Datum>? data;

  GetUserPurchaseAmenitiesModel({
    this.status,
    this.data,
  });

  factory GetUserPurchaseAmenitiesModel.fromJson(Map<String, dynamic> json) =>
      GetUserPurchaseAmenitiesModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? amenityId;
  int? societyId;
  int? userId;
  String? amenityName;
  dynamic fromDate;
  dynamic toDate;
  String? amount;
  String? duration;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.amenityId,
    this.societyId,
    this.userId,
    this.amenityName,
    this.fromDate,
    this.toDate,
    this.amount,
    this.duration,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        amenityId: json["amenity_id"],
        societyId: json["society_id"],
        userId: json["user_id"],
        amenityName: json["amenity_name"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        amount: json["amount"],
        duration: json["duration"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "amenity_id": amenityId,
        "society_id": societyId,
        "user_id": userId,
        "amenity_name": amenityName,
        "from_date": fromDate,
        "to_date": toDate,
        "amount": amount,
        "duration": duration,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
