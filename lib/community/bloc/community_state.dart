part of 'community_bloc.dart';

abstract class CommunityPostState extends Equatable {}

final class CommunityPostInitial extends CommunityPostState {
  @override
  List<Object?> get props => [];
}

final class CommunityPostLoading extends CommunityPostState {
  @override
  List<Object?> get props => [];
}

final class CommunityPostSuccess extends CommunityPostState {
  final CommunityModel? communityModel;
  final List<Comment> commentsList;
  final int societyId;
  final int memberId;
  final String adminName;
  CommunityPostSuccess(
      {required this.communityModel,
      required this.commentsList,
      required this.societyId,
      required this.memberId,
      required this.adminName});
  @override
  List<Object?> get props => [communityModel, commentsList];
}

final class CommunityPostError extends CommunityPostState {
  @override
  List<Object?> get props => [];
}

abstract class GetCommentsState extends Equatable {}

final class CommentsInitial extends GetCommentsState {
  @override
  List<Object?> get props => [];
}

final class CommentsLoading extends GetCommentsState {
  @override
  List<Object?> get props => [];
}

final class CommentsSuccess extends GetCommentsState {
  final CommentsModel commentsModel;
  CommentsSuccess({required this.commentsModel});
  @override
  List<Object?> get props => [commentsModel];
}

final class CommentsError extends GetCommentsState {
  @override
  List<Object?> get props => [];
}
