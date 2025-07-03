import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/models/unpaid_maintainence_mdel.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  PaymentsBloc() : super(PaymentsInitial()) {
    on<PaymentsEvent>(_fetchPayments);
  }

  void _fetchPayments(PaymentsEvent event, Emitter<PaymentsState> emit) async {
    // emit(CommentsLoading());
    try {
      UnPaidMaintainenceModel? unpaidData;

      unpaidData = await ApiRepository().getUnpaidMaintainence(
          event.societyId.toString(), event.userId.toString());

      if (unpaidData?.status == 200) {
        emit(PaymentsLoadedState(unpaidData: unpaidData));
      } else {
        emit(PaymentsFailed());
      }
    } catch (e) {
      emit(PaymentsFailed());
      throw Exception(e);
    }
  }
}
