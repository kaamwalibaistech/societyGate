part of 'payments_bloc.dart';

class PaymentsEvent extends Equatable {
  final String societyId;
  final String userId;
  const PaymentsEvent({required this.societyId, required this.userId});

  @override
  List<Object> get props => [societyId, userId];
}
