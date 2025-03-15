class VisitorsListModel {
  int? status;
  String? message;
  List<Visitors>? visitors;
  List<Regularvisitors>? regularvisitors;

  VisitorsListModel(
      {this.status, this.message, this.visitors, this.regularvisitors});

  VisitorsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['visitors'] != null) {
      visitors = <Visitors>[];
      json['visitors'].forEach((v) {
        visitors!.add(new Visitors.fromJson(v));
      });
    }
    if (json['regularvisitors'] != null) {
      regularvisitors = <Regularvisitors>[];
      json['regularvisitors'].forEach((v) {
        regularvisitors!.add(new Regularvisitors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.visitors != null) {
      data['visitors'] = this.visitors!.map((v) => v.toJson()).toList();
    }
    if (this.regularvisitors != null) {
      data['regularvisitors'] =
          this.regularvisitors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Visitors {
  int? visitorId;
  int? flatId;
  String? name;
  String? phone;
  String? relation;
  String? gender;
  String? visitingPurpose;
  String? visitingDate;
  String? entryTime;
  Null? exitTime;
  int? visitingRequestBy;
  int? societyId;
  int? approvedBy;

  Visitors(
      {this.visitorId,
      this.flatId,
      this.name,
      this.phone,
      this.relation,
      this.gender,
      this.visitingPurpose,
      this.visitingDate,
      this.entryTime,
      this.exitTime,
      this.visitingRequestBy,
      this.societyId,
      this.approvedBy});

  Visitors.fromJson(Map<String, dynamic> json) {
    visitorId = json['visitor_id'];
    flatId = json['flat_id'];
    name = json['name'];
    phone = json['phone'];
    relation = json['relation'];
    gender = json['gender'];
    visitingPurpose = json['visiting_purpose'];
    visitingDate = json['visiting_date'];
    entryTime = json['entry_time'];
    exitTime = json['exit_time'];
    visitingRequestBy = json['visiting_request_by'];
    societyId = json['society_id'];
    approvedBy = json['approved_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visitor_id'] = this.visitorId;
    data['flat_id'] = this.flatId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['relation'] = this.relation;
    data['gender'] = this.gender;
    data['visiting_purpose'] = this.visitingPurpose;
    data['visiting_date'] = this.visitingDate;
    data['entry_time'] = this.entryTime;
    data['exit_time'] = this.exitTime;
    data['visiting_request_by'] = this.visitingRequestBy;
    data['society_id'] = this.societyId;
    data['approved_by'] = this.approvedBy;
    return data;
  }
}

class Regularvisitors {
  int? employeeId;
  int? societyId;
  int? memberId;
  int? flatId;
  String? name;
  String? phone;
  String? address;
  String? empType;
  String? createdAt;

  Regularvisitors(
      {this.employeeId,
      this.societyId,
      this.memberId,
      this.flatId,
      this.name,
      this.phone,
      this.address,
      this.empType,
      this.createdAt});

  Regularvisitors.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    societyId = json['society_id'];
    memberId = json['member_id'];
    flatId = json['flat_id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    empType = json['emp_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['society_id'] = this.societyId;
    data['member_id'] = this.memberId;
    data['flat_id'] = this.flatId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['emp_type'] = this.empType;
    data['created_at'] = this.createdAt;
    return data;
  }
}
