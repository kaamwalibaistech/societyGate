import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/constents/sizedbox.dart';
import 'package:my_society/dashboard/visitors/addvisitors_page.dart';
import 'package:my_society/dashboard/visitors/visitors_bloc/visitors_bloc.dart';
import 'package:my_society/dashboard/visitors/visitors_details_page.dart';
import 'package:my_society/models/login_model.dart';
import 'package:my_society/models/visitorslist_model.dart';

class VisitorsPage extends StatefulWidget {
  const VisitorsPage({super.key});

  @override
  State<VisitorsPage> createState() => _VisitorsPageState();
}

class _VisitorsPageState extends State<VisitorsPage> {
  @override
  void initState() {
    super.initState();
    fetchVisitors();
  }

  fetchVisitors() {
    LoginModel? loginModel = LocalStoragePref().getLoginModel();

    if (loginModel != null) {
      final societyId = loginModel.user!.societyId;
      final flatId = loginModel.user!.flatId;
      context.read<VisitorsBloc>().add(GetVisitorsEvent(
          soceityId: societyId.toString(), flatId: flatId.toString()));
    } else {
      debugPrint("LoginModel not found in local storage.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddVisitorsPage()));
            }),
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
                      Tab(text: "One Time"),
                      Tab(text: "Regular"),
                    ],
                  ),
                  sizedBoxH10(context),
                  Expanded(
                    child: TabBarView(
                      children: [
                        (state.visitorsListModel?.visitors?.isNotEmpty ?? false)
                            ? getVisitorsWidget(
                                context, state.visitorsListModel!.visitors)
                            : Center(child: Text("No visitors today!")),
                        (state.visitorsListModel?.regularvisitors?.isNotEmpty ??
                                false)
                            ? getRegularVisitorsWidget(context,
                                state.visitorsListModel!.regularvisitors)
                            : Center(child: Text("No visitors!")),
                      ],
                    ),
                  )
                ],
              );
            } else if (state is VisitorsErrorState) {
              return _buildError(state.msg);
            } else {
              return CircularProgressIndicator();
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

  Widget getVisitorsWidget(BuildContext context, List<Visitors>? visitors) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: visitors?.length ?? 0,
          itemBuilder: (context, index) {
            final visitorsList = visitors![index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VisitorsDetailsPage(
                            visitorID: visitorsList.visitorId.toString())));
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
                          leading: CircleAvatar(
                            foregroundImage: AssetImage("lib/assets/qr.jpg"),
                            radius: 30,
                          ),
                          title: Text(visitorsList.name ?? "Not available"),
                          subtitle: Text(visitorsList.phone ?? "Not available"),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              visitorsList.relation ?? "Not available",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.blueGrey),
                            ),
                            sizedBoxW5(context),
                            const Icon(
                              Icons.circle,
                              size: 6,
                              color: Colors.blueGrey,
                            ),
                            sizedBoxW5(context),
                            Text(
                              visitorsList.visitingPurpose ?? "Not available",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.blueGrey),
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
                              visitorsList.visitingDate ?? "Not available",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.blueGrey),
                            ),
                          ]),
                      sizedBoxH5(context)
                    ],
                  )),
            );
          }),
    );
  }

  Widget getRegularVisitorsWidget(
      BuildContext context, List<Regularvisitors>? regularvisitors) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: regularvisitors?.length ?? 0,
          itemBuilder: (context, index) {
            final RegularvisitorsList = regularvisitors![index];
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                height: 75,
                decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: CircleAvatar(
                    foregroundImage: AssetImage("lib/assets/qr.jpg"),
                    radius: 30,
                  ),
                  title: Text(RegularvisitorsList.name ?? "Not Available"),
                  subtitle:
                      Text(RegularvisitorsList.address ?? "Not Available"),
                ));
          }),
    );
  }
}
