part of 'members_bloc.dart';

abstract class MembersEvent extends Equatable {}

final class GetMemberListEvent extends MembersEvent {
  final String soceityId;
  GetMemberListEvent({required this.soceityId});
  @override
  List<Object?> get props => [soceityId];
}
