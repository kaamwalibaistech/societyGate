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
      List<Datum>? newUnpaid = [];
      List<Datum>? newPaid = [];
      unpaidData = await ApiRepository().getUnpaidMaintainence(
          event.societyId.toString(), event.userId.toString());

      if (unpaidData?.status == 200) {
        // unpaidData?.data!.removeWhere((e) => e.status == "paid");
        // emit(PaymentsUNPaidLoadedState(unpaidData: unpaidData));
        for (var i in unpaidData!.data!) {
          if (i.status == "unpaid") {
            newUnpaid.add(i);
          } else {
            newPaid.add(i);
          }
        }
        emit(PaymentsPaidLoadedState(paidData: newPaid));
        emit(PaymentsUNPaidLoadedState(unpaidData: newUnpaid));
      } else {
        emit(const PaymentsFailed(msg: ""));
      }
    } catch (e) {
      emit(const PaymentsFailed(msg: ""));
      throw Exception(e);
    }
  }
}
