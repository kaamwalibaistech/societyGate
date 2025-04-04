import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:society_gate/api/api_repository.dart';

import '../../constents/local_storage.dart';
import '../../constents/sizedbox.dart';
import '../../models/login_model.dart';
import '../../models/memberlist_model.dart';
import '../../models/watchman_add_model.dart';
import 'member_bloc/members_bloc.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  LoginModel? loginModel;
  WatchManAddModel? watchmanData;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() {
    loginModel = LocalStoragePref().getLoginModel();

    if (loginModel != null) {
      final societyId = loginModel?.user!.societyId;
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
              return const CircularProgressIndicator();
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
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
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
                  : const Center(child: Text("No Members Available!")),
              (memberlistModel?.users?.watchmen?.isNotEmpty ?? false)
                  ? getWatchmanWidget(context, memberlistModel?.users!.watchmen)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                        const Center(child: Text("No watchman available")),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.30,
                        ),
                        loginModel?.user!.role == "admin"
                            ? Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: FloatingActionButton(
                                    child: const Icon(Icons.add),
                                    onPressed: () {
                                      modelBottomsheet();
                                    }),
                              )
                            : const SizedBox()
                      ],
                    )
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
                  trailing: GestureDetector(
                    onTap: () async {
                      if (loginModel!.user!.role == "admin") {
                        if (memberList.approvalStatus == "pending") {
                          final loginModel = LocalStoragePref().getLoginModel();
                          final societyId = loginModel!.user!.societyId;
                          ApiRepository apiRepository = ApiRepository();
                          await apiRepository
                              .getUserApproval(memberList.userId.toString());
                          context.read<MembersBloc>().add(GetMemberListEvent(
                              soceityId: societyId.toString()));
                          Fluttertoast.showToast(msg: "Member Approved");
                        }
                      } else {
                        Fluttertoast.showToast(msg: "Only admin can Approve");
                      }
                    },
                    child: Text(
                      memberList.approvalStatus,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ));
          }),
    );
  }

  Widget getWatchmanWidget(BuildContext context, List<Watchmen>? watchmen) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              modelBottomsheet();
            }),
        body: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: watchmen?.length ?? 0,
                itemBuilder: (context, index) {
                  Watchmen watchmenList = watchmen![index];
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      height: 75,
                      decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Are you sure you want to delete",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("cancel")),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                  onTap: () async {
                                                    final societyId = loginModel
                                                        ?.user!.societyId;
                                                    ApiRepository
                                                        apiRepository =
                                                        ApiRepository();

                                                    await apiRepository
                                                        .deleteWatchman(
                                                            watchmen[index]
                                                                .userId
                                                                .toString());
                                                    context
                                                        .read<MembersBloc>()
                                                        .add(GetMemberListEvent(
                                                            soceityId: societyId
                                                                .toString()));
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Delete"))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        child: ListTile(
                          trailing: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          leading: const CircleAvatar(
                            foregroundImage:
                                AssetImage("lib/assets/watchman.jpg"),
                            radius: 30,
                          ),
                          title: Text(watchmenList.uname ?? "No Name"),
                          subtitle:
                              Text(watchmenList.uphone ?? "Not Available"),
                        ),
                      ));
                }),
          ],
        ),
      ),
    );
  }

  modelBottomsheet() {
    final formKey = GlobalKey<FormState>();
    String? validateEmail(String? email) {
      RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
      final isEmailValid = emailRegEx.hasMatch(email ?? "");
      if (!isEmailValid) return "please  Enter a valid email";
      return null;
    }

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController mobileNoController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBoxH10(context),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                      child: Text(
                        "Name",
                        style: TextStyle(),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (nameController.text.isEmpty &&
                                    nameController.text.length < 2) {
                                  return "Enter name";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Enter name",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          )),
                    ),
                    sizedBoxH10(context),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                      child: Text(
                        "Email",
                        style: TextStyle(),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: TextFormField(
                              controller: emailController,
                              validator: validateEmail,
                              decoration: const InputDecoration(
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          )),
                    ),
                    sizedBoxH10(context),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                      child: Text(
                        "Mobile No.",
                        style: TextStyle(),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: TextFormField(
                              controller: mobileNoController,
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.length < 10) {
                                  return "Mobile no should be 10 in digits";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  counterText: "",
                                  hintText: "Enter mobile no",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          )),
                    ),
                    sizedBoxH10(context),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                      child: Text(
                        "password",
                        style: TextStyle(),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (passwordController.text.isEmpty &&
                                    passwordController.text.length < 2) {
                                  return "Enter password";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Enter password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          )),
                    ),
                    sizedBoxH10(context),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                      child: Text(
                        "confirm password",
                        style: TextStyle(),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: TextFormField(
                              controller: confirmPasswordController,
                              validator: (value) {
                                if (confirmPasswordController.text.isEmpty &&
                                    confirmPasswordController.text.length < 2) {
                                  return " Enter password";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Enter confirm password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate() &&
                                passwordController.text ==
                                    confirmPasswordController.text) {
                              ApiRepository apiRepository = ApiRepository();

                              WatchManAddModel? watchmanData =
                                  await apiRepository.addWatchman(
                                      loginModel!.user!.societyId.toString(),
                                      nameController.text,
                                      emailController.text,
                                      mobileNoController.text,
                                      passwordController.text);
                              final societyId = loginModel?.user!.societyId;
                              context.read<MembersBloc>().add(
                                  GetMemberListEvent(
                                      soceityId: societyId.toString()));
                              Fluttertoast.showToast(
                                  msg: watchmanData!.message.toString());
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "password should be same");
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.30,
                            decoration:
                                const BoxDecoration(color: Colors.green),
                            child: const Center(
                                child: Text(
                              "Add Watchman",
                              style: TextStyle(),
                            )),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
