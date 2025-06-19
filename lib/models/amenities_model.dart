class AmenitiesModel {
  int? status;
  List<Data>? data;

  AmenitiesModel({this.status, this.data});

  AmenitiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? amenityId;
  int? societyId;
  String? amenityName;
  String? amount;
  String? duration;
  String? createdAt;
  String? updatedAt;
  String? error;

  Data(
      {this.amenityId,
      this.societyId,
      this.amenityName,
      this.amount,
      this.duration,
      this.createdAt,
      this.updatedAt,
      this.error});

  Data.fromJson(Map<String, dynamic> json) {
    amenityId = json['amenity_id'];
    societyId = json['society_id'];
    amenityName = json['name'];
    amount = json['amount'];
    duration = json['duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amenity_id'] = amenityId;
    data['society_id'] = societyId;
    data['name'] = amenityName;
    data['amount'] = amount;
    data['duration'] = duration;
    data['created_at'] = duration;
    data['updated_at'] = duration;
    data['error'] = error;
    return data;
  }
}
