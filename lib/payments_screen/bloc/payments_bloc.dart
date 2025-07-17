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
      final dataa = await ApiRepository().getUnpaidMaintainence(
          event.societyId.toString(), event.userId.toString());

      if (dataa?.status == 200) {
        List<Maintenance> unPaidMaintenance = [];
        List<Fine> unPaidFines = [];
        List<Maintenance> paidMaintenance = [];
        List<Fine> paidFines = [];

        List<Maintenance> maintainence = dataa?.data?.last.maintenance ?? [];
        List<Fine> fines = dataa?.data?.last.fines ?? [];

        for (int i = 0; i < maintainence.length; i++) {
          if (maintainence[i].status == "unpaid") {
            unPaidMaintenance.add(maintainence[i]);
          } else {
            paidMaintenance.add(maintainence[i]);
          }
        }
        for (int i = 0; i < fines.length; i++) {
          if (fines[i].status == "unpaid") {
            unPaidFines.add(fines[i]);
          } else {
            paidFines.add(fines[i]);
          }
        }

        emit(PaymentsLoadedState(
            unPaidMaintenance: unPaidMaintenance,
            unPaidFines: unPaidFines,
            paidFines: paidFines,
            paidMaintenance: paidMaintenance));
      } else {
        emit(const PaymentsFailed(msg: ""));
      }
    } catch (e) {
      emit(const PaymentsFailed(msg: ""));
      throw Exception(e);
    }
  }
}
