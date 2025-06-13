import 'dart:convert';

GetVehicleDetailsModel? getVehicleDetailsModelFromJson(String str) =>
    str.isEmpty ? null : GetVehicleDetailsModel.fromJson(json.decode(str));

String getVehicleDetailsModelToJson(GetVehicleDetailsModel? data) =>
    json.encode(data?.toJson() ?? {});

class GetVehicleDetailsModel {
  int? status;
  String? message;
  List<Datum>? data;
  final List<String>? errors; // new field for validation errors

  GetVehicleDetailsModel({this.status, this.message, this.data, this.errors});

  factory GetVehicleDetailsModel.fromJson(Map<String, dynamic> json) {
    final dataField = json["data"];

    List<Datum>? dataList;
    List<String>? errorList;

    if (dataField is List && dataField.isNotEmpty) {
      if (dataField.first is Map) {
        // It's a List of Maps — success case
        dataList = dataField.map((x) => Datum.fromJson(x)).toList();
      } else if (dataField.first is String) {
        // It's a List of Strings — validation error case
        errorList = List<String>.from(dataField);
      }
    }

    return GetVehicleDetailsModel(
      status: json["status"],
      message: json["message"],
      data: dataList,
      errors: errorList,
    );
  }

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
