import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:society_gate/bloc/homepage_bloc.dart';
import 'package:society_gate/bloc/homepage_event.dart';
import 'package:society_gate/bloc/homepage_state.dart';

import '../../constents/local_storage.dart';
import 'add_notice_screen.dart';

class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomepageBloc>(context).add(GetHomePageDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final logInData = LocalStoragePref().getLoginModel();
    return Scaffold(
      floatingActionButton: logInData!.user!.role == "admin"
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddNoticeScreen()));
              })
          : const SizedBox.shrink(),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 52, 84),
        title: const Text(
          "All Notices",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 10.0, left: 8),
              //   child: Container(
              //     height: MediaQuery.of(context).size.height * 0.05,
              //     width: MediaQuery.of(context).size.width * 0.25,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: const Color.fromARGB(255, 19, 52, 84),
              //     ),
              //     child: const Center(
              //       child: Text(
              //         "Add New ",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
              if (state is HomePageLoadedState)
                state.mydata!.data.announcements.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: state.mydata!.data.announcements.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          const Color.fromARGB(255, 19, 52, 84),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                state.mydata!.data
                                                    .announcements[index].title,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            // maxLines: 2,
                                            // overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            state
                                                .mydata!
                                                .data
                                                .announcements[index]
                                                .description,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  "Created At : ${state.mydata!.data.announcements[index].createdAt}"
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  state
                                                      .mydata!
                                                      .data
                                                      .announcements[index]
                                                      .announcementType,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                      )
                    : const Center(
                        child: Padding(
                        padding: EdgeInsets.only(top: 320.0),
                        child: Text("No Notices"),
                      ))
            ],
          );
        },
      ),
    );
  }
}
