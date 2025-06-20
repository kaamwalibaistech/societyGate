// To parse this JSON data, do
//
//     final getFamilyMemberModel = getFamilyMemberModelFromJson(jsonString);

import 'dart:convert';

GetFamilyMemberModel getFamilyMemberModelFromJson(String str) =>
    GetFamilyMemberModel.fromJson(json.decode(str));

String getFamilyMemberModelToJson(GetFamilyMemberModel data) =>
    json.encode(data.toJson());

class GetFamilyMemberModel {
  int? status;
  String? message;
  List<FamilyMember>? familyMembers;

  GetFamilyMemberModel({
    this.status,
    this.message,
    this.familyMembers,
  });

  factory GetFamilyMemberModel.fromJson(Map<String, dynamic> json) =>
      GetFamilyMemberModel(
        status: json["status"],
        message: json["message"],
        familyMembers: json["family_members"] == null
            ? []
            : List<FamilyMember>.from(
                json["family_members"]!.map((x) => FamilyMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "family_members": familyMembers == null
            ? []
            : List<dynamic>.from(familyMembers!.map((x) => x.toJson())),
      };
}

class FamilyMember {
  int? familyMemberId;
  int? societyId;
  int? flatId;
  int? memberId;
  int? submemberId;
  String? uname;
  String? photo;
  String? uemail;
  String? uphone;
  String? relation;
  DateTime? createdAt;
  DateTime? updatedAt;

  FamilyMember({
    this.familyMemberId,
    this.societyId,
    this.flatId,
    this.memberId,
    this.submemberId,
    this.uname,
    this.photo,
    this.uemail,
    this.uphone,
    this.relation,
    this.createdAt,
    this.updatedAt,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
        familyMemberId: json["family_member_id"],
        societyId: json["society_id"],
        flatId: json["flat_id"],
        memberId: json["member_id"],
        submemberId: json["submember_id"],
        uname: json["uname"],
        photo: json["profile_photo"],
        uemail: json["uemail"],
        uphone: json["uphone"],
        relation: json["relation"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "family_member_id": familyMemberId,
        "society_id": societyId,
        "flat_id": flatId,
        "member_id": memberId,
        "submember_id": submemberId,
        "uname": uname,
        "profile_photo": photo,
        "uemail": uemail,
        "uphone": uphone,
        "relation": relation,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
