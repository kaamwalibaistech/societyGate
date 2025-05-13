// To parse this JSON data, do
//
//     final communityPost = communityPostFromJson(jsonString);

import 'dart:convert';

CommunityPost communityPostFromJson(String str) =>
    CommunityPost.fromJson(json.decode(str));

String communityPostToJson(CommunityPost data) => json.encode(data.toJson());

class CommunityPost {
  int status;
  String message;
  Data data;

  CommunityPost({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) => CommunityPost(
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
  String adminId;
  String title;
  String description;
  String photo;
  int like;
  int dislike;
  int id;

  Data({
    required this.societyId,
    required this.adminId,
    required this.title,
    required this.description,
    required this.photo,
    required this.like,
    required this.dislike,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        societyId: json["society_id"],
        adminId: json["admin_id"],
        title: json["title"],
        description: json["description"],
        photo: json["photo"],
        like: json["like"],
        dislike: json["dislike"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "admin_id": adminId,
        "title": title,
        "description": description,
        "photo": photo,
        "like": like,
        "dislike": dislike,
        "id": id,
      };
}
