import 'package:equatable/equatable.dart';

abstract class VisitorDetailsEvent extends Equatable {}

final class GetVisitorDetailEvent extends VisitorDetailsEvent {
  late final String visitorId;
  GetVisitorDetailEvent({required this.visitorId});
  @override
  List<Object?> get props => [visitorId];
}
