part of 'visitors_bloc.dart';

abstract class VisitorsEvent extends Equatable {}

final class GetVisitorsEvent extends VisitorsEvent {
  final String soceityId;
  final String flatId;
  GetVisitorsEvent({required this.soceityId, required this.flatId});
  @override
  List<Object?> get props => [soceityId, flatId];
}

final class GetEnteredVisitorsEvent extends VisitorsEvent {
  @override
  List<Object?> get props => [];
}
