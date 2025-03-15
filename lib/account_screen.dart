import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_society/constents/sizedbox.dart';

import 'constents/local_storage.dart';
import 'profile_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                            title: const Text("Ritesh Dixit"),
                            subtitle: const Text(
                              "ritesh.dixit2002@gmail.com",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.house_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: const Text(
                            "F-101 Shubham Complex",
                            style: TextStyle(fontSize: 14),
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
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
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
                                          0.36,
                                      child: const Center(child: Text("data")),
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
                                itemCount: 5,
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
                                          0.36,
                                      child: const Center(child: Text("data")),
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
                                itemCount: 5,
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
                                          0.36,
                                      child: const Center(child: Text("data")),
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
                                  frequentEntryModelBottomSheet();
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
                                "Add frequent person for quick entry",
                                style: TextStyle(color: Colors.grey),
                              ),
                              title: const Text("Frequent entry"),
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
                                itemCount: 5,
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
                                          0.36,
                                      child: const Center(child: Text("data")),
                                    ),
                                  );
                                },
                              ),
                            ),
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
                          const ListTile(
                            leading: Icon(
                              Icons.language,
                              color: Colors.black,
                            ),
                            title: Text(
                              "language",
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
                              Icons.privacy_tip,
                              color: Colors.black,
                            ),
                            title: Text(
                              "privacy",
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
                          ListTile(
                            leading: const Icon(
                              Icons.logout_outlined,
                              color: Colors.black,
                            ),
                            title: const Text(
                              "log out",
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: GestureDetector(
                              onTap: () async {
                                await LocalStoragePref.instance!.clearAllPref();
                              },
                              child: const Icon(
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
    TextEditingController familyRelationController = TextEditingController();
    final formKey = GlobalKey<FormState>();

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
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (familyMobileNoController.text.length !=
                                      10) {
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
                            "Realtion",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: TextFormField(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {}
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
                              decoration: const InputDecoration(
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
                          "Help type",
                          style: TextStyle(),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: TextFormField(
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
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).primaryColor),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text(
                              "Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  myVehicleModelBottomSheet() {
    TextEditingController vehicleNumberController = TextEditingController();
    TextEditingController vehicleModelController = TextEditingController();
    TextEditingController vehicleTypeController = TextEditingController();

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
                          "vehicle model",
                          style: TextStyle(),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  hintText: "Enter vehicle model",
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
                              decoration: const InputDecoration(
                                  hintText: "Enter vehicle type",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).primaryColor),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text(
                              "Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  frequentEntryModelBottomSheet() {
    TextEditingController frequentNameController = TextEditingController();
    TextEditingController frequentMobileNoController = TextEditingController();
    TextEditingController frequentRelationController = TextEditingController();

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
                        child: Center(child: Text("Add frequent person")),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Center(
                          child: Text(
                            "Add frequent person for quick entry",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "name",
                          style: TextStyle(),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: TextFormField(
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
                          "mobile number",
                          style: TextStyle(),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: TextFormField(
                              decoration: const InputDecoration(
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
                          "Relation",
                          style: TextStyle(),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  hintText: "Enter relation",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).primaryColor),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text(
                              "Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
