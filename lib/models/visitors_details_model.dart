class VisitorsDetailModel {
  int? status;
  String? message;
  Data? data;

  VisitorsDetailModel({this.status, this.message, this.data});

  VisitorsDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['visitor_id'] = visitorId;
    data['flat_id'] = flatId;
    data['name'] = name;
    data['phone'] = phone;
    data['relation'] = relation;
    data['gender'] = gender;
    data['visiting_purpose'] = visitingPurpose;
    data['visiting_date'] = visitingDate;
    data['entry_time'] = entryTime;
    data['exit_time'] = exitTime;
    data['visiting_request_by'] = visitingRequestBy;
    data['society_id'] = societyId;
    data['approved_by'] = approvedBy;
    data['unique_code'] = uniqueCode;
    return data;
  }
}
