part of 'payments_bloc.dart';

sealed class PaymentsState extends Equatable {
  const PaymentsState();
  
  @override
  List<Object> get props => [];
}

final class PaymentsInitial extends PaymentsState {}
