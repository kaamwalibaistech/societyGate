// To parse this JSON data, do
//
//     final getVehicleDetailsModel = getVehicleDetailsModelFromJson(jsonString);

import 'dart:convert';

GetVehicleDetailsModel getVehicleDetailsModelFromJson(String str) =>
    GetVehicleDetailsModel.fromJson(json.decode(str));

String getVehicleDetailsModelToJson(GetVehicleDetailsModel data) =>
    json.encode(data.toJson());

class GetVehicleDetailsModel {
  int status;
  String message;
  List<Datum> data;

  GetVehicleDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetVehicleDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetVehicleDetailsModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int vehicleId;
  int societyId;
  int memberId;
  int flatId;
  String vehicleNo;
  String type;
  String model;
  String status;
  Parking parking;

  Datum({
    required this.vehicleId,
    required this.societyId,
    required this.memberId,
    required this.flatId,
    required this.vehicleNo,
    required this.type,
    required this.model,
    required this.status,
    required this.parking,
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
        parking: Parking.fromJson(json["parking"]),
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
        "parking": parking.toJson(),
      };
}

class Parking {
  int parkingId;
  int flatId;
  int vehicleId;
  String? slotNumber;
  String status;
  int societyId;

  Parking({
    required this.parkingId,
    required this.flatId,
    required this.vehicleId,
    required this.slotNumber,
    required this.status,
    required this.societyId,
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
