// To parse this JSON data, do
//
//     final adminRegister = adminRegisterFromJson(jsonString);

import 'dart:convert';

AdminRegister adminRegisterFromJson(String str) =>
    AdminRegister.fromJson(json.decode(str));

String adminRegisterToJson(AdminRegister data) => json.encode(data.toJson());

class AdminRegister {
  int status;
  String message;

  AdminRegister({
    required this.status,
    required this.message,
  });

  factory AdminRegister.fromJson(Map<String, dynamic> json) => AdminRegister(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
