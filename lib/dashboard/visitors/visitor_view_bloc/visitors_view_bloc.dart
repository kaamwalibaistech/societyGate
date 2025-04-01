import 'package:bloc/bloc.dart';

import '../../../models/visitors_details_model.dart';
import '../network/visitors_details_api.dart';
import 'visitors_view_event.dart';
import 'visitors_view_state.dart';

class VisitorsDetailBloc
    extends Bloc<VisitorDetailsEvent, VisitorsDetailState> {
  VisitorsDetailBloc() : super(VisitorsDetailInitialState()) {
    on<GetVisitorDetailEvent>(_getDetails);
  }

  void _getDetails(
      GetVisitorDetailEvent event, Emitter<VisitorsDetailState> emit) async {
    VisitorsDetailModel? visitorsDetailModel;
    try {
      final memberData = await visitorsDetailsApi(event.visitorId);
      visitorsDetailModel = memberData;
      if (visitorsDetailModel!.status == 200) {
        emit(VisitorsDetailSuccessState(
            visitorsDetailModel: visitorsDetailModel));
      } else {
        emit(VisitorsDetailErrorState(
            visitorsDetailModel.message?.toString() ?? "Not found!"));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
