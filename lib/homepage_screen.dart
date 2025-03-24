import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/dashboard/members/members_page.dart';
import 'package:my_society/dashboard/visitors/visitors_page.dart';
import 'package:my_society/models/login_model.dart';
import 'package:my_society/scanner_page.dart';

import 'api/api_repository.dart';
import 'constents/sizedbox.dart';
import 'dashboard/notice_board/notice_board_screen.dart';
import 'models/homepage_model.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  Homepagemodel? data;
  LoginModel? loginModel;
  String? loginType;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final getLoginModel = LocalStoragePref().getLoginModel();

    ApiRepository apiRepositiory = ApiRepository();
    Homepagemodel? mydata = await apiRepositiory.getHomePageData();
    setState(() {
      loginModel = getLoginModel;
      data = mydata;
      loginType = loginModel?.user?.role ?? "NA";
      log(loginType ?? "No data");
      log(loginModel?.user?.role ?? "NA");
    });
  }

  List<String> title = [
    "Members",
    "Visitors",
    "Notice Board",
    "Payment",
    "Book amenities",
    "Shop"
  ];
  List<String> subtitle = [
    "connect society member",
    "manage visitors entry",
    "society announcement & event notice",
    "direct payment of society due",
    "pre book society amenities",
    "Order What you desire!"
  ];
  List<String> communityList = [
    'lib/assets/members.png',
    'lib/assets/visitors.png',
    'lib/assets/mood-board.png',
    'lib/assets/payment.png',
    'lib/assets/ameneties.png',
    'lib/assets/store.png',
  ];

  @override
  build(BuildContext context) {
    List<int> visibleIndices = List.generate(6, (index) => index);
    if (loginType == "watchman") {
      visibleIndices.removeWhere((index) => index == 3 || index == 4);
    }
    return Scaffold(
      backgroundColor: loginType == "watchman"
          ? const Color(0xffFE8A00)
          : const Color.fromARGB(255, 19, 52, 84),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12)),
                height: MediaQuery.of(context).size.height * 0.38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 6),
                      child: ListTile(
                        leading: CircleAvatar(
                          foregroundImage: loginType == "watchman"
                              ? const AssetImage('lib/assets/watchman.jpg')
                              : const AssetImage("lib/assets/man.png"),
                          radius: 30,
                        ),
                        title: Text(loginModel?.user?.uname ?? "NA"),
                        subtitle: Text(loginModel?.user?.societyName ?? "NA"),
                        // : const Text(""),
                        trailing: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.black45)),
                          child: const Icon(
                            Icons.notifications_active,
                            color: Colors.black54,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: loginType != "watchman",
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.19,
                            width: MediaQuery.of(context).size.width,
                            child: CarouselSlider.builder(
                                itemCount: 3,
                                itemBuilder: (context, index, realIndex) {
                                  return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              255, 19, 52, 84),
                                        ),
                                        child: Center(
                                          child: Stack(children: [
                                            Image.asset(
                                                fit: BoxFit.fitWidth,
                                                width: 330,
                                                "lib/assets/notice_board.png.png"),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    data
                                                            ?.data
                                                            .announcements[
                                                                index]
                                                            .title ??
                                                        "",
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                sizedBoxH5(context),
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25.0),
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      data
                                                              ?.data
                                                              .announcements[
                                                                  index]
                                                              .description ??
                                                          "",
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                sizedBoxH5(context),
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25.0),
                                                    child: Text(
                                                      "Announcement Type : ${data?.data.announcements[index].announcementType ?? ""}",
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                        ),
                                      ));
                                },

                                /*      SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            const Color.fromARGB(255, 19, 52, 84),
                                      ),
                                      child: Center(
                                        child: Stack(children: [
                                          Image.asset(
                                              fit: BoxFit.fitWidth,
                                              width: 330,
                                              "lib/assets/notice_board.png.png"),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              sizedBoxH5(context),
                                              Center(
                                                child: Text(
                                                  data!.data.announcements[0].title,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              sizedBoxH5(context),
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 25.0),
                                                  child: Text(
                                                    data!.data.announcements[0]
                                                        .description,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 25.0),
                                                  child: Text("Announcement Type : ${
                                                    data!.data.announcements[0]
                                                        .announcementType}",
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              sizedBoxH5(context)
                                            ],
                                          )
                                        ]),
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
                                    )),*/

                                options: CarouselOptions(
                                  autoPlay: true,
                                  initialPage: 0,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  aspectRatio: 16 / 9,
                                  enlargeCenterPage: true,
                                )),
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
                    Visibility(
                      visible: loginType == "watchman",
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ScannerPage()));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 14),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              border:
                                  Border.all(width: 0.5, color: Colors.white54),
                              borderRadius: BorderRadius.circular(10)),
                          child: Lottie.asset(
                            "lib/assets/lottie_json/scan.json",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              sizedBoxH20(context),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: visibleIndices.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 180,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int i) {
                  int index =
                      visibleIndices[i]; // actual index from original list

                  return GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MembersPage()));
                          break;
                        case 1:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VisitorsPage()));
                          break;
                        case 2:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NoticeBoardScreen(data: data)));
                          break;
                        case 3:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MembersPage()));
                          break;
                        case 4:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MembersPage()));
                          break;
                        case 5:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MembersPage()));
                          break;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 18),
                      child: Stack(
                        children: [
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                color: loginType == "watchman"
                                    ? Colors.white
                                    : Colors.green.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10),
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
                                      style: const TextStyle(
                                          color: Colors.blueGrey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 12,
                            child: Image.asset(communityList[index]),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
