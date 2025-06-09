import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/models/announcements_model.dart';

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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  LoginModel? loginModel;
  WatchManAddModel? watchmanData;
  Announcementmodel? data;
  String? adminName;
  String? adminEmail;
  // LoginModel? loginModel;
  String? loginType;
  @override
  void initState() {
    super.initState();
    getUserData();
    getData();
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

  getData() async {
    final getLoginModel = LocalStoragePref().getLoginModel();

    ApiRepository apiRepositiory = ApiRepository();
    Announcementmodel? mydata = await apiRepositiory
        .getHomePageData(getLoginModel!.user!.societyId.toString());
    setState(() {
      loginModel = getLoginModel;
      data = mydata;
      loginType = loginModel?.user?.role ?? "NA";
      // uiPhoto = loginModel?.user?.uname ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF6B4EFF)),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Members",
            style: TextStyle(
              color: Color(0xFF1A1A1A),
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(160),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        // padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF6B4EFF),
                            width: 1.5,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            "https://ui-avatars.com/api/?background=random&name=$adminName.",
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              adminName ?? "No Admin",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              adminEmail ?? "Not Available",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: const Color(0xFF6B4EFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color(0xFF6B4EFF),
                      indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: -20, vertical: 5),
                      tabs: const [
                        Tab(text: "Members"),
                        Tab(text: "Watchman"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget getUi(
    MemberlistModel? memberlistModel,
  ) {
    if (memberlistModel?.users?.admins?.isNotEmpty ?? false) {
      adminName = memberlistModel!.users!.admins!.first.uname;
      adminEmail = memberlistModel.users!.admins!.first.uemail;
    }

    return Column(
      children: [
        // Admin Card

        // Tab Content
        Expanded(
          child: TabBarView(
            children: [
              // Members Tab
              (memberlistModel?.users?.members?.isNotEmpty ?? false)
                  ? getMembersWidget(context, memberlistModel?.users!.members)
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.group_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No Members Available",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

              // Watchman Tab
              (memberlistModel?.users?.watchmen?.isNotEmpty ?? false)
                  ? getWatchmanWidget(
                      context,
                      memberlistModel?.users!.watchmen,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.security_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No watchman available",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 32),
                        if (loginModel?.user!.role == "admin")
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ElevatedButton.icon(
                              onPressed: () => modelBottomsheet(),
                              icon: const Icon(Icons.add),
                              label: const Text("Add Watchman"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6B4EFF),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildError(String msg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            msg,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
                  leading: ClipOval(
                    child: Image.network(
                      "https://ui-avatars.com/api/?background=random&name=${memberList.uname}.",
                      height: 50,
                      width: 50,
                    ),
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
        floatingActionButton: loginType == "admin"
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  modelBottomsheet();
                })
            : const SizedBox.shrink(),
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
                      child: ListTile(
                        trailing: loginType == "admin"
                            ? GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const Text(
                                                    "Are you sure you want to delete",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "cancel")),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () async {
                                                            final societyId =
                                                                loginModel
                                                                    ?.user!
                                                                    .societyId;
                                                            ApiRepository
                                                                apiRepository =
                                                                ApiRepository();

// <<<<<<< anil
//                                                     await apiRepository
//                                                         .deleteWatchman(
//                                                             watchmen[index]
//                                                                 .userId
//                                                                 .toString());
//                                                     context
//                                                         .read<MembersBloc>()
//                                                         .add(GetMemberListEvent(
//                                                             soceityId: societyId
//                                                                 .toString()));
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: const Text("Delete"))
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ));
//                         },
//                         child: ListTile(
//                           trailing: const Icon(
//                             Icons.delete,
//                             color: Colors.red,
//                           ),
//                           leading:
//                               // ClipOval(
//                               //   child: Image.network(
//                               //     "https://ui-avatars.com/api/?background=random&name=${watchmenList.uname}.",
//                               //     height: 50,
//                               //     width: 50,
//                               //   ),
//                               // ),
//                               const CircleAvatar(
//                             foregroundImage:
//                                 AssetImage("lib/assets/watchman.jpg"),
//                             radius: 30,
//                           ),
//                           title: Text(watchmenList.uname ?? "No Name"),
//                           subtitle:
//                               Text(watchmenList.uphone ?? "Not Available"),
// =======
                                                            await apiRepository
                                                                .deleteWatchman(
                                                                    watchmen[
                                                                            index]
                                                                        .userId
                                                                        .toString());
                                                            context
                                                                .read<
                                                                    MembersBloc>()
                                                                .add(GetMemberListEvent(
                                                                    soceityId:
                                                                        societyId
                                                                            .toString()));
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Delete"))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            : const SizedBox.shrink(),
                        leading: const CircleAvatar(
                          foregroundImage:
                              AssetImage("lib/assets/watchman.jpg"),
                          radius: 30,
// >>>>>>> final
                        ),
                        title: Text(watchmenList.uname ?? "No Name"),
                        subtitle: Text(watchmenList.uphone ?? "Not Available"),
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
