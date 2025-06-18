import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:society_gate/community/bloc/community_bloc.dart';
import 'package:society_gate/community/network/community_apis.dart';
import 'package:society_gate/constents/sizedbox.dart';
import 'package:society_gate/models/comments_model.dart';
import 'package:society_gate/models/community_model.dart';

import '../constents/local_storage.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  CommunityBloc? communityBloc;
  late int societyId;
  late int memberId;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    CommunityBloc communityBloc = BlocProvider.of<CommunityBloc>(context);
    communityBloc.add(CommunityPostEvent(page: '1'));
    final getLoginModel = LocalStoragePref().getLoginModel();
    societyId = getLoginModel!.user!.societyId;
    memberId = getLoginModel.user!.userId;
    log(societyId.toString());
    // setState(() {

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CommunityBloc, CommunityPostState>(
        builder: (context, state) {
      if (state is CommunityPostInitial || state is CommunityPostLoading) {
        return _loading();
      } else if (state is CommunityPostSuccess) {
        return _post(state.communityModel, state.commentsList);
      } else {
        return Center(child: Text(state.toString()));
      }
    }));
  }

  Widget _loading() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 120,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5))),
                    const SizedBox(height: 6),
                    Container(
                        width: 80,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5))),
                  ],
                ),
              ]),
              const SizedBox(height: 12),
              Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5))),
              const SizedBox(height: 10),
              Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5))),
              const SizedBox(height: 16),
              Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5))),
                            )),
                  ),
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5))),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5))),
              const SizedBox(height: 50),
              Row(children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 120,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5))),
                    const SizedBox(height: 6),
                    Container(
                        width: 80,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5))),
                  ],
                ),
              ]),
              const SizedBox(height: 12),
              Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _post(CommunityModel? communityModel, List<Comment> commentsList) {
    return ListView.builder(
        itemCount: communityModel?.data?.length ?? 0,
        itemBuilder: (context, index) {
          final post = communityModel?.data?[index];
          // Filter comments for this post
          List<Comment> finalComments = commentsList
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
                  subtitle: Text(post?.adminName ?? "")),
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
                      childrenPadding:
                          const EdgeInsets.only(left: 15, right: 10, bottom: 5),
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
                            fit: BoxFit.fill,
                          ),
                          //  Image.asset(
                          //   'lib/assets/girlphoto1.jpg',
                          //   fit: BoxFit.fill,
                          // ),
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
                            onPressed: () {},
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.thumb_down_outlined,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => showCommentsBottomSheet(
                                finalComments, post.id.toString()),
                            icon: const Icon(
                              Icons.chat,
                              color: Colors.blueGrey,
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () {},
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
                            onTap: () => showCommentsBottomSheet(
                                finalComments, post.id.toString()),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: Column(
                                  children: [
                                    commentTile(finalComments[0]),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("See all"),
                                          Container(
                                            padding: const EdgeInsets.all(2),
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
  }

  void showCommentsBottomSheet(List<Comment> comments, String postId) {
    TextEditingController commentController = TextEditingController();
    // List<Comment> comments = List.from(initialComments); // Make it mutable

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: comments.isEmpty
                          ? const Center(
                              child:
                                  Text("No comments available for this post!"),
                            )
                          : ListView.builder(
                              itemCount: comments.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  commentTile(comments[index]),
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

                              await insertComment(
                                  postId, societyId, memberId, commentText);

                              setState(() {
                                comments.insert(
                                    0,
                                    Comment(
                                        comment: commentText,
                                        memberName: getLoginModel.user!.uname,
                                        profile:
                                            getLoginModel.user!.profile_iamge));

                                commentController.clear();
                              });
                              setState(() {});
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
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget commentTile(Comment comments) {
    return Column(
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
                  String msg = await deleteComment(comments.id.toString());
                  EasyLoading.showToast(msg);
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
    );
  }
}
