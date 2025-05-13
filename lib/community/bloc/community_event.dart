part of 'community_bloc.dart';

sealed class CommunityEvent extends Equatable {}

final class CommunityPostEvent extends CommunityEvent {
  final String page;
  CommunityPostEvent({required this.page});
  @override
  List<Object?> get props => [page];
}
