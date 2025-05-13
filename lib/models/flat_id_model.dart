// To parse this JSON data, do
//
//     final flatIdModel = flatIdModelFromJson(jsonString);

import 'dart:convert';

FlatIdModel flatIdModelFromJson(String str) =>
    FlatIdModel.fromJson(json.decode(str));

String flatIdModelToJson(FlatIdModel data) => json.encode(data.toJson());

class FlatIdModel {
  int status;
  String message;
  List<Datum> data;

  FlatIdModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FlatIdModel.fromJson(Map<String, dynamic> json) => FlatIdModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int flatId;
  String ownerName;
  String phone;

  Datum({
    required this.flatId,
    required this.ownerName,
    required this.phone,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        flatId: json["flat_id"],
        ownerName: json["owner_name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "flat_id": flatId,
        "owner_name": ownerName,
        "phone": phone,
      };
}
