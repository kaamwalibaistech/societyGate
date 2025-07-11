import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:society_gate/bloc/homepage_bloc.dart';
import 'package:society_gate/bloc/homepage_event.dart';
import 'package:society_gate/bloc/homepage_state.dart';
import 'package:society_gate/dashboard/notice_board/notice_api.dart';
import 'package:society_gate/models/login_model.dart';

import '../../constents/local_storage.dart';
import 'add_notice_screen.dart';

class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  LoginModel? logInData;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomepageBloc>(context).add(GetHomePageDataEvent());
    getData();
  }

  void getData() {
    logInData = LocalStoragePref().getLoginModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: logInData!.user!.role == "admin"
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddNoticeScreen()),
                );
              },
            )
          : const SizedBox.shrink(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Notice Board",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: const BackButton(color: Colors.black87),
      ),
      body: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          if (state is HomePageLoadedState) {
            final notices = state.mydata?.announcements ?? [];
            if (notices.isEmpty) {
              return const Center(
                child: Text(
                  "No Notices Available",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notices.length,
              itemBuilder: (context, index) {
                final notice = notices[index];

                // Set colors based on type
                Color typeColor = Colors.blue;

                if (notice.announcementType!.contains('emergency')) {
                  typeColor = Colors.red;
                } else if (notice.announcementType!
                    .toLowerCase()
                    .contains('maintenance')) {
                  typeColor = Colors.greenAccent.shade700;
                }

                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: typeColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notice.title ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: typeColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(
                          notice.description ?? "",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Created: ${notice.createdAt}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          PopupMenuButton(
                            iconColor: Colors.red,
                            icon: const Icon(Icons.more_vert_outlined),
                            itemBuilder: (context) => [
                              logInData?.user?.role == "admin"
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
                                      height: 0,
                                      value: 0,
                                      child: SizedBox.shrink()),
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

                                String msg = await deleteAnnouncement(
                                    notice.announcementId?.toString() ?? "");

                                EasyLoading.showToast(msg);
                                BlocProvider.of<HomepageBloc>(context)
                                    .add(GetHomePageDataEvent());
                              } else if (value == 2) {
                                EasyLoading.showToast("Working on it");
                              }
                            },
                          ),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 5, vertical: 2),
                          //   decoration: BoxDecoration(
                          //     color: typeColor.withOpacity(0.1),
                          //     borderRadius: BorderRadius.circular(20),
                          //     border:
                          //         Border.all(color: typeColor.withOpacity(0.5)),
                          //   ),
                          //   child: Text(
                          //     notice.announcementType ?? "",
                          //     style: TextStyle(
                          //       color: typeColor,
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 11,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      // Divider(
                      //   color: Colors.blue.shade50,
                      // )
                    ],
                  ),
                );
              },
            );
          } else {
            const Center(child: CircularProgressIndicator());
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
