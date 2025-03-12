part of 'members_bloc.dart';

abstract class MembersState extends Equatable {}

final class MembersInitialState extends MembersState {
  @override
  List<Object?> get props => [];
}

final class MembersSuccessState extends MembersState {
  final MemberlistModel? memberlistModel;

  MembersSuccessState({required this.memberlistModel});
  @override
  List<Object?> get props => [memberlistModel];
}

final class MembersErrorState extends MembersState {
  final String msg;
  MembersErrorState(this.msg);
  @override
  List<Object?> get props => [msg];
}
