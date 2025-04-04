// To parse this JSON data, do
//
//     final userApprove = userApproveFromJson(jsonString);

import 'dart:convert';

UserApprove userApproveFromJson(String str) =>
    UserApprove.fromJson(json.decode(str));

String userApproveToJson(UserApprove data) => json.encode(data.toJson());

class UserApprove {
  int status;
  String message;

  UserApprove({
    required this.status,
    required this.message,
  });

  factory UserApprove.fromJson(Map<String, dynamic> json) => UserApprove(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
