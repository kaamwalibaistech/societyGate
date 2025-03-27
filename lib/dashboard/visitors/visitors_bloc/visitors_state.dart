part of 'visitors_bloc.dart';

abstract class VisitorsState extends Equatable {}

final class VisitorsInitialState extends VisitorsState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class VisitorsSuccessState extends VisitorsState {
  final VisitorsListModel? visitorsListModel;
  final List<Map<String, dynamic>>? getManualvisitorsList;

  VisitorsSuccessState({this.visitorsListModel, this.getManualvisitorsList});
  @override
  List<Object?> get props => [visitorsListModel];
}

final class VisitorsErrorState extends VisitorsState {
  final String msg;
  VisitorsErrorState(this.msg);
  @override
  List<Object?> get props => [msg];
}
