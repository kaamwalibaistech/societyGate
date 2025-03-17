// To parse this JSON data, do
//
//     final getFamilyMemberModel = getFamilyMemberModelFromJson(jsonString);

import 'dart:convert';

GetFamilyMemberModel getFamilyMemberModelFromJson(String str) =>
    GetFamilyMemberModel.fromJson(json.decode(str));

String getFamilyMemberModelToJson(GetFamilyMemberModel data) =>
    json.encode(data.toJson());

class GetFamilyMemberModel {
  int status;
  String message;
  List<FamilyMember> familyMembers;

  GetFamilyMemberModel({
    required this.status,
    required this.message,
    required this.familyMembers,
  });

  factory GetFamilyMemberModel.fromJson(Map<String, dynamic> json) =>
      GetFamilyMemberModel(
        status: json["status"],
        message: json["message"],
        familyMembers: List<FamilyMember>.from(
            json["family_members"].map((x) => FamilyMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "family_members":
            List<dynamic>.from(familyMembers.map((x) => x.toJson())),
      };
}

class FamilyMember {
  int familyMemberId;
  int societyId;
  int flatId;
  int memberId;
  int submemberId;
  String uname;
  String uemail;
  String uphone;
  String relation;
  DateTime createdAt;
  DateTime updatedAt;

  FamilyMember({
    required this.familyMemberId,
    required this.societyId,
    required this.flatId,
    required this.memberId,
    required this.submemberId,
    required this.uname,
    required this.uemail,
    required this.uphone,
    required this.relation,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
        familyMemberId: json["family_member_id"],
        societyId: json["society_id"],
        flatId: json["flat_id"],
        memberId: json["member_id"],
        submemberId: json["submember_id"],
        uname: json["uname"],
        uemail: json["uemail"],
        uphone: json["uphone"],
        relation: json["relation"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "family_member_id": familyMemberId,
        "society_id": societyId,
        "flat_id": flatId,
        "member_id": memberId,
        "submember_id": submemberId,
        "uname": uname,
        "uemail": uemail,
        "uphone": uphone,
        "relation": relation,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
