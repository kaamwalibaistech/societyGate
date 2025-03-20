class VisitorsListModel {
  int? status;
  String? message;
  Data? data;

  VisitorsListModel({this.status, this.message, this.data});

  factory VisitorsListModel.fromJson(Map<String, dynamic> json) {
    return VisitorsListModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  VisitorSection? upcomingVisitors;
  VisitorSection? pastVisitors;
  VisitorSection? regularVisitors;

  Data({this.upcomingVisitors, this.pastVisitors, this.regularVisitors});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      upcomingVisitors: json['upcoming_visitors'] != null
          ? VisitorSection.fromJson(json['upcoming_visitors'], 'udata')
          : null,
      pastVisitors: json['past_visitors'] != null
          ? VisitorSection.fromJson(json['past_visitors'], 'pdata')
          : null,
      regularVisitors: json['regular_visitors'] != null
          ? VisitorSection.fromJson(json['regular_visitors'], 'rdata')
          : null,
    );
  }
}

class VisitorSection {
  int? total;
  String? currentPage;
  String? perPage;
  List<Visitor>? list;

  VisitorSection({this.total, this.currentPage, this.perPage, this.list});

  factory VisitorSection.fromJson(Map<String, dynamic> json, String listKey) {
    return VisitorSection(
      total: json['total'],
      currentPage: json['current_page'],
      perPage: json['per_page'],
      list: json[listKey] != null
          ? List<Visitor>.from(json[listKey].map((x) => Visitor.fromJson(x)))
          : [],
    );
  }
}

class Visitor {
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
  String? visitingStatus;

  Visitor({
    this.visitorId,
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
    this.uniqueCode,
    this.visitingStatus,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      visitorId: json['visitor_id'],
      flatId: json['flat_id'],
      name: json['name'],
      phone: json['phone'],
      relation: json['relation'],
      gender: json['gender'],
      visitingPurpose: json['visiting_purpose'],
      visitingDate: json['visiting_date'],
      entryTime: json['entry_time'],
      exitTime: json['exit_time'],
      visitingRequestBy: json['visiting_request_by'],
      societyId: json['society_id'],
      approvedBy: json['approved_by'],
      uniqueCode: json['unique_code'],
      visitingStatus: json['visiting_status'],
    );
  }
}
