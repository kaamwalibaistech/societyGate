part of 'amenities_bloc.dart';

/// ----  Showing amenities to all members in a society on homepage ------
abstract class GetAllAmenitiesState extends Equatable {
  const GetAllAmenitiesState();

  @override
  List<Object> get props => [];
}

final class GetAllAmenitiesInitial extends GetAllAmenitiesState {}

final class GetAllAmenitiesLoading extends GetAllAmenitiesState {}

final class GetAllAmenitiesFailure extends GetAllAmenitiesState {}

final class GetAllAmenitiesSuccess extends GetAllAmenitiesState {
  final AmenitiesModel amenitiesModel;
  const GetAllAmenitiesSuccess({required this.amenitiesModel});
  @override
  List<Object> get props => [amenitiesModel];
}

//-------- Get Amenities for a member ------------
abstract class GetMyAmenitiesState extends Equatable {
  const GetMyAmenitiesState();

  @override
  List<Object> get props => [];
}

final class GetMyAmenitiesInitial extends GetMyAmenitiesState {}

final class GetMyAmenitiesLoading extends GetMyAmenitiesState {}

final class GetMyAmenitiesFailure extends GetMyAmenitiesState {}

final class GetMyAmenitiesSuccess extends GetMyAmenitiesState {
  const GetMyAmenitiesSuccess();
}

/*
// ------ Adding amenities While society registration --------------
sealed class AddAmenitiesState extends Equatable {
  const AddAmenitiesState();

  @override
  List<Object> get props => [];
}

final class AddAmenitiesInitial extends AddAmenitiesState {}

final class AddAmenitiesLoading extends AddAmenitiesState {}

final class AddAmenitiesFailure extends AddAmenitiesState {}

final class AddAmenitiesSuccess extends AddAmenitiesState {
  const AddAmenitiesSuccess();
}

//------- Edit amenities by admin -----------
sealed class EditAmenitiesState extends Equatable {
  const EditAmenitiesState();

  @override
  List<Object> get props => [];
}

final class EditAmenitiesInitial extends EditAmenitiesState {}

final class EditAmenitiesLoading extends EditAmenitiesState {}

final class EditAmenitiesFailure extends EditAmenitiesState {}

final class EditAmenitiesSuccess extends EditAmenitiesState {
  const EditAmenitiesSuccess();
}
*/
