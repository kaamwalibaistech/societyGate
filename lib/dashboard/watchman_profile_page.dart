import 'package:flutter/material.dart';
import 'package:my_society/constents/sizedbox.dart';

import '../constents/local_storage.dart';

class WatchmanProfilePage extends StatefulWidget {
  const WatchmanProfilePage({super.key});

  @override
  State<WatchmanProfilePage> createState() => _WatchmanProfilePageState();
}

class _WatchmanProfilePageState extends State<WatchmanProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  // margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.amber),
                      color: Colors.amber.shade50,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            color: Colors.amber.shade100)
                      ]),
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: Text("Add Manual Visitor"))),
              sizedBoxH20(context),
              const Divider(
                indent: 15,
                endIndent: 15,
              ),
              Container(
                // height: MediaQuery.of(context).size.height * 0.50,
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(
                        Icons.privacy_tip_outlined,
                        //   color: Colors.black,
                      ),
                      title: Text(
                        "privacy",
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                        // color: Colors.black,
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        Icons.handshake_outlined,
                        //  color: Colors.black,
                      ),
                      title: Text(
                        "terms & conditions",
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                        // color: Colors.black,
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        Icons.help_outline_outlined,
                        //   color: Colors.black,
                      ),
                      title: Text(
                        "Help & support",
                        //  style: TextStyle(color: Colors.black),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                        // color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await LocalStoragePref.instance!.clearAllPref();
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => LoginScreen()));
                      },
                      child: const ListTile(
                        leading: Icon(
                          Icons.logout_outlined,
                          //  color: Colors.black,
                        ),
                        title: Text(
                          "log out",
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                          //  color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
