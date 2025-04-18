// To parse this JSON data, do
//
//     final helpSupportModel = helpSupportModelFromJson(jsonString);

import 'dart:convert';

HelpSupportModel helpSupportModelFromJson(String str) =>
    HelpSupportModel.fromJson(json.decode(str));

String helpSupportModelToJson(HelpSupportModel data) =>
    json.encode(data.toJson());

class HelpSupportModel {
  int status;
  String message;
  Data data;

  HelpSupportModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HelpSupportModel.fromJson(Map<String, dynamic> json) =>
      HelpSupportModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String societyId;
  String userId;
  String title;
  String message;
  int supportId;

  Data({
    required this.societyId,
    required this.userId,
    required this.title,
    required this.message,
    required this.supportId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        societyId: json["society_id"],
        userId: json["user_id"],
        title: json["title"],
        message: json["message"],
        supportId: json["support_id"],
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "user_id": userId,
        "title": title,
        "message": message,
        "support_id": supportId,
      };
}
