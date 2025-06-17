import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
      List<Comment> commentsList = [];
      final communityModel = await getCommunityPosts(event.page, "10");
      if (communityModel != null) {
        for (var i = 0; i < communityModel.data!.length; i++) {
          log(communityModel.data![i].id.toString());
          final commentsModel = await getCommentsApi(
              // "11", // its for testing only because only this has data data to show
              communityModel.data![i].id
                  .toString(), // use this dynamic value to fetch comments also handle empty list
              event.page,
              "10");
          if (commentsModel != null) {
            commentsList.addAll(commentsModel.data!);
            for (var i = 0; i < commentsModel.data!.length; i++) {
              log(commentsList[i].comment.toString());
            }
          }
        }
        emit(CommunityPostSuccess(
            communityModel: communityModel, commentsList: commentsList));
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
