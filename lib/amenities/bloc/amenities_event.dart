part of 'amenities_bloc.dart';

abstract class AmenitiesEvent extends Equatable {}

class GetAllAmenities extends AmenitiesEvent {
  @override
  List<Object?> get props => [];
}

class GetMyAmenities extends AmenitiesEvent {
  final String societyId;
  final String memberId;
  GetMyAmenities({required this.societyId, required this.memberId});
  @override
  List<Object?> get props => [societyId, memberId];
}

class EditAmenitiesEvent extends AmenitiesEvent {
  final String societyId;
  final String amenityId;
  final String name;
  final String amount;
  final String duration;
  EditAmenitiesEvent({
    required this.societyId,
    required this.amenityId,
    required this.name,
    required this.amount,
    required this.duration,
  });
  @override
  List<Object?> get props => [societyId, amenityId, name, amount, duration];
}
