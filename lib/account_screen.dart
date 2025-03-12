import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 30,
                        itemBuilder: (context, index) =>
                            Text(index.toString())),
                    SingleChildScrollView(
                      child: Column(
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
                          const ListTile(
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
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
