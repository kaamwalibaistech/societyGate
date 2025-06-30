import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/models/get_user_purchase_amenities_model.dart';

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
    ApiRepository apiRepository = ApiRepository();
    try {
      final loginModel = LocalStoragePref().getLoginModel();

      final amenities = await apiRepository
          .fetchAmenities(loginModel?.user?.societyId.toString() ?? "");

      GetUserPurchaseAmenitiesModel? getUserPurchaseAmenitiesData =
          await apiRepository.getUserPurchaseAmenities(
              loginModel?.user?.societyId.toString(),
              loginModel?.user?.userId.toString());

      if (amenities?.status == 200) {
        emit(GetAllAmenitiesSuccess(
            amenitiesModel: amenities as AmenitiesModel,
            getUserPurchaseAmenitiesData: getUserPurchaseAmenitiesData));
      } else if (amenities?.status == 404) {
        emit(GetAllAmenitiesFailure());
      } else {
        emit(GetAllAmenitiesLoading());
      }
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
