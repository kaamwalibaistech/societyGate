import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_society/dashboard/visitors/network/visitorslist_api.dart';
import 'package:my_society/models/visitorslist_model.dart';

part 'visitors_event.dart';
part 'visitors_state.dart';

class VisitorsBloc extends Bloc<VisitorsEvent, VisitorsState> {
  VisitorsBloc() : super(VisitorsInitialState()) {
    on<GetVisitorsEvent>(_getList);
  }

  void _getList(GetVisitorsEvent event, Emitter<VisitorsState> emit) async {
    VisitorsListModel? _visitorsListModel;
    // emit(VisitorsInitialState());

    try {
      final memberData = await visitorsListApi(event.soceityId, event.flatId);
      _visitorsListModel = memberData;
      if (_visitorsListModel!.status == 200) {
        emit(VisitorsSuccessState(visitorsListModel: _visitorsListModel));
      } else {
        emit(VisitorsErrorState(
            _visitorsListModel?.message.toString() ?? "Error"));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
