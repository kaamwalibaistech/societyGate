import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:society_gate/community/bloc/community_bloc.dart';
import 'package:society_gate/community/comment_item.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/models/comments_model.dart';
import 'package:society_gate/models/login_model.dart';

import 'network/community_apis.dart';

class CommunityCommetBottomsheet extends StatefulWidget {
  final List<Comment> finalComments; //useless
  final String postId;
  const CommunityCommetBottomsheet(
      {super.key, required this.finalComments, required this.postId});

  @override
  State<CommunityCommetBottomsheet> createState() =>
      _CommunityCommetBottomsheetState();
}

class _CommunityCommetBottomsheetState
    extends State<CommunityCommetBottomsheet> {
  TextEditingController commentController = TextEditingController();
  LoginModel? loginModel;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CommentsBloc>(context)
        .add(CommunityCommentEvent(page: '1', postId: widget.postId));
    loginModel = LocalStoragePref().getLoginModel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              color: Colors.white,
            ),
            child: BlocBuilder<CommentsBloc, GetCommentsState>(
                builder: (context, state) {
              if (state is CommentsLoading) {
                // return const CircularProgressIndicator();
                return const SizedBox.shrink();
              } else if (state is CommentsSuccess) {
                final commentList = state.commentsModel.data;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: commentList!.isEmpty
                          ? const Center(
                              child:
                                  Text("No comments available for this post!"),
                            )
                          : ListView.builder(
                              itemCount: commentList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => CommentItem(
                                comments: commentList[index],
                                memberId: loginModel?.user?.userId ?? 0,
                                postId: widget.postId,
                                isoutSide: false,
                              ),
                              // commentTile(comments[index]),
                            ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              decoration: const InputDecoration(
                                hintText: 'Add a comment...',
                                border: InputBorder.none,
                              ),
                              maxLines: null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final getLoginModel =
                                  LocalStoragePref().getLoginModel();
                              final societyId =
                                  getLoginModel!.user!.societyId.toString();
                              final memberId =
                                  getLoginModel.user!.userId.toString();

                              String commentText =
                                  commentController.text.trim();
                              if (commentText.isEmpty) return;

                              await insertComment(widget.postId, societyId,
                                  memberId, commentText);

                              // setState(() {
                              //   commentList.insert( 0,
                              //       Comment(
                              //           comment: commentText,
                              //           memberName: getLoginModel.user!.uname,
                              //           profile:
                              //               getLoginModel.user!.profileImage));

                              commentController.clear();
                              // });
                              // setState(() {});
                              Future.delayed(const Duration(milliseconds: 500));
                              BlocProvider.of<CommentsBloc>(context).add(
                                  CommunityCommentEvent(
                                      page: '1', postId: widget.postId));
                              // setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF6B4EFF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })));
  }
}
