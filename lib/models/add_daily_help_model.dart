// To parse this JSON data, do
//
//     final addDailyHelpModel = addDailyHelpModelFromJson(jsonString);

import 'dart:convert';

AddDailyHelpModel addDailyHelpModelFromJson(String str) =>
    AddDailyHelpModel.fromJson(json.decode(str));

String addDailyHelpModelToJson(AddDailyHelpModel data) =>
    json.encode(data.toJson());

class AddDailyHelpModel {
  int status;
  String message;
  Employee employee;

  AddDailyHelpModel({
    required this.status,
    required this.message,
    required this.employee,
  });

  factory AddDailyHelpModel.fromJson(Map<String, dynamic> json) =>
      AddDailyHelpModel(
        status: json["status"],
        message: json["message"],
        employee: Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "employee": employee.toJson(),
      };
}

class Employee {
  String societyId;
  String memberId;
  String flatId;
  String name;
  String phone;
  String address;
  String empType;
  int employeeId;

  Employee({
    required this.societyId,
    required this.memberId,
    required this.flatId,
    required this.name,
    required this.phone,
    required this.address,
    required this.empType,
    required this.employeeId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        societyId: json["society_id"],
        memberId: json["member_id"],
        flatId: json["flat_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        empType: json["emp_type"],
        employeeId: json["employee_id"],
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "member_id": memberId,
        "flat_id": flatId,
        "name": name,
        "phone": phone,
        "address": address,
        "emp_type": empType,
        "employee_id": employeeId,
      };
}
