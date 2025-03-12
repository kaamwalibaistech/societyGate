import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:my_society/dashboard/members/members_page.dart';
import 'package:my_society/dashboard/visitors/visitors_page.dart';


import 'api/api_repository.dart';
import 'models/homepage_model.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  Homepagemodel? data;
  @override
  initState() {
    getData();
  }

  getData() async {
    ApiRepository apiRepositiory = ApiRepository();
    Homepagemodel? mydata = await apiRepositiory.getHomePageData();
    setState(() {
      data = mydata;
    });
  }

  List<String> title = [
    "Members",
    "Visitors",
    "Notice Board",
    "Payment",
    "Book amenities",
    "Help desk"
  ];
  List<String> subtitle = [
    "connect society member",
    "manage visitors entry",
    "society announcement & event notice",
    "direct payment of society due",
    "pre book society amenities",
    "complaint & suggestion"
  ];
  List<String> communityList = [
    'lib/assets/members.png',
    'lib/assets/visitors.png',
    'lib/assets/mood-board.png',
    'lib/assets/payment.png',
    'lib/assets/ameneties.png',
    'lib/assets/help_desk.png',
  ];

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 52, 84),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24),
              decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12)),
              height: MediaQuery.of(context).size.height * 0.38,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                        foregroundImage: AssetImage("lib/assets/man.png"),
                        radius: 30,
                      ),
                      title: const Text("Hi Ritesh Dixit"),
                      subtitle: const Text("F-101 | Shubham Complex"),
                      trailing: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.red)),
                        child: const Icon(
                          Icons.notifications_active,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      child: CarouselSlider(
                          items: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(255, 19, 52, 84),
                                  ),
                                  child: Center(
                                    child: Text(
                                      data!.data.announcements[0].description,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(255, 19, 52, 84),
                                  ),
                                  child: Center(
                                    child: Text(
                                      data!.data.announcements[0].description,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(255, 19, 52, 84),
                                  ),
                                  child: Center(
                                    child: Text(
                                      data!.data.announcements[0].description,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
                          ],
                          options: CarouselOptions(
                            autoPlay: true,
                            initialPage: 0,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            aspectRatio: 16 / 9,
                            enlargeCenterPage: true,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0, top: 20),
                    child: Text(
                      "Community",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.red.shade900),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 560,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      // mainAxisSpacing: 10,
                      // crossAxisSpacing: 20,
                      mainAxisExtent: 170,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MembersPage()));
                            break;
                          case 1:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VisitorsPage()));
                            break;
                          case 2:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MembersPage()));
                            break;
                          case 3:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MembersPage()));
                            break;
                          case 4:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MembersPage()));
                            break;
                          case 5:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MembersPage()));
                            break;
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 18),
                        child: Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 10,
                                  ),
                                  child: Text(
                                    title[index],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 2, right: 8),
                                  child: Text(
                                    subtitle[index],
                                    style:
                                        const TextStyle(color: Colors.blueGrey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 12,
                            child: Image.asset(
                              communityList[index],
                              // scale: 35,
                            ),
                          )
                        ]),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
