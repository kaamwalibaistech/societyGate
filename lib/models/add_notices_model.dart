// To parse this JSON data, do
//
//     final addNoticeModel = addNoticeModelFromJson(jsonString);

import 'dart:convert';

AddNoticeModel addNoticeModelFromJson(String str) =>
    AddNoticeModel.fromJson(json.decode(str));

String addNoticeModelToJson(AddNoticeModel data) => json.encode(data.toJson());

class AddNoticeModel {
  int status;
  String message;
  Data? data;

  AddNoticeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddNoticeModel.fromJson(Map<String, dynamic> json) => AddNoticeModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson() ?? "",
      };
}

class Data {
  String? societyId;
  String? userId;
  String? title;
  String? description;
  String? announcementType;
  int? announcementId;

  Data({
    required this.societyId,
    required this.userId,
    required this.title,
    required this.description,
    required this.announcementType,
    required this.announcementId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        societyId: json["society_id"] ?? "",
        userId: json["user_id"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        announcementType: json["announcement_type"] ?? "",
        announcementId: json["announcement_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId ?? "",
        "user_id": userId ?? "",
        "title": title ?? "",
        "description": description ?? "",
        "announcement_type": announcementType ?? "",
        "announcement_id": announcementId ?? "",
      };
}
