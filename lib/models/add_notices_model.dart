// To parse this JSON data, do
//
//     final addNoticeModel = addNoticeModelFromJson(jsonString);

import 'dart:convert';

AddNoticeModel addNoticeModelFromJson(String str) =>
    AddNoticeModel.fromJson(json.decode(str));

String addNoticeModelToJson(AddNoticeModel data) => json.encode(data.toJson());

class AddNoticeModel {
  String? status;
  String? message;
  Announcement? announcement;

  AddNoticeModel({
    this.status,
    this.message,
    this.announcement,
  });

  factory AddNoticeModel.fromJson(Map<String, dynamic> json) => AddNoticeModel(
        status: json["status"],
        message: json["message"],
        announcement: json["announcement"] == null
            ? null
            : Announcement.fromJson(json["announcement"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "announcement": announcement?.toJson(),
      };
}

class Announcement {
  String? societyId;
  String? userId;
  String? title;
  String? description;
  int? announcementId;

  Announcement({
    this.societyId,
    this.userId,
    this.title,
    this.description,
    this.announcementId,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        societyId: json["society_id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        announcementId: json["announcement_id"],
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "user_id": userId,
        "title": title,
        "description": description,
        "announcement_id": announcementId,
      };
}
