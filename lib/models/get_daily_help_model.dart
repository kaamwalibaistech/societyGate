// To parse this JSON data, do
//
//     final getDailyHelpModel = getDailyHelpModelFromJson(jsonString);

import 'dart:convert';

GetDailyHelpModel getDailyHelpModelFromJson(String str) =>
    GetDailyHelpModel.fromJson(json.decode(str));

String getDailyHelpModelToJson(GetDailyHelpModel data) =>
    json.encode(data.toJson());

class GetDailyHelpModel {
  int status;
  String message;
  List<Employee> employees;

  GetDailyHelpModel({
    required this.status,
    required this.message,
    required this.employees,
  });

  factory GetDailyHelpModel.fromJson(Map<String, dynamic> json) =>
      GetDailyHelpModel(
        status: json["status"],
        message: json["message"],
        employees: List<Employee>.from(
            json["employees"].map((x) => Employee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
      };
}

class Employee {
  int? employeeId;
  int? societyId;
  int? memberId;
  int? flatId;
  String? name;
  String? photo;
  String? phone;
  String? address;
  String? empType;
  DateTime createdAt;

  Employee({
    required this.employeeId,
    required this.societyId,
    required this.memberId,
    required this.flatId,
    required this.name,
    required this.photo,
    required this.phone,
    required this.address,
    required this.empType,
    required this.createdAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        employeeId: json["employee_id"],
        societyId: json["society_id"],
        memberId: json["member_id"],
        flatId: json["flat_id"],
        name: json["name"],
        photo: json["profile_photo"],
        phone: json["phone"],
        address: json["address"],
        empType: json["emp_type"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "society_id": societyId,
        "member_id": memberId,
        "flat_id": flatId,
        "name": name,
        "profile_photo": photo,
        "phone": phone,
        "address": address,
        "emp_type": empType,
        "created_at": createdAt.toIso8601String(),
      };
}
