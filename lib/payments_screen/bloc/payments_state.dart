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
  final UnPaidMaintainenceModel? unpaidData;
  const PaymentsLoadedState({required this.unpaidData});
  @override
  List<Object> get props => [unpaidData ?? Object()];
}

final class PaymentsFailed extends PaymentsState {
  @override
  List<Object> get props => [];
}
