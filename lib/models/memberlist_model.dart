class MemberlistModel {
  int? status;
  String? message;
  Users? users;

  MemberlistModel({this.status, this.message, this.users});

  MemberlistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}

class Users {
  List<Admins>? admins;
  List<Members>? members;
  List<Watchmen>? watchmen;

  Users({this.admins, this.members, this.watchmen});

  Users.fromJson(Map<String, dynamic> json) {
    if (json['admins'] != null) {
      admins = <Admins>[];
      json['admins'].forEach((v) {
        admins!.add(Admins.fromJson(v));
      });
    }
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    if (json['watchmen'] != null) {
      watchmen = <Watchmen>[];
      json['watchmen'].forEach((v) {
        watchmen!.add(Watchmen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (admins != null) {
      data['admins'] = admins!.map((v) => v.toJson()).toList();
    }
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    if (watchmen != null) {
      data['watchmen'] = watchmen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  final int userId;
  final int societyId;
  final String urole;
  final String uname;
  final String uemail;
  final String uphone;
  final String approvalStatus;
  final String createdAt;

  Members({
    required this.userId,
    required this.societyId,
    required this.urole,
    required this.uname,
    required this.uemail,
    required this.uphone,
    required this.approvalStatus,
    required this.createdAt,
  });

  factory Members.fromJson(Map<String, dynamic> json) => Members(
        userId: json['user_id'],
        societyId: json['society_id'],
        urole: json['urole'],
        uname: json['uname'],
        uemail: json['uemail'],
        uphone: json['uphone'],
        approvalStatus: json['approval_status'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['society_id'] = societyId;
    data['urole'] = urole;
    data['uname'] = uname;
    data['uemail'] = uemail;
    data['uphone'] = uphone;
    data['approval_status'] = approvalStatus;
    data['created_at'] = createdAt;
    return data;
  }
}

class Admins {
  int? userId;
  int? societyId;
  String? urole;
  String? uname;
  String? uemail;
  String? uphone;
  String? approvalStatus;
  String? createdAt;

  Admins(
      {this.userId,
      this.societyId,
      this.urole,
      this.uname,
      this.uemail,
      this.uphone,
      this.approvalStatus,
      this.createdAt});

  Admins.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    societyId = json['society_id'];
    urole = json['urole'];
    uname = json['uname'];
    uemail = json['uemail'];
    uphone = json['uphone'];
    approvalStatus = json['approval_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['society_id'] = societyId;
    data['urole'] = urole;
    data['uname'] = uname;
    data['uemail'] = uemail;
    data['uphone'] = uphone;
    data['approval_status'] = approvalStatus;
    data['created_at'] = createdAt;
    return data;
  }
}

class Watchmen {
  int? userId;
  int? societyId;
  String? urole;
  String? uname;
  String? uemail;
  String? uphone;
  String? approvalStatus;
  String? createdAt;

  Watchmen(
      {this.userId,
      this.societyId,
      this.urole,
      this.uname,
      this.uemail,
      this.uphone,
      this.approvalStatus,
      this.createdAt});

  Watchmen.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    societyId = json['society_id'];
    urole = json['urole'];
    uname = json['uname'];
    uemail = json['uemail'];
    uphone = json['uphone'];
    approvalStatus = json['approval_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['society_id'] = societyId;
    data['urole'] = urole;
    data['uname'] = uname;
    data['uemail'] = uemail;
    data['uphone'] = uphone;
    data['approval_status'] = approvalStatus;
    data['created_at'] = createdAt;
    return data;
  }
}
