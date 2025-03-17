// To parse this JSON data, do
//
//     final addFamilyMemberModel = addFamilyMemberModelFromJson(jsonString);

import 'dart:convert';

AddFamilyMemberModel addFamilyMemberModelFromJson(String str) =>
    AddFamilyMemberModel.fromJson(json.decode(str));

String addFamilyMemberModelToJson(AddFamilyMemberModel data) =>
    json.encode(data.toJson());

class AddFamilyMemberModel {
  int status;
  String message;
  FamilyMember familyMember;

  AddFamilyMemberModel({
    required this.status,
    required this.message,
    required this.familyMember,
  });

  factory AddFamilyMemberModel.fromJson(Map<String, dynamic> json) =>
      AddFamilyMemberModel(
        status: json["status"],
        message: json["message"],
        familyMember: FamilyMember.fromJson(json["family_member"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "family_member": familyMember.toJson(),
      };
}

class FamilyMember {
  String societyId;
  String flatId;
  String memberId;
  int submemberId;
  String uname;
  String uemail;
  String uphone;
  String relation;
  DateTime updatedAt;
  DateTime createdAt;
  int familyMemberId;

  FamilyMember({
    required this.societyId,
    required this.flatId,
    required this.memberId,
    required this.submemberId,
    required this.uname,
    required this.uemail,
    required this.uphone,
    required this.relation,
    required this.updatedAt,
    required this.createdAt,
    required this.familyMemberId,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
        societyId: json["society_id"],
        flatId: json["flat_id"],
        memberId: json["member_id"],
        submemberId: json["submember_id"],
        uname: json["uname"],
        uemail: json["uemail"],
        uphone: json["uphone"],
        relation: json["relation"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        familyMemberId: json["family_member_id"],
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "flat_id": flatId,
        "member_id": memberId,
        "submember_id": submemberId,
        "uname": uname,
        "uemail": uemail,
        "uphone": uphone,
        "relation": relation,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "family_member_id": familyMemberId,
      };
}
