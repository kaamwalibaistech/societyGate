import 'dart:convert';

GetVehicleDetailsModel? getVehicleDetailsModelFromJson(String str) =>
    str.isEmpty ? null : GetVehicleDetailsModel.fromJson(json.decode(str));

String getVehicleDetailsModelToJson(GetVehicleDetailsModel? data) =>
    json.encode(data?.toJson() ?? {});

class GetVehicleDetailsModel {
  int? status;
  String? message;
  List<Datum>? data;

  GetVehicleDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetVehicleDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetVehicleDetailsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.map((x) => x.toJson()).toList(),
      };
}

class Datum {
  int? vehicleId;
  int? societyId;
  int? memberId;
  int? flatId;
  String? vehicleNo;
  String? type;
  String? model;
  String? status;
  Parking? parking;

  Datum({
    this.vehicleId,
    this.societyId,
    this.memberId,
    this.flatId,
    this.vehicleNo,
    this.type,
    this.model,
    this.status,
    this.parking,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        vehicleId: json["vehicle_id"],
        societyId: json["society_id"],
        memberId: json["member_id"],
        flatId: json["flat_id"],
        vehicleNo: json["vehicle_no"],
        type: json["type"],
        model: json["model"],
        status: json["status"],
        parking:
            json["parking"] != null ? Parking.fromJson(json["parking"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "vehicle_id": vehicleId,
        "society_id": societyId,
        "member_id": memberId,
        "flat_id": flatId,
        "vehicle_no": vehicleNo,
        "type": type,
        "model": model,
        "status": status,
        "parking": parking?.toJson(),
      };
}

class Parking {
  int? parkingId;
  int? flatId;
  int? vehicleId;
  String? slotNumber;
  String? status;
  int? societyId;

  Parking({
    this.parkingId,
    this.flatId,
    this.vehicleId,
    this.slotNumber,
    this.status,
    this.societyId,
  });

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
        parkingId: json["parking_id"],
        flatId: json["flat_id"],
        vehicleId: json["vehicle_id"],
        slotNumber: json["slot_number"],
        status: json["status"],
        societyId: json["society_id"],
      );

  Map<String, dynamic> toJson() => {
        "parking_id": parkingId,
        "flat_id": flatId,
        "vehicle_id": vehicleId,
        "slot_number": slotNumber,
        "status": status,
        "society_id": societyId,
      };
}
