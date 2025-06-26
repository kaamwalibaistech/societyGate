// To parse this JSON data, do
//
//     final employerforgetpasswordModel = employerforgetpasswordModelFromJson(jsonString);

import 'dart:convert';

EmployerforgetpasswordModel employerforgetpasswordModelFromJson(String str) =>
    EmployerforgetpasswordModel.fromJson(json.decode(str));

String employerforgetpasswordModelToJson(EmployerforgetpasswordModel data) =>
    json.encode(data.toJson());

class EmployerforgetpasswordModel {
  String status;
  String otp;
  String msg;

  EmployerforgetpasswordModel({
    required this.status,
    required this.otp,
    required this.msg,
  });

  factory EmployerforgetpasswordModel.fromJson(Map<String, dynamic> json) =>
      EmployerforgetpasswordModel(
        status: json["status"],
        otp: json["otp"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "otp": otp,
        "msg": msg,
      };
}
