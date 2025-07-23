part of 'payments_bloc.dart';

sealed class PaymentsState extends Equatable {
  const PaymentsState();

  @override
  List<Object> get props => [];
}

final class PaymentsInitial extends PaymentsState {
  @override
  List<Object> get props => [];
}

final class PaymentsLoading extends PaymentsState {
  @override
  List<Object> get props => [];
}

class PaymentsLoadedState extends PaymentsState {
  // final UnPaidMaintainenceModel? dataa;
  final List<Maintenance> unPaidMaintenance;
  final List<Fine> unPaidFines;
  final List<Maintenance> paidMaintenance;
  final List<Fine> paidFines;

  const PaymentsLoadedState(
      {required this.unPaidMaintenance,
      required this.unPaidFines,
      required this.paidMaintenance,
      required this.paidFines});
  @override
  List<Object> get props =>
      [unPaidMaintenance, unPaidFines, paidMaintenance, paidFines];
}

// class PaymentsPaidLoadedState extends PaymentsState {
//   final List<Datum>? paidData;
//   const PaymentsPaidLoadedState({required this.paidData});
//   @override
//   List<Object> get props => [paidData ?? Object()];
// }

final class PaymentsFailed extends PaymentsState {
  const PaymentsFailed({required this.msg});
  final String? msg;
  @override
  List<Object> get props => [];
}
