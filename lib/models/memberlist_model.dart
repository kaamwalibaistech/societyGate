class MemberlistModel {
  int? status;
  String? message;
  List<Users>? users;

  MemberlistModel({this.status, this.message, this.users});

  MemberlistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? userId;
  int? societyId;
  String? urole;
  String? uname;
  String? uemail;
  String? upassword;
  String? uphone;
  String? approvalStatus;
  String? createdAt;

  Users(
      {this.userId,
      this.societyId,
      this.urole,
      this.uname,
      this.uemail,
      this.upassword,
      this.uphone,
      this.approvalStatus,
      this.createdAt});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    societyId = json['society_id'];
    urole = json['urole'];
    uname = json['uname'];
    uemail = json['uemail'];
    upassword = json['upassword'];
    uphone = json['uphone'];
    approvalStatus = json['approval_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['society_id'] = this.societyId;
    data['urole'] = this.urole;
    data['uname'] = this.uname;
    data['uemail'] = this.uemail;
    data['upassword'] = this.upassword;
    data['uphone'] = this.uphone;
    data['approval_status'] = this.approvalStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}
