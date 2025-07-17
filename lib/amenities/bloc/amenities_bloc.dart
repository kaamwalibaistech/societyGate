import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:society_gate/amenities/network/amenities_apis.dart';
import 'package:society_gate/models/get_user_purchase_amenities_model.dart';

import '../../constents/local_storage.dart';
import '../../models/amenities_model.dart';

part 'amenities_event.dart';
part 'amenities_state.dart';

class AllAmenitiesBloc extends Bloc<AmenitiesEvent, GetAllAmenitiesState> {
  AllAmenitiesBloc() : super(GetAllAmenitiesInitial()) {
    on<GetAllAmenities>(_getAllAmenities);
    on<EditAmenitiesEvent>(_editAmenities);
  }

  void _getAllAmenities(
      GetAllAmenities event, Emitter<GetAllAmenitiesState> emit) async {
    // emit(GetAllAmenitiesLoading());
    try {
      final loginModel = LocalStoragePref().getLoginModel();

      final amenities =
          await fetchAmenities(loginModel?.user?.societyId.toString() ?? "");

      GetUserPurchaseAmenitiesModel? getUserPurchaseAmenitiesData =
          await getUserPurchaseAmenities(loginModel?.user?.societyId.toString(),
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

  void _editAmenities(
      EditAmenitiesEvent event, Emitter<GetAllAmenitiesState> emit) async {
    try {
      EasyLoading.show();

      // final amenities =
      Map<String, dynamic>? data = await editAmenitiesApi(event.societyId,
          event.amenityId, event.name, event.amount, event.duration);

      if (data?['status'] == 200) {
        EasyLoading.showSuccess(data?['message'] ?? "");
        // AllAmenitiesBloc().add(GetAllAmenities());
      } else {
        EasyLoading.showInfo(data?['message'] ?? "");
      }

      // if (amenities?.status == 200) {
      //   emit(GetAllAmenitiesSuccess(
      //       amenitiesModel: amenities as AmenitiesModel,
      //     ));
      // } else if (amenities?.status == 404) {
      //   emit(GetAllAmenitiesFailure());
      // } else {
      //   emit(GetAllAmenitiesLoading());
      // }
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      // emit(GetAllAmenitiesFailure());
    }
  }
}

// class AmenitiesOFMemberBloc extends Bloc<AmenitiesEvent, GetMyAmenitiesState> {
//   AmenitiesOFMemberBloc() : super(GetMyAmenitiesInitial()) {
//     on<GetAllAmenities>(_getMyAmenities);
//   }

//   void _getMyAmenities(
//       GetAllAmenities event, Emitter<GetMyAmenitiesState> emit) {
//     emit(GetMyAmenitiesInitial());
//     emit(const GetMyAmenitiesSuccess());
//     emit(GetMyAmenitiesFailure());
//   }
// }

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
