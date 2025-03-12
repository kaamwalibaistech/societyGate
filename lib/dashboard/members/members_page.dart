import 'package:flutter/material.dart';
import 'package:my_society/constents/sizedbox.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
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
                        child: const ListTile(
                          leading: CircleAvatar(
                            foregroundImage:
                                AssetImage("lib/assets/girlphoto2.jpg"),
                            radius: 30,
                          ),
                          title: Text("Salini Madam"),
                          subtitle: Text("ootechnical@kaamwalibais.com"),
                        )),
                  ],
                ),
              ),
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
                  getMembersWidget(context),
                  getWatchmanWidget(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getMembersWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                height: 75,
                decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(20)),
                child: const ListTile(
                  leading: CircleAvatar(
                    foregroundImage: AssetImage("lib/assets/girlphoto2.jpg"),
                    radius: 30,
                  ),
                  title: Text("Salini Madam"),
                  subtitle: Text("ootechnical@kaamwalibais.com"),
                ));
          }),
    );
  }

  Widget getWatchmanWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                height: 75,
                decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(20)),
                child: const ListTile(
                  leading: CircleAvatar(
                    foregroundImage: AssetImage("lib/assets/watchman.jpg"),
                    radius: 30,
                  ),
                  title: Text("Sallu Sir"),
                  subtitle: Text("ootechnical@kaamwalibais.com"),
                ));
          }),
    );
  }
}

/*
 SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        child: ListTile(
                          title: Text("data"),
                        ),
                      );
                    }),
              ),

*/
