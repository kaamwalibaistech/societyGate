class BuyAmenitiesDone {
  int? status;
  String? message;
  List<Data>? data;

  BuyAmenitiesDone({this.status, this.message, this.data});

  BuyAmenitiesDone.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? amenityId;
  String? amount;
  String? duration;
  String? startTime;
  String? endTime;
  int? bookingId;

  Data(
      {this.amenityId,
      this.amount,
      this.duration,
      this.startTime,
      this.endTime,
      this.bookingId});

  Data.fromJson(Map<String, dynamic> json) {
    amenityId = json['amenity_id'];
    amount = json['amount'];
    duration = json['duration'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    bookingId = json['booking_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amenity_id'] = this.amenityId;
    data['amount'] = this.amount;
    data['duration'] = this.duration;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['booking_id'] = this.bookingId;
    return data;
  }
}
