import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:society_gate/community/network/community_apis.dart';
import 'package:society_gate/models/comments_model.dart';

import 'bloc/community_bloc.dart';

class CommentItem extends StatelessWidget {
  final Comment comments;
  final int memberId;
  final String limit;
  final String postId;
  final bool isoutSide;
  const CommentItem(
      {super.key,
      required this.comments,
      required this.memberId,
      required this.limit,
      required this.postId,
      required this.isoutSide});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) =>
          BlocProvider.of<CommunityBloc>(context)
              .add(CommunityPostEvent(page: '1', limit: limit)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              leading: CircleAvatar(
                radius: 15,
                foregroundImage: NetworkImage(comments.profile ??
                    "https://ui-avatars.com/api/?background=random&name=User+Namez"),
              ),
              title: Text(
                comments.memberName ?? "NA",
                style: const TextStyle(fontSize: 12),
              ),
              trailing: PopupMenuButton(
                color: Colors.white,
                icon: Icon(
                  Icons.more_vert_outlined,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                itemBuilder: (context) => [
                  memberId == comments.memberId
                      ? const PopupMenuItem<int>(
                          height: 25,
                          value: 1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline,
                                weight: 5,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )
                      : const PopupMenuItem<int>(
                          value: 2,
                          height: 25,
                          child: Row(
                            children: [
                              Icon(
                                Icons.flag_sharp,
                                weight: 5,
                                size: 20,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Report",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                ],
                onSelected: (value) async {
                  if (value == 1) {
                    // String msg =
                    await deleteComment(comments.id.toString());
                    // EasyLoading.showToast(msg);
                    if (isoutSide == true) {
                      BlocProvider.of<CommunityBloc>(context)
                          .add(CommunityPostEvent(page: '1', limit: limit));
                    } else {
                      BlocProvider.of<CommentsBloc>(context).add(
                          CommunityCommentEvent(page: '1', postId: postId));
                    }
                    // setState(() {});
                  } else if (value == 2) {
                    EasyLoading.showToast("Post reported soon.");
                  } //more in future
                },
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              comments.comment ?? "NA",
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const Divider(
            color: Colors.white60,
          ),
        ],
      ),
    );
  }
}
