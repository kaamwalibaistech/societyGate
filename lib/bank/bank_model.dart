class RazorpayAccountModel {
  String? id;
  String? type;
  String? status;
  String? email;
  String? phone;
  String? contactName;
  String? referenceId;
  String? businessType;
  String? legalBusinessName;
  String? customerFacingBusinessName;
  bool? live;
  bool? holdFunds;
  int? createdAt;
  int? activatedAt;
  LegalInfo? legalInfo;
  Profile? profile;

  RazorpayAccountModel({
    this.id,
    this.type,
    this.status,
    this.email,
    this.phone,
    this.contactName,
    this.referenceId,
    this.businessType,
    this.legalBusinessName,
    this.customerFacingBusinessName,
    this.live,
    this.holdFunds,
    this.createdAt,
    this.activatedAt,
    this.legalInfo,
    this.profile,
  });

  factory RazorpayAccountModel.fromJson(Map<String, dynamic> json) {
    return RazorpayAccountModel(
      id: json['id'],
      type: json['type'],
      status: json['status'],
      email: json['email'],
      phone: json['phone'],
      contactName: json['contact_name'],
      referenceId: json['reference_id'],
      businessType: json['business_type'],
      legalBusinessName: json['legal_business_name'],
      customerFacingBusinessName: json['customer_facing_business_name'],
      live: json['live'],
      holdFunds: json['hold_funds'],
      createdAt: json['created_at'],
      activatedAt: json['activated_at'],
      legalInfo: json['legal_info'] != null
          ? LegalInfo.fromJson(json['legal_info'])
          : null,
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
    );
  }
}

class LegalInfo {
  String? pan;
  String? gst;

  LegalInfo({this.pan, this.gst});

  factory LegalInfo.fromJson(Map<String, dynamic> json) {
    return LegalInfo(
      pan: json['pan'],
      gst: json['gst'],
    );
  }
}

class Profile {
  String? category;
  String? subcategory;
  Map<String, dynamic>? addresses;

  Profile({this.category, this.subcategory, this.addresses});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      category: json['category'],
      subcategory: json['subcategory'],
      addresses:
          json['addresses'] is Map<String, dynamic> ? json['addresses'] : null,
    );
  }
}
