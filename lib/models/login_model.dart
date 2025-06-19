// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? status;
  String? message;
  User? user;

  LoginModel({
    this.status,
    this.message,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson(),
      };
}

class User {
// <<<<<<< ritesh
  int? userId;
  int? societyId;
  String? societyName;
  dynamic flatId;
  dynamic flatNumber;
  dynamic block;
  String? role;
  String? uname;
  String? uemail;
  String? uphone;
  String? profileImage;
  DateTime? createdAt;

  User({
    this.userId,
    this.societyId,
    this.societyName,
    this.flatId,
    this.flatNumber,
    this.block,
    this.role,
    this.uname,
    this.uemail,
    this.uphone,
    this.profileImage,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        societyId: json["society_id"],
        societyName: json["society_name"],
        flatId: json["flat_id"],
        flatNumber: json["flat_number"],
        block: json["block"],
        role: json["role"],
        uname: json["uname"],
        uemail: json["uemail"],
        uphone: json["uphone"],
        profileImage: json["profile_image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "society_id": societyId,
        "society_name": societyName,
        "flat_id": flatId,
        "flat_number": flatNumber,
        "block": block,
        "role": role,
        "uname": uname,
        "uemail": uemail,
        "uphone": uphone,
        "profile_image": profileImage,
        "created_at": createdAt?.toIso8601String(),
      };
// =======
//   final int userId;
//   final int societyId;
//   final String societyName;
//   final int flatId;
//   final String flatNumber;
//   final String block;
//   final String role;
//   final String uname;
//   final String uemail;
//   final String uphone;
//   final String profile_iamge;
//   final String createdAt;

//   User({
//     required this.userId,
//     required this.societyId,
//     required this.societyName,
//     required this.flatId,
//     required this.flatNumber,
//     required this.block,
//     required this.role,
//     required this.uname,
//     required this.uemail,
//     required this.uphone,
//     required this.profile_iamge,
//     required this.createdAt,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       userId: json['user_id'] ?? 0,
//       societyId: json['society_id'] ?? 0,
//       societyName: json['society_name'] ?? "Unknown",
//       flatId: json['flat_id'] ?? 0,
//       flatNumber: json['flat_number'] ?? "Unknown",
//       block: json['block'] ?? "Unknown",
//       role: json['role'] ?? "Unknown",
//       uname: json['uname'] ?? "No Name",
//       uemail: json['uemail'] ?? "No Email",
//       uphone: json['uphone'] ?? "No Phone",
//       profile_iamge: json['profile_image'] ?? "No Phone",
//       createdAt: json['created_at'] ?? "N/A",
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'user_id': userId,
//       'society_id': societyId,
//       'society_name': societyName,
//       'flat_id': flatId,
//       'flat_number': flatNumber,
//       'block': block,
//       'role': role,
//       'uname': uname,
//       'uemail': uemail,
//       'uphone': uphone,
//       'profile_image': profile_iamge,
//       'created_at': createdAt,
//     };
//   }
// >>>>>>> final
}
