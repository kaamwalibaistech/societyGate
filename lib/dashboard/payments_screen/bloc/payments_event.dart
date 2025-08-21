part of 'payments_bloc.dart';

abstract class PaymentsEvent extends Equatable {}

class UnpaidPaymentsEvent extends PaymentsEvent {
  final String societyId;
  final String userId;
  UnpaidPaymentsEvent({required this.societyId, required this.userId});

  @override
  List<Object> get props => [societyId, userId];
}

// class PaidPaymentsEvent extends PaymentsEvent {
//   final String societyId;
//   final String userId;
//   PaidPaymentsEvent({required this.societyId, required this.userId});

//   @override
//   List<Object> get props => [societyId, userId];
// }
