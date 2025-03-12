import 'package:flutter/material.dart';
import 'package:my_society/constents/sizedbox.dart';

class VisitorsPage extends StatefulWidget {
  const VisitorsPage({super.key});

  @override
  State<VisitorsPage> createState() => _VisitorsPageState();
}

class _VisitorsPageState extends State<VisitorsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text(
            "Visitors",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 10,
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8),
            //   child: Container(
            //     height: 100,
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //         color: Colors.deepPurpleAccent,
            //         borderRadius: BorderRadius.circular(20)),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         const Text(
            //           "Admin",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 12),
            //         ),
            //         Container(
            //             padding: const EdgeInsets.symmetric(horizontal: 5),
            //             height: 75,
            //             decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(20)),
            //             child: const ListTile(
            //               leading: CircleAvatar(
            //                 foregroundImage:
            //                     AssetImage("lib/assets/girlphoto2.jpg"),
            //                 radius: 30,
            //               ),
            //               title: Text("Salini Madam"),
            //               subtitle: Text("ootechnical@kaamwalibais.com"),
            //             )),
            //       ],
            //     ),
            //   ),
            // ),
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
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                //height: 75,
                decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 65,
                      child: ListTile(
                        leading: CircleAvatar(
                          foregroundImage:
                              AssetImage("lib/assets/girlphoto2.jpg"),
                          radius: 30,
                        ),
                        title: Text("Rahul Sharma"),
                        subtitle: Text("9876543220"),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Friend",
                            style:
                                TextStyle(fontSize: 12, color: Colors.blueGrey),
                          ),
                          sizedBoxW5(context),
                          const Icon(
                            Icons.circle,
                            size: 6,
                            color: Colors.blueGrey,
                          ),
                          sizedBoxW5(context),
                          const Text(
                            "Casual Visit",
                            style:
                                TextStyle(fontSize: 12, color: Colors.blueGrey),
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
                          const Text(
                            "2025-03-12",
                            style:
                                TextStyle(fontSize: 12, color: Colors.blueGrey),
                          ),
                        ]),
                    sizedBoxH5(context)
                  ],
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
