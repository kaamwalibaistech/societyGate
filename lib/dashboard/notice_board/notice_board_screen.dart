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
                child: Padding(
                  padding: EdgeInsets.only(top: 300),
                  child: Text(
                    "No Notices Available",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
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
                  typeColor = Colors.green;
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notice.title ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notice.description ?? "",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Created: ${notice.createdAt}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: typeColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: typeColor.withOpacity(0.5)),
                              ),
                              child: Text(
                                notice.announcementType ?? "",
                                style: TextStyle(
                                  color: typeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is HomePageLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: Text("Failed to load notices."));
        },
      ),
    );
  }
}
