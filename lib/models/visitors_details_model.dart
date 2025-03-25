class VisitorsDetailModel {
  int? status;
  String? message;
  Data? data;

  VisitorsDetailModel({this.status, this.message, this.data});

  VisitorsDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? visitorId;
  int? flatId;
  String? name;
  String? phone;
  String? relation;
  String? gender;
  String? visitingPurpose;
  String? visitingDate;
  String? entryTime;
  String? exitTime;
  int? visitingRequestBy;
  int? societyId;
  int? approvedBy;
  String? uniqueCode;

  Data(
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
      this.approvedBy,
      this.uniqueCode});

  Data.fromJson(Map<String, dynamic> json) {
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
    uniqueCode = json['unique_code'];
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
    data['unique_code'] = this.uniqueCode;
    return data;
  }
}
