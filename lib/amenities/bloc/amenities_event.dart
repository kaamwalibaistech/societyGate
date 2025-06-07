part of 'amenities_bloc.dart';

abstract class AmenitiesEvent extends Equatable {}

class GetAllAmenities extends AmenitiesEvent {
  final String societyId;
  GetAllAmenities({required this.societyId});
  @override
  List<Object?> get props => [societyId];
}

class GetMyAmenities extends AmenitiesEvent {
  final String societyId;
  final String memberId;
  GetMyAmenities({required this.societyId, required this.memberId});
  @override
  List<Object?> get props => [societyId, memberId];
}

// class EditAmenities extends AmenitiesEvent {
//   final String societyId;
//   EditAmenities({required this.societyId});
//   @override
//   List<Object?> get props => [societyId];
// }
