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

  Data(
      {this.amenityId,
      this.societyId,
      this.amenityName,
      this.amount,
      this.duration});

  Data.fromJson(Map<String, dynamic> json) {
    amenityId = json['amenity_id'];
    societyId = json['society_id'];
    amenityName = json['amenity_name'];
    amount = json['amount'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amenity_id'] = amenityId;
    data['society_id'] = societyId;
    data['amenity_name'] = amenityName;
    data['amount'] = amount;
    data['duration'] = duration;
    return data;
  }
}
