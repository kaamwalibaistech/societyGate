import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:society_gate/community/network/community_apis.dart';
import 'package:society_gate/models/comments_model.dart';

import 'bloc/community_bloc.dart';

class CommentItem extends StatefulWidget {
  final Comment comments;
  final int memberId;
  final String limit;
  final String postId;
  final bool isoutSide;

  const CommentItem({
    super.key,
    required this.comments,
    required this.memberId,
    required this.limit,
    required this.postId,
    required this.isoutSide,
  });

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final commentText = widget.comments.comment ?? "NA";

    return PopScope(
      onPopInvokedWithResult: (didPop, result) =>
          BlocProvider.of<CommunityBloc>(context)
              .add(CommunityPostEvent(page: '1', limit: widget.limit)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 15,
              foregroundImage: NetworkImage(widget.comments.profile ??
                  "https://ui-avatars.com/api/?background=random&name=User+Namez"),
            ),
            title: Text(
              widget.comments.memberName ?? "NA",
              style: const TextStyle(fontSize: 14),
            ),
            trailing: PopupMenuButton(
              color: Colors.white,
              icon: Icon(
                Icons.more_vert_outlined,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              itemBuilder: (context) => [
                widget.memberId == widget.comments.memberId
                    ? const PopupMenuItem<int>(
                        height: 25,
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline,
                                size: 20, color: Colors.red),
                            SizedBox(width: 5),
                            Text("Delete",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      )
                    : const PopupMenuItem<int>(
                        value: 2,
                        height: 25,
                        child: Row(
                          children: [
                            Icon(Icons.flag_sharp,
                                size: 20, color: Colors.blue),
                            SizedBox(width: 5),
                            Text("Report",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
              ],
              onSelected: (value) async {
                if (value == 1) {
                  await deleteComment(widget.comments.id.toString());
                  if (widget.isoutSide == true) {
                    BlocProvider.of<CommunityBloc>(context).add(
                        CommunityPostEvent(page: '1', limit: widget.limit));
                  } else {
                    BlocProvider.of<CommentsBloc>(context).add(
                        CommunityCommentEvent(
                            page: '1', postId: widget.postId));
                  }
                } else if (value == 2) {
                  EasyLoading.showToast("Post reported soon.");
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  commentText,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 14),
                  overflow: !_isExpanded ? TextOverflow.ellipsis : null,
                  maxLines: !_isExpanded ? 3 : null,
                ),
                if (commentText.length > 120) // optional limit
                  // TextButton(
                  //   style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  //   onPressed: () {
                  //     setState(() {
                  //       _isExpanded = !_isExpanded;
                  //     });
                  //   },
                  // child:
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? 'Show less' : 'Show more',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 13,
                      ),
                    ),
                  ),
                // ),
              ],
            ),
          ),
          const Divider(color: Colors.white60),
        ],
      ),
    );
  }
}
