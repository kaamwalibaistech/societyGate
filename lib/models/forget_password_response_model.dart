// To parse this JSON data, do
//
//     final ForgotPasswordResponse = ForgotPasswordResponseFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResponse forgotPasswordResponseFromJson(String str) =>
    ForgotPasswordResponse.fromJson(json.decode(str));

String forgotPasswordResponseToJson(ForgotPasswordResponse data) =>
    json.encode(data.toJson());

class ForgotPasswordResponse {
  int? status;
  String? message;

  ForgotPasswordResponse({
    this.status,
    this.message,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
