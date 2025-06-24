class GetDailyHelpModel {
  int? status;
  String? message;
  List<Employees>? employees;

  GetDailyHelpModel({this.status, this.message, this.employees});

  GetDailyHelpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['employees'] != null) {
      employees = <Employees>[];
      json['employees'].forEach((v) {
        employees!.add(new Employees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.employees != null) {
      data['employees'] = this.employees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Employees {
  int? employeeId;
  int? societyId;
  int? flatId;
  int? memberId;
  String? name;
  String? phone;
  String? address;
  String? empType;
  String? profileImage;

  Employees(
      {this.employeeId,
      this.societyId,
      this.flatId,
      this.memberId,
      this.name,
      this.phone,
      this.address,
      this.empType,
      this.profileImage});

  Employees.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    societyId = json['society_id'];
    flatId = json['flat_id'];
    memberId = json['member_id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    empType = json['emp_type'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['society_id'] = this.societyId;
    data['flat_id'] = this.flatId;
    data['member_id'] = this.memberId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['emp_type'] = this.empType;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
