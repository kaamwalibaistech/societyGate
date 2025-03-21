import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_society/constents/sizedbox.dart';
import 'package:my_society/dashboard/members/member_bloc/members_bloc.dart';
import 'package:my_society/models/login_model.dart';
import 'package:my_society/models/memberlist_model.dart';

import '../../constents/local_storage.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  @override
  void initState() {
    super.initState();

    final loginModel = LocalStoragePref().getLoginModel();

    if (loginModel != null) {
      final societyId = loginModel.user!.societyId;
      context
          .read<MembersBloc>()
          .add(GetMemberListEvent(soceityId: societyId.toString()));
    } else {
      debugPrint("LoginModel not found in local storage.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text(
            "Members",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 10,
        ),
        body: BlocBuilder<MembersBloc, MembersState>(
          builder: (context, state) {
            if (state is MembersInitialState) {
              return _buildShimmer();
            } else if (state is MembersSuccessState) {
              return getUi(state.memberlistModel);
            } else if (state is MembersErrorState) {
              return _buildError(state.msg);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget getUi(MemberlistModel? memberlistModel) {
    String? adminName;
    String? adminEmail;
    if (memberlistModel?.users?.admins?.isNotEmpty ?? false) {
      adminName = memberlistModel!.users!.admins!.first.uname;
      //  adminPic = memberlistModel!.users!.admins!.first.uname;
      adminEmail = memberlistModel.users!.admins!.first.uemail;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: (memberlistModel?.users?.admins?.isNotEmpty ?? false)
              ? Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Admin",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        height: 75,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          leading: const CircleAvatar(
                            foregroundImage:
                                AssetImage("lib/assets/girlphoto2.jpg"),
                            radius: 30,
                          ),
                          title: Text(adminName ?? "Not avilable"),
                          subtitle: Text(adminEmail ?? "Not avilable"),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "No Admin",
                      style: TextStyle(fontSize: 15),
                    ),
                  )),
        ),
        const TabBar(
          labelColor: Colors.deepPurpleAccent,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: "Members"),
            Tab(text: "Watchman"),
          ],
        ),
        sizedBoxH10(context),
        Expanded(
          child: TabBarView(
            children: [
              (memberlistModel?.users?.members?.isNotEmpty ?? false)
                  ? getMembersWidget(context, memberlistModel?.users!.members)
                  : Center(child: const Text("No Members Available!")),
              (memberlistModel?.users?.watchmen?.isNotEmpty ?? false)
                  ? getWatchmanWidget(context, memberlistModel?.users!.watchmen)
                  : Center(child: const Text("No Watchman Available!"))
            ],
          ),
        )
      ],
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 5,
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

  Widget getMembersWidget(BuildContext context, List<Members>? members) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: members?.length ?? 0,
          itemBuilder: (context, index) {
            Members memberList = members![index];
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                height: 75,
                decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: const CircleAvatar(
                    foregroundImage: AssetImage("lib/assets/girlphoto2.jpg"),
                    radius: 30,
                  ),
                  title: Text(memberList.uname),
                  subtitle: Text(memberList.uname),
                ));
          }),
    );
  }

  Widget getWatchmanWidget(BuildContext context, List<Watchmen>? watchmen) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: watchmen?.length ?? 0,
          itemBuilder: (context, index) {
            Watchmen watchmenList = watchmen![index];
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                height: 75,
                decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: CircleAvatar(
                    foregroundImage: AssetImage("lib/assets/watchman.jpg"),
                    radius: 30,
                  ),
                  title: Text(watchmenList.uname ?? "No Name"),
                  subtitle: Text(watchmenList.uphone ?? "Not Available"),
                ));
          }),
    );
  }
}
