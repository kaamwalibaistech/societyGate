import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/dashboard/visitors/network/visitorslist_api.dart';
import 'package:my_society/models/login_model.dart';
import 'package:my_society/models/visitorslist_model.dart';

part 'visitors_event.dart';
part 'visitors_state.dart';

class VisitorsBloc extends Bloc<VisitorsEvent, VisitorsState> {
  VisitorsBloc() : super(VisitorsInitialState()) {
    on<GetVisitorsEvent>(_getList);
  }

  void _getList(GetVisitorsEvent event, Emitter<VisitorsState> emit) async {
    VisitorsListModel? visitorsListModel;
    LoginModel? loginModel = LocalStoragePref().getLoginModel();

    try {
      if (loginModel!.user!.role == "watchman") {
        final memberData =
            await visitorsListForWatchmanApi(event.soceityId, "1", "10");
        visitorsListModel = memberData;
      } else {
        final memberData =
            await visitorsListApi(event.soceityId, event.flatId, "1", "10");
        visitorsListModel = memberData;
      }

      if (visitorsListModel!.status == 200) {
        emit(VisitorsSuccessState(visitorsListModel: visitorsListModel));
      } else {
        emit(VisitorsErrorState(visitorsListModel.message.toString()));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
