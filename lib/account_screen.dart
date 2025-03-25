import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_society/api/api_repository.dart';
import 'package:my_society/auth/login_screen.dart';
import 'package:my_society/constents/sizedbox.dart';
import 'package:my_society/models/get_family_members_model.dart';

import 'constents/local_storage.dart';
import 'models/add_daily_help_model.dart';
import 'models/add_family_member_model.dart';
import 'models/add_vehicle_model.dart';
import 'models/get_daily_help_model.dart';
import 'models/get_vehicle_detail_model.dart';
import 'privacy_policy_screen.dart';
import 'profile_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  GetFamilyMemberModel? getFamilyMemberData;
  GetDailyHelpModel? getDailyHelpData;
  GetVehicleDetailsModel? getVehicledetails;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getfamilymembers();
    getDailyHelpmembers();
    getVehicleData();
  }

  getfamilymembers() async {
    ApiRepository apiRepository = ApiRepository();
    final data = LocalStoragePref.instance!.getLoginModel();
    final getFamilyMember =
        await apiRepository.getFamilyMembers(data!.user!.flatId.toString());
    setState(() {
      getFamilyMemberData = getFamilyMember;
    });
  }

  getVehicleData() async {
    ApiRepository apiRepository = ApiRepository();
    final data = LocalStoragePref.instance!.getLoginModel();
    var getVehicleData =
        await apiRepository.getVehicleDetails(data!.user!.flatId.toString());
    setState(() {
      getVehicledetails = getVehicleData;
    });
  }

  getDailyHelpmembers() async {
    ApiRepository apiRepository = ApiRepository();
    final data = LocalStoragePref.instance!.getLoginModel();
    final getDailyHelpMember = await apiRepository.getDailyHelpMembers(
        data!.user!.societyId.toString(), data.user!.flatId.toString());

    setState(() {
      getDailyHelpData = getDailyHelpMember;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginModel = LocalStoragePref().getLoginModel();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 237, 237),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Theme.of(context).primaryColor),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 200, 197, 197),
                      spreadRadius: 1,
                      blurRadius: 20,
                      // offset: Offset(0, 0), // changes position of shadow
                    ),
                  ]),
                  child: const Center(
                    child: Text(
                      "Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).primaryColor,
                              ),
                              height: 50,
                              width: 50,
                            ),
                            title: Text(loginModel!.user?.uname ?? "---"),
                            subtitle: Text(
                              loginModel.user?.uemail ?? "---",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.house_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(
                            loginModel.user?.societyName ?? "---",
                            style: const TextStyle(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.white,
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          text: "Household",
                        ),
                        Tab(
                          text: "Settings",
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: TabBarView(controller: _tabController, children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              trailing: GestureDetector(
                                onTap: () {
                                  familyMemberModelBottomSheet();
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.19,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).primaryColor),
                                  child: const Center(
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                              subtitle: const Text(
                                "Add family  member for quick entry",
                                style: TextStyle(color: Colors.grey),
                              ),
                              title: const Text("My family"),
                            ),
                            const Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              "----------------------------------------------------------------------------------------------",
                              style: TextStyle(color: Colors.grey),
                            ),
                            sizedBoxH10(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.12,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    getFamilyMemberData?.familyMembers.length ??
                                        2,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey),
                                          color: Colors.white),
                                      // height: MediaQuery.of(context).size.height *
                                      //     0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.30,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, top: 5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  color: Colors.white),
                                              height: 30,
                                              width: 30,
                                              child: const Icon(
                                                Icons.person,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0, left: 5),
                                            child: Text(getFamilyMemberData
                                                    ?.familyMembers[index]
                                                    .uname ??
                                                ""),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              getFamilyMemberData
                                                      ?.familyMembers[index]
                                                      .relation ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Container(
                                height: 20,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 241, 237, 237)),
                              ),
                            ),
                            ListTile(
                              trailing: GestureDetector(
                                onTap: () {
                                  dailyHelpModelBottomSheet();
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.19,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).primaryColor),
                                  child: const Center(
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                              subtitle: const Text(
                                overflow: TextOverflow.ellipsis,
                                "Add maid, helper, launder for quick entry",
                                style: TextStyle(color: Colors.grey),
                              ),
                              title: const Text("Daily help"),
                            ),
                            const Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              "----------------------------------------------------------------------------------------------",
                              style: TextStyle(color: Colors.grey),
                            ),
                            sizedBoxH10(context),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    getDailyHelpData?.employees.length ?? 2,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey),
                                          color: Colors.white),
                                      // height: MediaQuery.of(context).size.height *
                                      //     0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.30,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, top: 5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  color: Colors.white),
                                              height: 30,
                                              width: 30,
                                              child: const Icon(
                                                Icons.person,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0, left: 5),
                                            child: Text(getDailyHelpData
                                                    ?.employees[index].name ??
                                                ""),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              getDailyHelpData?.employees[index]
                                                      .empType ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Container(
                                height: 20,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 241, 237, 237)),
                              ),
                            ),
                            ListTile(
                              trailing: GestureDetector(
                                onTap: () {
                                  myVehicleModelBottomSheet();
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.19,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).primaryColor),
                                  child: const Center(
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                              subtitle: const Text(
                                overflow: TextOverflow.ellipsis,
                                "Add your vehicle for quick entry",
                                style: TextStyle(color: Colors.grey),
                              ),
                              title: const Text("My vehicle"),
                            ),
                            const Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              "----------------------------------------------------------------------------------------------",
                              style: TextStyle(color: Colors.grey),
                            ),
                            sizedBoxH10(context),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: getVehicledetails?.data.length ?? 2,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey),
                                          color: Colors.white),
                                      // height: MediaQuery.of(context).size.height *
                                      //     0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.30,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, top: 5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  color: Colors.white),
                                              height: 30,
                                              width: 30,
                                              child: const Icon(
                                                Icons.car_repair_outlined,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0, left: 5),
                                            child: Text(getVehicledetails
                                                    ?.data[index].vehicleNo ??
                                                ""),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              getVehicledetails
                                                      ?.data[index].model ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(vertical: 15.0),
                            //   child: Container(
                            //     height: 20,
                            //     decoration: const BoxDecoration(
                            //         color: Color.fromARGB(255, 241, 237, 237)),
                            //   ),
                            // ),
                            // ListTile(
                            //   trailing: GestureDetector(
                            //     onTap: () {
                            //       frequentEntryModelBottomSheet();
                            //     },
                            //     child: Container(
                            //       height:
                            //           MediaQuery.of(context).size.height * 0.05,
                            //       width:
                            //           MediaQuery.of(context).size.width * 0.19,
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(5),
                            //           color: Theme.of(context).primaryColor),
                            //       child: const Center(
                            //         child: Text(
                            //           "Add",
                            //           style: TextStyle(
                            //               color: Colors.white, fontSize: 15),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            //   subtitle: const Text(
                            //     overflow: TextOverflow.ellipsis,
                            //     "Add frequent person for quick entry",
                            //     style: TextStyle(color: Colors.grey),
                            //   ),
                            //   title: const Text("Frequent entry"),
                            // ),
                            // const Text(
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 1,
                            //   "----------------------------------------------------------------------------------------------",
                            //   style: TextStyle(color: Colors.grey),
                            // ),
                            // sizedBoxH10(context),
                            // SizedBox(
                            //   height: 100,
                            //   child: ListView.builder(
                            //     shrinkWrap: true,
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: 5,
                            //     itemBuilder: (BuildContext context, int index) {
                            //       return Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 10.0),
                            //         child: Container(
                            //           decoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(5),
                            //               border:
                            //                   Border.all(color: Colors.grey),
                            //               color: Colors.white),
                            //           // height: MediaQuery.of(context).size.height *
                            //           //     0.10,
                            //           width: MediaQuery.of(context).size.width *
                            //               0.36,
                            //           child: const Center(child: Text("data")),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            sizedBoxH10(context),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            title: const Text(
                              "Edit profile",
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileScreen()));
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // const ListTile(
                          //   leading: Icon(
                          //     Icons.language,
                          //     color: Colors.black,
                          //   ),
                          //   title: Text(
                          //     "language",
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          //   trailing: Icon(
                          //     Icons.arrow_forward_ios_outlined,
                          //     size: 18,
                          //     color: Colors.black,
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivacyPolicyScreen()));
                            },
                            child: const ListTile(
                              leading: Icon(
                                Icons.privacy_tip,
                                color: Colors.black,
                              ),
                              title: Text(
                                "Privacy Policy",
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.privacy_tip_outlined,
                              color: Colors.black,
                            ),
                            title: Text(
                              "terms & conditions",
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.help,
                              color: Colors.black,
                            ),
                            title: Text(
                              "Help & support",
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await LocalStoragePref.instance!.clearAllPref();

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (Route<dynamic> route) => true,
                              );
                            },
                            child: const ListTile(
                              leading: Icon(
                                Icons.logout_outlined,
                                color: Colors.black,
                              ),
                              title: Text(
                                "log out",
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  familyMemberModelBottomSheet() {
    TextEditingController familyNameController = TextEditingController();
    TextEditingController familyMobileNoController = TextEditingController();
    TextEditingController familyEmailController = TextEditingController();
    TextEditingController familyRelationController = TextEditingController();
    TextEditingController familyPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String? validateEmail(String? email) {
      RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
      final isEmailValid = emailRegEx.hasMatch(email ?? "");
      if (!isEmailValid) return "please  Enter a valid email";
      return null;
    }

    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: const BoxDecoration(),
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Center(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(Icons.camera_alt_outlined),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(child: Text("My family")),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Center(
                            child: Text(
                              "Add family members for quick entry",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Name",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                controller: familyNameController,
                                validator: (value) {
                                  if (familyNameController.text.isEmpty &&
                                      familyNameController.text.length < 2) {
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
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10),
                          child: Text(
                            "Mobile number",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                controller: familyMobileNoController,
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
                                    hintText: "Enter mobile number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10),
                          child: Text(
                            "Email",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                controller: familyEmailController,
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
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10),
                          child: Text(
                            "Realtion",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                controller: familyRelationController,
                                validator: (value) {
                                  if (familyRelationController.text.isEmpty) {
                                    return "Enter your relation";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Enter relation",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10),
                          child: Text(
                            "Password",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                controller: familyPasswordController,
                                validator: (value) {
                                  if (familyPasswordController.text.length <
                                      6) {
                                    return "Enter Password";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Enter Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: GestureDetector(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                final data =
                                    LocalStoragePref.instance!.getLoginModel();
                                ApiRepository apiRepository = ApiRepository();
                                AddFamilyMemberModel? familyMemberData =
                                    await apiRepository.addFamilyMembers(
                                        data!.user!.societyId.toString(),
                                        data.user!.flatId.toString(),
                                        data.user!.userId.toString(),
                                        familyNameController.text,
                                        familyEmailController.text,
                                        familyMobileNoController.text,
                                        familyRelationController.text,
                                        familyPasswordController.text);
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: "Family Member Added Successfully");
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).primaryColor),
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width,
                              child: const Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  dailyHelpModelBottomSheet() {
    TextEditingController dailyHelpNameController = TextEditingController();
    TextEditingController dailyHelpMobileNoController = TextEditingController();
    TextEditingController dailyHelpAddressController = TextEditingController();
    TextEditingController dailyHelpTypeController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool checkBoxValue = true;

    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: const BoxDecoration(),
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Center(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(Icons.camera_alt_outlined),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(child: Text("Add daily help")),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Center(
                            child: Text(
                              "Add daily help for quick entry",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Name",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Name";
                                  }
                                  return null;
                                },
                                controller: dailyHelpNameController,
                                decoration: const InputDecoration(
                                    hintText: "Enter name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10),
                          child: Text(
                            "Mobile number",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                maxLength: 10,
                                validator: (value) {
                                  if (value!.length < 10) {
                                    return "mobile number should be 10 in digits";
                                  }
                                  return null;
                                },
                                controller: dailyHelpMobileNoController,
                                decoration: const InputDecoration(
                                    counterText: "",
                                    hintText: "Enter mobile number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10),
                          child: Text(
                            "Address",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Address";
                                  }
                                  return null;
                                },
                                controller: dailyHelpAddressController,
                                decoration: const InputDecoration(
                                    hintText: "Enter Address",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10),
                          child: Text(
                            "Help type",
                            style: TextStyle(),
                          ),
                        ),
                        // Checkbox(
                        //     value: checkBoxValue,
                        //     onChanged: (newValue) {
                        //       setState(() {
                        //         newValue = checkBoxValue;
                        //       });
                        //     }),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter service type";
                                  }
                                  return null;
                                },
                                controller: dailyHelpTypeController,
                                decoration: const InputDecoration(
                                    hintText: "Select service",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: GestureDetector(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                final data =
                                    LocalStoragePref.instance!.getLoginModel();
                                ApiRepository apiRepository = ApiRepository();
                                AddDailyHelpModel? dailyHelpData =
                                    await apiRepository.addDailyHelpMembers(
                                  data!.user!.societyId.toString(),
                                  data.user!.userId.toString(),
                                  data.user!.flatId.toString(),
                                  dailyHelpNameController.text,
                                  dailyHelpMobileNoController.text,
                                  dailyHelpAddressController.text,
                                  dailyHelpTypeController.text,
                                );
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: dailyHelpData!.message.toString());
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).primaryColor),
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width,
                              child: const Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  myVehicleModelBottomSheet() {
    TextEditingController vehicleNumberController = TextEditingController();
    TextEditingController vehicleTypeController = TextEditingController();
    TextEditingController vehicleModelController = TextEditingController();
    TextEditingController vehicleParkingSlotController =
        TextEditingController();

    final globalKey = GlobalKey<FormState>();

    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: const BoxDecoration(),
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Center(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(Icons.camera_alt_outlined),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(child: Text("Add vehicle image")),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Center(
                            child: Text(
                              "Add your vehicle for quick entry",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "vehicle number",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                controller: vehicleNumberController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Vehicle Number";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Enter vehicle number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10),
                          child: Text(
                            "Add vehicle type",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                controller: vehicleTypeController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Vechile type";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "E.g car / Bike",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10),
                          child: Text(
                            "vehicle model",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                controller: vehicleModelController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please Enter Vehicle model";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Enter Vehicle company",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10),
                          child: Text(
                            "parking Slot",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                controller: vehicleParkingSlotController,
                                decoration: const InputDecoration(
                                    hintText: "Enter parking slot",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: GestureDetector(
                            onTap: () async {
                              if (globalKey.currentState!.validate()) {
                                final data =
                                    LocalStoragePref.instance!.getLoginModel();
                                ApiRepository apiRepository = ApiRepository();
                                AddVehicleModel? addVehicleData =
                                    await apiRepository.addVehicle(
                                  data!.user!.societyId.toString(),
                                  data.user!.userId.toString(),
                                  data.user!.flatId.toString(),
                                  vehicleNumberController.text,
                                  vehicleTypeController.text,
                                  vehicleModelController.text,
                                  vehicleParkingSlotController.text,
                                );
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: addVehicleData!.message.toString());
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).primaryColor),
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width,
                              child: const Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  // frequentEntryModelBottomSheet() {
  //   TextEditingController frequentNameController = TextEditingController();
  //   TextEditingController frequentMobileNoController = TextEditingController();
  //   TextEditingController frequentRelationController = TextEditingController();

  //   return showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //             decoration: const BoxDecoration(),
  //             height: MediaQuery.of(context).size.height * 0.60,
  //             width: MediaQuery.of(context).size.width,
  //             child: SingleChildScrollView(
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                         padding: const EdgeInsets.only(top: 15.0),
  //                         child: Center(
  //                           child: Container(
  //                             height: 80,
  //                             width: 80,
  //                             decoration: BoxDecoration(
  //                                 border: Border.all(color: Colors.grey),
  //                                 color: Colors.white,
  //                                 borderRadius: BorderRadius.circular(5)),
  //                             child: const Icon(Icons.camera_alt_outlined),
  //                           ),
  //                         )),
  //                     const Padding(
  //                       padding: EdgeInsets.only(top: 10.0),
  //                       child: Center(child: Text("Add frequent person")),
  //                     ),
  //                     const Padding(
  //                       padding: EdgeInsets.only(top: 5.0),
  //                       child: Center(
  //                         child: Text(
  //                           "Add frequent person for quick entry",
  //                           style: TextStyle(color: Colors.grey),
  //                         ),
  //                       ),
  //                     ),
  //                     const Padding(
  //                       padding: EdgeInsets.symmetric(vertical: 10.0),
  //                       child: Text(
  //                         "name",
  //                         style: TextStyle(),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                         width: MediaQuery.of(context).size.width * 0.90,
  //                         height: MediaQuery.of(context).size.height * 0.06,
  //                         child: Center(
  //                           child: TextFormField(
  //                             decoration: const InputDecoration(
  //                                 hintText: "Enter name",
  //                                 hintStyle: TextStyle(color: Colors.grey),
  //                                 fillColor: Colors.white,
  //                                 filled: true,
  //                                 border: OutlineInputBorder(
  //                                     borderSide: BorderSide.none)),
  //                           ),
  //                         )),
  //                     const Padding(
  //                       padding: EdgeInsets.only(top: 15.0, bottom: 10),
  //                       child: Text(
  //                         "mobile number",
  //                         style: TextStyle(),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                         width: MediaQuery.of(context).size.width * 0.90,
  //                         height: MediaQuery.of(context).size.height * 0.06,
  //                         child: Center(
  //                           child: TextFormField(
  //                             decoration: const InputDecoration(
  //                                 hintText: "Enter mobile number",
  //                                 hintStyle: TextStyle(color: Colors.grey),
  //                                 fillColor: Colors.white,
  //                                 filled: true,
  //                                 border: OutlineInputBorder(
  //                                     borderSide: BorderSide.none)),
  //                           ),
  //                         )),
  //                     const Padding(
  //                       padding: EdgeInsets.only(top: 15.0, bottom: 10),
  //                       child: Text(
  //                         "Relation",
  //                         style: TextStyle(),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                         width: MediaQuery.of(context).size.width * 0.90,
  //                         height: MediaQuery.of(context).size.height * 0.06,
  //                         child: Center(
  //                           child: TextFormField(
  //                             decoration: const InputDecoration(
  //                                 hintText: "Enter relation",
  //                                 hintStyle: TextStyle(color: Colors.grey),
  //                                 fillColor: Colors.white,
  //                                 filled: true,
  //                                 border: OutlineInputBorder(
  //                                     borderSide: BorderSide.none)),
  //                           ),
  //                         )),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 20.0),
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(5),
  //                             color: Theme.of(context).primaryColor),
  //                         height: MediaQuery.of(context).size.height * 0.06,
  //                         width: MediaQuery.of(context).size.width,
  //                         child: const Center(
  //                           child: Text(
  //                             "Submit",
  //                             style:
  //                                 TextStyle(color: Colors.white, fontSize: 16),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ));
  //       });
  // }
}
