import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:society_gate/constents/local_storage.dart';

import '../../models/comments_model.dart';
import '../../models/community_model.dart';
import '../network/community_apis.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityPostState> {
  CommunityBloc() : super(CommunityPostInitial()) {
    on<CommunityPostEvent>(_fetchAllPosts);
  }

  void _fetchAllPosts(
      CommunityPostEvent event, Emitter<CommunityPostState> emit) async {
    // emit(CommunityPostLoading());
    try {
      final getLoginModel = LocalStoragePref().getLoginModel();
      int societyId = getLoginModel?.user?.societyId ?? 0;
      int memberId = getLoginModel?.user?.userId ?? 0;
      String adminName = getLoginModel?.user?.uname ?? "NA";
      List<Comment> commentsList = [];
      final communityModelPost = await getCommunityPosts(event.page, "10");
      if (communityModelPost != null) {
        for (var i = 0; i < communityModelPost.data!.length; i++) {
          String postId = communityModelPost.data![i].id.toString();
          final commentsModel = await getCommentsApi(postId, event.page, "10");
          if (commentsModel != null) {
            commentsList.addAll(commentsModel.data!);
          }
        }
        emit(CommunityPostSuccess(
            communityModel: communityModelPost,
            commentsList: commentsList,
            societyId: societyId,
            memberId: memberId,
            adminName: adminName));
        return;
      } else {
        emit(CommunityPostError());
      }
    } catch (e) {
      emit(CommunityPostError());
      throw Exception(e);
    }
  }
}

class CommentsBloc extends Bloc<CommunityEvent, GetCommentsState> {
  CommentsBloc() : super(CommentsInitial()) {
    on<CommunityCommentEvent>(_fetchcomments);
  }

  void _fetchcomments(
      CommunityCommentEvent event, Emitter<GetCommentsState> emit) async {
    // emit(CommentsLoading());
    try {
      CommentsModel? commentsModel =
          await getCommentsApi(event.postId, event.page, "10");
      if (commentsModel?.status == 200) {
        emit(CommentsSuccess(commentsModel: commentsModel!));
      } else {
        emit(CommentsError());
      }
    } catch (e) {
      emit(CommentsError());
      throw Exception(e);
    }
  }
}
