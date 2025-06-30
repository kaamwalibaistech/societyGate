import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:society_gate/community/bloc/community_bloc.dart';
import 'package:society_gate/community/community_commet_bottomsheet.dart';
import 'package:society_gate/community/network/community_apis.dart';
import 'package:society_gate/constents/sizedbox.dart';
import 'package:society_gate/models/comments_model.dart';
import 'package:society_gate/models/community_model.dart';

import '../constents/local_storage.dart';
import 'comment_item.dart';
import 'community_loading.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CommunityBloc>(context).add(CommunityPostEvent(page: '1'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CommunityBloc, CommunityPostState>(
        builder: (context, state) {
      if (state is CommunityPostInitial || state is CommunityPostLoading) {
        return const CommunityLoading();
      } else if (state is CommunityPostSuccess) {
        return ListView.builder(
            itemCount: state.communityModel?.data?.length ?? 0,
            itemBuilder: (context, index) {
              final post = state.communityModel?.data?[index];
              // Filter comments for this post
              List<Comment> finalComments = state.commentsList
                  .where((comment) => comment.communityPostId == post?.id)
                  .toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                        foregroundImage: CachedNetworkImageProvider(post
                                ?.profileImage ??
                            "https://ui-avatars.com/api/?background=random&name=User+Names")),
                    title: Text(post?.societyName ?? ""),
                    subtitle: Text(
                        "${post?.adminName ?? "NA"}   • ${getTimeAgo(post?.createdAt)}"),
                    trailing: PopupMenuButton(
                      color: Colors.white,
                      icon: Icon(
                        Icons.more_vert_outlined,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      itemBuilder: (context) => [
                        state.adminName == post?.adminName
                            ? const PopupMenuItem<int>(
                                height: 30,
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
                                height: 0, value: 0, child: SizedBox.shrink()),
                        const PopupMenuItem<int>(
                          height: 30,
                          value: 2,
                          child: Row(
                            children: [
                              Icon(
                                Icons.share,
                                weight: 5,
                                size: 20,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Share",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )
                      ],
                      onSelected: (value) async {
                        if (value == 1) {
                          EasyLoading.show();
                          String msg =
                              await deletePost(post?.id.toString() ?? "");
                          EasyLoading.showToast(msg);
                          context
                              .read<CommunityBloc>()
                              .add(CommunityPostEvent(page: '1'));
                        } else if (value == 2) {
                          EasyLoading.showToast("Working on it");
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post?.title ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ExpansionTile(
                          title: Text(
                            post?.description ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          dense: true,
                          iconColor: Colors.green,
                          collapsedIconColor: Colors.red,
                          minTileHeight: 10,
                          expandedAlignment: Alignment.topLeft,
                          childrenPadding: const EdgeInsets.only(
                              left: 15, right: 10, bottom: 5),
                          children: [
                            Text(
                              post?.description ?? "",
                            )
                          ],
                        ),
                        SizedBox(
                            height: 400,
                            width: double.maxFinite,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                post?.photo ??
                                    "https://green-delta.com/wp-content/uploads/2021/07/not-available.png",
                                fit: BoxFit.fitWidth,
                              ),
                            )),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 6),
                                child: Text(post!.like.toString()),
                              ),
                              IconButton(
                                onPressed: () {
                                  EasyLoading.showToast("Working on it");
                                },
                                icon: const Icon(
                                  Icons.thumb_up_outlined,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 6),
                                child: Text(post.dislike.toString()),
                              ),
                              IconButton(
                                onPressed: () {
                                  EasyLoading.showToast("Working on it");
                                },
                                icon: const Icon(
                                  Icons.thumb_down_outlined,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                // onPressed: () => showCommentsBottomSheet(
                                //     finalComments, post.id.toString()),
                                onPressed: () => showModalBottomSheet(
                                  context: context,
                                  showDragHandle: true,
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24)),
                                  ),
                                  builder: (context) =>
                                      CommunityCommetBottomsheet(
                                          finalComments: finalComments,
                                          postId: post.id.toString()),
                                ),
                                icon: const Icon(
                                  Icons.chat,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              // IconButton(
                              //   onPressed: () {
                              //     EasyLoading.showToast("Working on it");
                              //   },
                              //   icon: const Icon(
                              //     Icons.share,
                              //     color: Colors.blueGrey,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        sizedBoxH5(context),
                        finalComments.isNotEmpty
                            ? GestureDetector(
                                // onTap: () => showCommentsBottomSheet(
                                //     finalComments, post.id.toString()),
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  showDragHandle: true,
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24)),
                                  ),
                                  builder: (context) =>
                                      CommunityCommetBottomsheet(
                                          finalComments: finalComments,
                                          postId: post.id.toString()),
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        )),
                                    child: Column(
                                      children: [
                                        CommentItem(
                                          comments: finalComments[0],
                                          memberId: state.memberId,
                                          postId: post.id.toString(),
                                          isoutSide: true,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("See all"),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF6B4EFF)
                                                      .withAlpha(30),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.arrow_forward,
                                                  color: Color(0xFF6B4EFF),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              )
                            : const SizedBox.shrink(),
                        const Divider(),
                        sizedBoxH10(context),
                      ],
                    ),
                  )
                ],
              );
            });
      } else {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.blue,
        ));
      }
    }));
  }

  String getTimeAgo(String? pubDate) {
    // Parse the published date as UTC
    DateTime published = DateTime.parse(pubDate!).toUtc();
    // Get current date in UTC
    DateTime now = DateTime.now().toUtc();
    // Calculate difference
    Duration diff = now.difference(published);

    if (diff.inDays > 1) {
      return "${diff.inDays} days ago";
    } else if (diff.inDays == 1) {
      return "1 day ago";
    } else if (diff.inHours >= 1) {
      return "${diff.inHours} hours ago";
    } else if (diff.inMinutes >= 1) {
      return "${diff.inMinutes} minutes ago";
    } else {
      return "Just now";
    }
  }
}
