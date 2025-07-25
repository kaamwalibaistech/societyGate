import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/models/paid_maintainence_model.dart';
import 'package:society_gate/models/unpaid_maintainence_mdel.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  PaymentsBloc() : super(PaymentsInitial()) {
    on<UnpaidPaymentsEvent>(_fetchUnPaidPayments);
    // on<PaidPaymentsEvent>(_fetchPaidPayments);
  }

  void _fetchUnPaidPayments(
      UnpaidPaymentsEvent event, Emitter<PaymentsState> emit) async {
    // emit(CommentsLoading());
    try {
      final unPaidData = await ApiRepository().getUnpaidMaintainence(
          event.societyId.toString(), event.userId.toString());

      if (unPaidData?.status == 200) {
        List<UnMaintenance> unPaidMaintenance = [];
        List<UnFine> unPaidFines = [];
        // List<Maintenance> paidMaintenance = [];
        // List<Fine> paidFines = [];

        List<UnMaintenance> maintainence = unPaidData?.maintenance ?? [];
        List<UnFine> fines = unPaidData?.fines ?? [];

        for (int i = 0; i < maintainence.length; i++) {
          // if (maintainence[i].status == "unpaid") {
          unPaidMaintenance.add(maintainence[i]);
          // } else {
          //   paidMaintenance.add(maintainence[i]);
          // }
        }
        for (int i = 0; i < fines.length; i++) {
          // if (fines[i].status == "unpaid") {
          unPaidFines.add(fines[i]);
          // } else {
          //   paidFines.add(fines[i]);
          // }
        }

        final paidData = await ApiRepository().getpaidMaintainence(
            event.societyId.toString(), event.userId.toString());

        if (paidData?.status == 200) {
          List<Maintenance> paidMaintenance = [];
          List<Fine> paidFines = [];
          // List<Maintenance> paidMaintenance = [];
          // List<Fine> paidFines = [];

          List<Maintenance> maintainence = paidData?.maintenance ?? [];
          List<Fine> fines = paidData?.fines ?? [];

          for (int i = 0; i < maintainence.length; i++) {
            // if (maintainence[i].status == "unpaid") {
            paidMaintenance.add(maintainence[i]);
            // } else {
            //   paidMaintenance.add(maintainence[i]);
            // }
          }
          for (int i = 0; i < fines.length; i++) {
            // if (fines[i].status == "unpaid") {
            paidFines.add(fines[i]);
            // } else {
            //   paidFines.add(fines[i]);
            // }
          }

          emit(PaymentsFullyLoadedState(
              unPaidMaintenance: unPaidMaintenance,
              unPaidFines: unPaidFines,
              paidFines: paidFines,
              paidMaintenance: paidMaintenance));
        } else {
          emit(const PaymentsFailed(msg: ""));
        }
      }
    } catch (e) {
      emit(const PaymentsFailed(msg: ""));
      throw Exception(e);
    }

    // void _fetchPaidPayments(
    //     PaidPaymentsEvent event, Emitter<PaymentsState> emit) async {
    //   // emit(CommentsLoading());
    //   try {

    //       emit(PaymentsFullyLoadedState(
    //         paidMaintenance: paidMaintenance,
    //         paidFines: paidFines,
    //       ));
    //     } else {
    //       emit(const PaymentsFailed(msg: ""));
    //     }
    //   } catch (e) {
    //     emit(const PaymentsFailed(msg: ""));
    //     throw Exception(e);
    //   }
    // }
  }
}
