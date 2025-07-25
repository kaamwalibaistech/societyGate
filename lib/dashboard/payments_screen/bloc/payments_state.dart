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

class PaymentsFullyLoadedState extends PaymentsState {
  final List<UnFine>? unPaidFines;
  final List<UnMaintenance>? unPaidMaintenance;
  final List<Fine>? paidFines;
  final List<Maintenance>? paidMaintenance;

  const PaymentsFullyLoadedState({
    this.unPaidFines,
    this.unPaidMaintenance,
    this.paidFines,
    this.paidMaintenance,
  });
  @override
  List<Object> get props => [
        unPaidFines ?? [],
        unPaidMaintenance ?? [],
        paidFines ?? [],
        paidMaintenance ?? [],
      ];
}

// class PaymentsLoadedState extends PaymentsState {
//   final List<UnMaintenance> unPaidMaintenance;
//   final List<UnFine> unPaidFines;
//   // final List<Maintenance> paidMaintenance;
//   // final List<Fine> paidFines;

//   const PaymentsLoadedState({
//     required this.unPaidMaintenance,
//     required this.unPaidFines,
//     // required this.paidMaintenance,
//     // required this.paidFines
//   });
//   @override
//   List<Object> get props => [
//         unPaidMaintenance,
//         unPaidFines,
//       ];
// }

class PaymentsPaidLoadedState extends PaymentsState {
  final List<Maintenance> paidMaintenance;
  final List<Fine> paidFines;
  // final List<Maintenance> paidMaintenance;
  // final List<Fine> paidFines;

  const PaymentsPaidLoadedState({
    required this.paidMaintenance,
    required this.paidFines,
    // required this.paidMaintenance,
    // required this.paidFines
  });
  @override
  List<Object> get props => [
        paidMaintenance,
        paidFines,
      ];
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
