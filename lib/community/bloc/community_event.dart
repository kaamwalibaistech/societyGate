part of 'community_bloc.dart';

sealed class CommunityEvent extends Equatable {}

final class CommunityPostEvent extends CommunityEvent {
  final String page;
  final String limit;
  CommunityPostEvent({required this.page, required this.limit});
  @override
  List<Object?> get props => [page, limit];
}

final class CommunityCommentEvent extends CommunityEvent {
  final String postId;
  final String page;
  CommunityCommentEvent({required this.postId, required this.page});
  @override
  List<Object?> get props => [postId, page];
}
