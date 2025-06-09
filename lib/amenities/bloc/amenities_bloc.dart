import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:society_gate/api/api_repository.dart';

import '../../constents/local_storage.dart';
import '../../models/amenities_model.dart';

part 'amenities_event.dart';
part 'amenities_state.dart';

class AllAmenitiesBloc extends Bloc<AmenitiesEvent, GetAllAmenitiesState> {
  AllAmenitiesBloc() : super(GetAllAmenitiesInitial()) {
    on<GetAllAmenities>(_getAllAmenities);
  }

  void _getAllAmenities(
      GetAllAmenities event, Emitter<GetAllAmenitiesState> emit) async {
    emit(GetAllAmenitiesLoading());
    try {
      String societyId =
          (LocalStoragePref().getLoginModel()?.user?.societyId ?? "0")
              .toString();
      final amenities = await ApiRepository().fetchAmenities(societyId);
      // emit(GetAllAmenitiesLoading());
      emit(GetAllAmenitiesSuccess(amenitiesModel: amenities as AmenitiesModel));
    } catch (e) {
      log(e.toString());
      emit(GetAllAmenitiesFailure());
    }
  }
}

class AmenitiesOFMemberBloc extends Bloc<AmenitiesEvent, GetMyAmenitiesState> {
  AmenitiesOFMemberBloc() : super(GetMyAmenitiesInitial()) {
    on<GetAllAmenities>(_getMyAmenities);
  }

  void _getMyAmenities(
      GetAllAmenities event, Emitter<GetMyAmenitiesState> emit) {
    emit(GetMyAmenitiesInitial());
    emit(const GetMyAmenitiesSuccess());
    emit(GetMyAmenitiesFailure());
  }
}

// class EditAmenitiesBloc extends Bloc<AmenitiesEvent, EditAmenitiesState> {
//   EditAmenitiesBloc() : super(EditAmenitiesInitial()) {
//     on<EditAmenities>(_editAmenities);
//   }

//   void _editAmenities(EditAmenities event, Emitter<EditAmenitiesState> emit) {
//     emit(EditAmenitiesLoading());
//     emit(const EditAmenitiesSuccess());
//     emit(EditAmenitiesFailure());
//   }
// }
