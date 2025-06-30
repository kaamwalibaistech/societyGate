part of 'community_bloc.dart';

sealed class CommunityEvent extends Equatable {}

final class CommunityPostEvent extends CommunityEvent {
  final String page;
  CommunityPostEvent({required this.page});
  @override
  List<Object?> get props => [page];
}

final class CommunityCommentEvent extends CommunityEvent {
  final String postId;
  final String page;
  CommunityCommentEvent({required this.postId, required this.page});
  @override
  List<Object?> get props => [postId, page];
}
