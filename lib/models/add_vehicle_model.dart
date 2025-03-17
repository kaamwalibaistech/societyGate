// To parse this JSON data, do
//
//     final addVehicleModel = addVehicleModelFromJson(jsonString);

import 'dart:convert';

AddVehicleModel addVehicleModelFromJson(String str) =>
    AddVehicleModel.fromJson(json.decode(str));

String addVehicleModelToJson(AddVehicleModel data) =>
    json.encode(data.toJson());

class AddVehicleModel {
  int status;
  String message;
  Vehicle vehicle;
  ParkingSlot parkingSlot;

  AddVehicleModel({
    required this.status,
    required this.message,
    required this.vehicle,
    required this.parkingSlot,
  });

  factory AddVehicleModel.fromJson(Map<String, dynamic> json) =>
      AddVehicleModel(
        status: json["status"],
        message: json["message"],
        vehicle: Vehicle.fromJson(json["vehicle"]),
        parkingSlot: ParkingSlot.fromJson(json["parking_slot"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "vehicle": vehicle.toJson(),
        "parking_slot": parkingSlot.toJson(),
      };
}

class ParkingSlot {
  String flatId;
  int vehicleId;
  String slotNumber;
  String status;
  String societyId;
  int parkingId;

  ParkingSlot({
    required this.flatId,
    required this.vehicleId,
    required this.slotNumber,
    required this.status,
    required this.societyId,
    required this.parkingId,
  });

  factory ParkingSlot.fromJson(Map<String, dynamic> json) => ParkingSlot(
        flatId: json["flat_id"],
        vehicleId: json["vehicle_id"],
        slotNumber: json["slot_number"],
        status: json["status"],
        societyId: json["society_id"],
        parkingId: json["parking_id"],
      );

  Map<String, dynamic> toJson() => {
        "flat_id": flatId,
        "vehicle_id": vehicleId,
        "slot_number": slotNumber,
        "status": status,
        "society_id": societyId,
        "parking_id": parkingId,
      };
}

class Vehicle {
  String societyId;
  String memberId;
  String flatId;
  String vehicleNo;
  String type;
  String model;
  String status;
  int vehicleId;

  Vehicle({
    required this.societyId,
    required this.memberId,
    required this.flatId,
    required this.vehicleNo,
    required this.type,
    required this.model,
    required this.status,
    required this.vehicleId,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        societyId: json["society_id"],
        memberId: json["member_id"],
        flatId: json["flat_id"],
        vehicleNo: json["vehicle_no"],
        type: json["type"],
        model: json["model"],
        status: json["status"],
        vehicleId: json["vehicle_id"],
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "member_id": memberId,
        "flat_id": flatId,
        "vehicle_no": vehicleNo,
        "type": type,
        "model": model,
        "status": status,
        "vehicle_id": vehicleId,
      };
}
