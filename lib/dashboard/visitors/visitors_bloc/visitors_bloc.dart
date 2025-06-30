import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../constents/local_storage.dart';
import '../../../models/login_model.dart';
import '../../../models/visitorslist_model.dart';
import '../network/visitorslist_api.dart';

part 'visitors_event.dart';
part 'visitors_state.dart';

class VisitorsBloc extends Bloc<VisitorsEvent, VisitorsState> {
  VisitorsBloc() : super(VisitorsInitialState()) {
    on<GetVisitorsEvent>(_getList);
    on<GetEnteredVisitorsEvent>(_getEnteredList);
  }

  void _getList(GetVisitorsEvent event, Emitter<VisitorsState> emit) async {
    VisitorsListModel? visitorsListModel;
    LoginModel? loginModel = LocalStoragePref().getLoginModel();

    try {
      if (loginModel!.user!.role == "watchman") {
        log(loginModel.user!.role.toString());
        final memberData =
            await visitorsListForWatchmanApi(event.soceityId, "1", "100");
        visitorsListModel = memberData;
      } else {
        final memberData =
            await visitorsListApi(event.soceityId, event.flatId, "1", "100");
        visitorsListModel = memberData;
      }

      if (visitorsListModel!.status == 200) {
        emit(VisitorsSuccessState(visitorsListModel: visitorsListModel));
      } else {
        emit(VisitorsErrorState(visitorsListModel.message.toString()));
      }
    } catch (e) {
      emit(VisitorsErrorState(e.toString()));
      throw Exception(e);
    }
  }

  void _getEnteredList(
      GetEnteredVisitorsEvent event, Emitter<VisitorsState> emit) async {
    List<Map<String, dynamic>>? getManualvisitorsList;
    LoginModel? loginModel = LocalStoragePref().getLoginModel();

    try {
      if (loginModel!.user!.role == "watchman") {
        log(loginModel.user!.role.toString());
        final memberData = await enteredVisitorsListForWatchmanApi(
            loginModel.user!.societyId.toString(), "1", "10");
        getManualvisitorsList = memberData;
      }

      if (getManualvisitorsList!.isNotEmpty) {
        emit(
            VisitorsSuccessState(getManualvisitorsList: getManualvisitorsList));
      } else {
        // emit(VisitorsErrorState(visitorsListModel.message.toString()));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
