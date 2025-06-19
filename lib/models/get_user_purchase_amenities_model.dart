class GetUserPurchaseAmenitiesModel {
  final int? status;
  final List<AmenityPurchaseData>? data;

  GetUserPurchaseAmenitiesModel({this.status, this.data});

  factory GetUserPurchaseAmenitiesModel.fromJson(Map<String, dynamic> json) {
    return GetUserPurchaseAmenitiesModel(
      status: json['status'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AmenityPurchaseData.fromJson(e))
          .toList(),
    );
  }
}

class AmenityPurchaseData {
  final int? id;
  final int? amenityId;
  final String? amount;
  final String? duration;
  final String? startTime;
  final String? endTime;
  final AmenityDetails? amenity;

  AmenityPurchaseData({
    this.id,
    this.amenityId,
    this.amount,
    this.duration,
    this.startTime,
    this.endTime,
    this.amenity,
  });

  factory AmenityPurchaseData.fromJson(Map<String, dynamic> json) {
    return AmenityPurchaseData(
      id: json['id'] as int?,
      amenityId: json['amenity_id'] as int?,
      amount: json['amount'] as String?,
      duration: json['duration'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      amenity: json['amenity'] != null
          ? AmenityDetails.fromJson(json['amenity'])
          : null,
    );
  }
}

class AmenityDetails {
  final int? amenityId;
  final int? societyId;
  final String? name;
  final String? amount;
  final String? duration;

  AmenityDetails({
    this.amenityId,
    this.societyId,
    this.name,
    this.amount,
    this.duration,
  });

  factory AmenityDetails.fromJson(Map<String, dynamic> json) {
    return AmenityDetails(
      amenityId: json['amenity_id'] as int?,
      societyId: json['society_id'] as int?,
      name: json['name'] as String?,
      amount: json['amount'] as String?,
      duration: json['duration'] as String?,
    );
  }
}
