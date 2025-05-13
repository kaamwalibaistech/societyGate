part of 'community_bloc.dart';

sealed class CommunityPostState extends Equatable {}

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
  CommunityPostSuccess(
      {required this.communityModel, required this.commentsList});
  @override
  List<Object?> get props => [communityModel, commentsList];
}

final class CommunityPostError extends CommunityPostState {
  @override
  List<Object?> get props => [];
}
