// To parse this JSON data, do
//
//     final homepagemodel = homepagemodelFromJson(jsonString);

import 'dart:convert';

Homepagemodel homepagemodelFromJson(String str) =>
    Homepagemodel.fromJson(json.decode(str));

String homepagemodelToJson(Homepagemodel data) => json.encode(data.toJson());

class Homepagemodel {
  int status;
  Data data;

  Homepagemodel({
    required this.status,
    required this.data,
  });

  factory Homepagemodel.fromJson(Map<String, dynamic> json) => Homepagemodel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  List<Announcement> announcements;
  List<String> amenities;

  Data({
    required this.announcements,
    required this.amenities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        announcements: List<Announcement>.from(
            json["announcements"].map((x) => Announcement.fromJson(x))),
        amenities: List<String>.from(json["amenities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "announcements":
            List<dynamic>.from(announcements.map((x) => x.toJson())),
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
      };
}

class Announcement {
  int announcementId;
  int societyId;
  int userId;
  String title;
  String description;
  String announcementType;
  DateTime createdAt;

  Announcement({
    required this.announcementId,
    required this.societyId,
    required this.userId,
    required this.title,
    required this.description,
    required this.announcementType,
    required this.createdAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        announcementId: json["announcement_id"],
        societyId: json["society_id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        announcementType: json["announcement_type"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "announcement_id": announcementId,
        "society_id": societyId,
        "user_id": userId,
        "title": title,
        "description": description,
        "announcement_type": announcementType,
        "created_at": createdAt.toIso8601String(),
      };
}
