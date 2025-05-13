import 'package:equatable/equatable.dart';

import '../../../models/visitors_details_model.dart';

abstract class VisitorsDetailState extends Equatable {}

final class VisitorsDetailInitialState extends VisitorsDetailState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class VisitorsDetailSuccessState extends VisitorsDetailState {
  final VisitorsDetailModel? visitorsDetailModel;

  VisitorsDetailSuccessState({required this.visitorsDetailModel});
  @override
  List<Object?> get props => [visitorsDetailModel];
}

final class VisitorsDetailErrorState extends VisitorsDetailState {
  final String msg;
  VisitorsDetailErrorState(this.msg);
  @override
  List<Object?> get props => [msg];
}
