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

class PaymentsUNPaidLoadedState extends PaymentsState {
  final List<Datum>? unpaidData;
  const PaymentsUNPaidLoadedState({required this.unpaidData});
  @override
  List<Object> get props => [unpaidData ?? Object()];
}

class PaymentsPaidLoadedState extends PaymentsState {
  final List<Datum>? paidData;
  const PaymentsPaidLoadedState({required this.paidData});
  @override
  List<Object> get props => [paidData ?? Object()];
}

final class PaymentsFailed extends PaymentsState {
  const PaymentsFailed({required this.msg});
  final String? msg;
  @override
  List<Object> get props => [];
}
