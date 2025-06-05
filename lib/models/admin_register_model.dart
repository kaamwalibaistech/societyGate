import 'dart:convert';

AdminRegister adminRegisterFromJson(String str) =>
    AdminRegister.fromJson(json.decode(str));

String adminRegisterToJson(AdminRegister data) => json.encode(data.toJson());

class AdminRegister {
  int status;
  dynamic message; // Can be String or Map<String, List<String>>
  Data? data;

  AdminRegister({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AdminRegister.fromJson(Map<String, dynamic> json) => AdminRegister(
        status: json["status"] ?? 0,
        message: json["message"],
        data: json["data"] != null && json["data"].isNotEmpty
            ? Data.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson() ?? {},
      };
}

class Data {
  Society? society;
  User? user;
  Flat? flat;

  Data({
    this.society,
    this.user,
    this.flat,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        society:
            json["society"] != null ? Society.fromJson(json["society"]) : null,
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        flat: json["flat"] != null ? Flat.fromJson(json["flat"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "society": society?.toJson() ?? {},
        "user": user?.toJson() ?? {},
        "flat": flat?.toJson() ?? {},
      };
}

class Society {
  String? name;
  String? address;
  String? registrationNo;
  String? totalWings;
  String? totalFlats;
  String? approvalStatus;
  int? societyId;

  Society({
    this.name,
    this.address,
    this.registrationNo,
    this.totalWings,
    this.totalFlats,
    this.approvalStatus,
    this.societyId,
  });

  factory Society.fromJson(Map<String, dynamic> json) => Society(
        name: json["name"] ?? "",
        address: json["address"] ?? "",
        registrationNo: json["registration_no"] ?? "",
        totalWings: json["total_wings"] ?? "",
        totalFlats: json["total_flats"] ?? "",
        approvalStatus: json["approval_status"] ?? "",
        societyId: json["society_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "registration_no": registrationNo,
        "total_wings": totalWings,
        "total_flats": totalFlats,
        "approval_status": approvalStatus,
        "society_id": societyId,
      };
}

class User {
  int? societyId;
  String? urole;
  String? uname;
  String? uemail;
  String? upassword;
  String? uphone;
  String? approvalStatus;
  int? userId;

  User({
    this.societyId,
    this.urole,
    this.uname,
    this.uemail,
    this.upassword,
    this.uphone,
    this.approvalStatus,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        societyId: json["society_id"] ?? 0,
        urole: json["urole"] ?? "",
        uname: json["uname"] ?? "",
        uemail: json["uemail"] ?? "",
        upassword: json["upassword"] ?? "",
        uphone: json["uphone"] ?? "",
        approvalStatus: json["approval_status"] ?? "",
        userId: json["user_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "urole": urole,
        "uname": uname,
        "uemail": uemail,
        "upassword": upassword,
        "uphone": uphone,
        "approval_status": approvalStatus,
        "user_id": userId,
      };
}

class Flat {
  int? societyId;
  int? memberId;
  String? ownerName;
  String? phone;
  String? flatNumber;
  String? block;
  String? floor;
  String? occupancy;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? flatId;

  Flat({
    this.societyId,
    this.memberId,
    this.ownerName,
    this.phone,
    this.flatNumber,
    this.block,
    this.floor,
    this.occupancy,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.flatId,
  });

  factory Flat.fromJson(Map<String, dynamic> json) => Flat(
        societyId: json["society_id"] ?? 0,
        memberId: json["member_id"] ?? 0,
        ownerName: json["owner_name"] ?? "",
        phone: json["phone"] ?? "",
        flatNumber: json["flat_number"] ?? "",
        block: json["block"],
        floor: json["floor"] ?? "",
        occupancy: json["occupancy"] ?? "",
        status: json["status"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        createdAt: json["created_at"] ?? "",
        flatId: json["flat_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "member_id": memberId,
        "owner_name": ownerName,
        "phone": phone,
        "flat_number": flatNumber,
        "block": block,
        "floor": floor,
        "occupancy": occupancy,
        "status": status,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "flat_id": flatId,
      };
}
