import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constents/local_storage.dart';
import '../../constents/sizedbox.dart';
import '../../models/login_model.dart';
import '../../models/visitorslist_model.dart';
import 'addvisitors_page.dart';
import 'visitors_bloc/visitors_bloc.dart';
import 'visitors_details_page.dart';

class VisitorsPage extends StatefulWidget {
  const VisitorsPage({super.key});

  @override
  State<VisitorsPage> createState() => _VisitorsPageState();
}

class _VisitorsPageState extends State<VisitorsPage> {
  LoginModel? loginModel;
  @override
  void initState() {
    super.initState();
    fetchVisitors();
  }

  fetchVisitors() {
    final loginModelStorage = LocalStoragePref().getLoginModel();

    setState(() {
      loginModel = loginModelStorage;
    });
    if (loginModel != null) {
      final societyId = loginModel?.user?.societyId;
      final flatId = loginModel?.user?.flatId;

      context.read<VisitorsBloc>().add(GetVisitorsEvent(
          soceityId: societyId.toString(), flatId: flatId.toString()));
    } else {
      log("LoginModel not found in local storage.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        floatingActionButton: loginModel?.user?.role != "watchman"
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddVisitorsPage()));
                })
            : null,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text(
            "Visitors",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 10,
        ),
        body: BlocBuilder<VisitorsBloc, VisitorsState>(
          builder: (context, state) {
            if (state is VisitorsInitialState) {
              return _buildShimmer();
            } else if (state is VisitorsSuccessState) {
              return Column(
                children: [
                  const TabBar(
                    labelColor: Colors.deepPurpleAccent,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Upcomming"),
                      // Tab(text: "Regular"),
                      Tab(text: "Past"),
                    ],
                  ),
                  sizedBoxH10(context),
                  Expanded(
                    child: TabBarView(
                      children: [
                        (state.visitorsListModel?.data?.upcomingVisitors?.list
                                    ?.isNotEmpty ??
                                false)
                            ? getUpcomingVisitorsWidget(
                                context,
                                state.visitorsListModel!.data?.upcomingVisitors
                                    ?.list)
                            : const Center(child: Text("No visitors today!")),
                        // (state.visitorsListModel?.data?.regularVisitors?.list
                        //             ?.isNotEmpty ??
                        //         false)
                        // ? getRegularVisitorsWidget(
                        //     context,
                        //     state.visitorsListModel!.data!.regularVisitors!
                        //         .list)
                        // : const Center(child: Text("Not available!")),
                        (state.visitorsListModel?.data?.pastVisitors?.list
                                    ?.isNotEmpty ??
                                false)
                            ? getPastVisitorsWidget(
                                context,
                                state.visitorsListModel?.data?.pastVisitors
                                    ?.list)
                            : const Center(child: Text("No visitors!")),
                      ],
                    ),
                  )
                ],
              );
            } else if (state is VisitorsErrorState) {
              return Column(
                children: [
                  const TabBar(
                    labelColor: Colors.deepPurpleAccent,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Upcomming"),
                      // Tab(text: "Regular"),
                      Tab(text: "Past"),
                    ],
                  ),
                  sizedBoxH10(context),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildError(state.msg),
                        _buildError(state.msg),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Text("data");
              //CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildError(String msg) {
    return Center(
      child: Text(
        msg,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget getUpcomingVisitorsWidget(
    BuildContext context,
    List<Visitor>? visitorsList,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: visitorsList?.length ?? 0,
          itemBuilder: (context, index) {
            final visitors = visitorsList![index];
            //final visitorsList = upcomingVisitors.data[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VisitorsDetailsPage(
                              visitorID: visitors.visitorId.toString(),
                              societyId:
                                  loginModel?.user?.societyId.toString() ?? "",
                              flatId: loginModel?.user?.flatId.toString() ?? "",
                            )));
              },
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  //height: 75,
                  decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 65,
                        child: ListTile(
                          leading: const CircleAvatar(
                            foregroundImage: AssetImage("lib/assets/qr.jpg"),
                            radius: 30,
                          ),
                          title: Text(visitors.name ?? "Not available"),
                          subtitle: Text(visitors.phone ?? "Not available"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                visitors.relation ?? "Not available",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.blueGrey),
                              ),
                              sizedBoxW5(context),
                              const Icon(
                                Icons.circle,
                                size: 6,
                                color: Colors.blueGrey,
                              ),
                              sizedBoxW5(context),
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  visitors.visitingPurpose ?? "Not available",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.blueGrey),
                                ),
                              ),
                              //   sizedBoxW5(context),
                              const SizedBox(
                                height: 10,
                                child: VerticalDivider(
                                  color: Colors.blueGrey,
                                  thickness: 1,
                                  width: 20,
                                ),
                              ),
                              sizedBoxW5(context),
                              Text(
                                visitors.visitingDate ?? "Not available",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.blueGrey),
                              ),
                            ]),
                      ),
                      sizedBoxH5(context)
                    ],
                  )),
            );
          }),
    );
  }

  Widget getPastVisitorsWidget(
    BuildContext context,
    List<Visitor>? pastVisitorsList,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: pastVisitorsList?.length ?? 0,
          itemBuilder: (context, index) {
            final pastvisitors = pastVisitorsList![index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VisitorsDetailsPage(
                              visitorID: pastvisitors.visitorId.toString(),
                              societyId:
                                  loginModel?.user?.societyId.toString() ?? "",
                              flatId: loginModel?.user?.flatId.toString() ?? "",
                            )));
              },
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  height: 75,
                  decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      foregroundImage: AssetImage("lib/assets/qr.jpg"),
                      radius: 30,
                    ),
                    title: Text(pastvisitors.name ?? "Not Available"),
                    subtitle: Text(pastvisitors.phone ?? "Not Available"),
                  )),
            );
          }),
    );
  }
}
