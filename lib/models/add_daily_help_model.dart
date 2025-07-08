// To parse this JSON data, do
//
//     final addDailyHelpModel = addDailyHelpModelFromJson(jsonString);

import 'dart:convert';

AddDailyHelpModel addDailyHelpModelFromJson(String str) =>
    AddDailyHelpModel.fromJson(json.decode(str));

String addDailyHelpModelToJson(AddDailyHelpModel data) =>
    json.encode(data.toJson());

class AddDailyHelpModel {
  int? status;
  String? message;
  List<Employee>? employee;

  AddDailyHelpModel({
    this.status,
    this.message,
    this.employee,
  });

  factory AddDailyHelpModel.fromJson(Map<String, dynamic> json) =>
      AddDailyHelpModel(
        status: json["status"],
        message: json["message"],
        employee: json["employee"] == null
            ? []
            : List<Employee>.from(
                json["employee"]!.map((x) => Employee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "employee": employee == null
            ? []
            : List<dynamic>.from(employee!.map((x) => x.toJson())),
      };
}

class Employee {
  String? societyId;
  String? memberId;
  String? flatId;
  String? name;
  String? phone;
  String? address;
  String? empType;
  dynamic profileImage;
  int? employeeId;

  Employee({
    this.societyId,
    this.memberId,
    this.flatId,
    this.name,
    this.phone,
    this.address,
    this.empType,
    this.profileImage,
    this.employeeId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        societyId: json["society_id"],
        memberId: json["member_id"],
        flatId: json["flat_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        empType: json["emp_type"],
        profileImage: json["profile_image"],
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
        "profile_image": profileImage,
        "employee_id": employeeId,
      };
}
