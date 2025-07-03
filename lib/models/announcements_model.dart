class Announcementmodel {
  int? status;
  String? accId;
  List<Announcements>? announcements;

  Announcementmodel({this.status, this.announcements, this.accId});

  Announcementmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accId = json['razorpay_account_id'];
    if (json['announcements'] != null) {
      announcements = <Announcements>[];
      json['announcements'].forEach((v) {
        announcements!.add(Announcements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['razorpay_account_id'] = accId;
    if (announcements != null) {
      data['announcements'] = announcements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Announcements {
  int? announcementId;
  int? societyId;
  int? userId;
  String? title;
  String? description;
  String? announcementType;
  String? createdAt;

  Announcements(
      {this.announcementId,
      this.societyId,
      this.userId,
      this.title,
      this.description,
      this.announcementType,
      this.createdAt});

  Announcements.fromJson(Map<String, dynamic> json) {
    announcementId = json['announcement_id'];
    societyId = json['society_id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    announcementType = json['announcement_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['announcement_id'] = announcementId;
    data['society_id'] = societyId;
    data['user_id'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['announcement_type'] = announcementType;
    data['created_at'] = createdAt;
    return data;
  }
}
