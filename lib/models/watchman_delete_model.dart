// To parse this JSON data, do
//
//     final watchManDeleteModel = watchManDeleteModelFromJson(jsonString);

import 'dart:convert';

WatchManDeleteModel watchManDeleteModelFromJson(String str) =>
    WatchManDeleteModel.fromJson(json.decode(str));

String watchManDeleteModelToJson(WatchManDeleteModel data) =>
    json.encode(data.toJson());

class WatchManDeleteModel {
  int status;
  String message;

  WatchManDeleteModel({
    required this.status,
    required this.message,
  });

  factory WatchManDeleteModel.fromJson(Map<String, dynamic> json) =>
      WatchManDeleteModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
