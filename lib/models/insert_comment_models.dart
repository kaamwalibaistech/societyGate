// import 'dart:convert';

// InsertComment insertCommentFromJson(String str) =>
//     InsertComment.fromJson(json.decode(str));

// String insertCommentToJson(InsertComment data) => json.encode(data.toJson());

// class InsertComment {
//   int status;
//   String message;
//   Data data;

//   InsertComment({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory InsertComment.fromJson(Map<String, dynamic> json) => InsertComment(
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//       };
// }

// class Data {
//   String communityPostId;
//   String societyId;
//   String memberId;
//   String comment;
//   int id;

//   Data({
//     required this.communityPostId,
//     required this.societyId,
//     required this.memberId,
//     required this.comment,
//     required this.id,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         communityPostId: json["community_post_id"],
//         societyId: json["society_id"],
//         memberId: json["member_id"],
//         comment: json["comment"],
//         id: json["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "community_post_id": communityPostId,
//         "society_id": societyId,
//         "member_id": memberId,
//         "comment": comment,
//         "id": id,
//       };
// }
