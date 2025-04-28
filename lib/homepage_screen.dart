import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'api/api_repository.dart';
import 'book_amenities.dart';
import 'constents/local_storage.dart';
import 'dashboard/members/members_page.dart';
import 'dashboard/notice_board/notice_board_screen.dart';
import 'dashboard/visitors/visitors_page.dart';
import 'models/homepage_model.dart';
import 'models/login_model.dart';
import 'payment_screen.dart';
import 'scanner_page.dart';
import 'shops/dailyneeds_tab.dart';

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
    Homepagemodel? mydata = await apiRepositiory
        .getHomePageData(getLoginModel!.user!.societyId.toString());
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
  Widget build(BuildContext context) {
    List<int> visibleIndices = List.generate(6, (index) => index);
    if (loginType == "watchman") {
      visibleIndices.removeWhere((index) => index == 3 || index == 4);
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              loginType == "watchman"
                  ? const Color(0xFFFFF5E6)
                  : const Color(0xFFF8F9FF),
              loginType == "watchman"
                  ? const Color(0xFFFFE5CC)
                  : const Color(0xFFEEF1FF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // Profile Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: loginType == "watchman"
                                ? const Color(0xFFFF9933)
                                : const Color(0xFF6B4EFF),
                            width: 1.5,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          foregroundImage: loginType == "watchman"
                              ? const AssetImage('lib/assets/watchman.jpg')
                              : const AssetImage("lib/assets/man.png"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loginModel?.user?.uname ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              loginModel?.user?.societyName ?? "",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: loginType == "watchman"
                              ? const Color(0xFFFF9933)
                              : const Color(0xFF6B4EFF),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Stats Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Action Required",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green[400],
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "All tasks completed",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6B4EFF).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF6B4EFF),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Announcements Section (if not watchman)
                if (loginType != "watchman") ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: CarouselSlider.builder(
                      itemCount: (data?.data.announcements.isNotEmpty ?? false)
                          ? data!.data.announcements.length
                          : 1,
                      itemBuilder: (context, index, realIndex) {
                        bool hasAnnouncements =
                            data?.data.announcements.isNotEmpty ?? false;
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF6B4EFF).withOpacity(0.04),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.campaign_rounded,
                                      color: hasAnnouncements
                                          ? _getAnnouncementColor(data!
                                              .data
                                              .announcements[index]
                                              .announcementType)
                                          : const Color(0xFF6B4EFF),
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      hasAnnouncements
                                          ? data!.data.announcements[index]
                                              .announcementType
                                          : "Notice",
                                      style: TextStyle(
                                        color: hasAnnouncements
                                            ? _getAnnouncementColor(data!
                                                .data
                                                .announcements[index]
                                                .announcementType)
                                            : const Color(0xFF6B4EFF),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time,
                                            color: Color(0xFF6B4EFF),
                                            size: 12,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "New",
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hasAnnouncements
                                            ? data!
                                                .data.announcements[index].title
                                            : "No Notices",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      if (hasAnnouncements)
                                        Expanded(
                                          child: Text(
                                            data!.data.announcements[index]
                                                .description,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
                                              height: 1.3,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF6B4EFF)
                                                  .withOpacity(0.08),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Row(
                                              children: [
                                                Text(
                                                  "Read More",
                                                  style: TextStyle(
                                                    color: Color(0xFF6B4EFF),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: 4),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: Color(0xFF6B4EFF),
                                                  size: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.bookmark_border_rounded,
                                            color: Colors.grey[400],
                                            size: 18,
                                          ),
                                          const SizedBox(width: 12),
                                          Icon(
                                            Icons.share_outlined,
                                            color: Colors.grey[400],
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 180,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.92,
                        autoPlayCurve: Curves.easeInOut,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        enableInfiniteScroll: true,
                        padEnds: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                // Scanner Section (if watchman)
                if (loginType == "watchman")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScannerPage()),
                        );
                      },
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Lottie.asset(
                          "lib/assets/lottie_json/scan.json",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 8),

                // Features Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: visibleIndices.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.1,
                    ),
                    itemBuilder: (context, i) {
                      int index = visibleIndices[i];
                      return GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MembersPage()));
                              break;
                            case 1:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VisitorsPage()));
                              break;
                            case 2:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NoticeBoardScreen()));
                              break;
                            case 3:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PaymentScreen()));
                              break;
                            case 4:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BookAmenities()));
                              break;
                            case 5:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DailyneedsTab()));
                              break;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.only(bottom: 2),
                                decoration: BoxDecoration(
                                  color: loginType == "watchman"
                                      ? const Color(0xFFFF9933)
                                          .withOpacity(0.08)
                                      : const Color(0xFF6B4EFF)
                                          .withOpacity(0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  communityList[index],
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                title[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  subtitle[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getAnnouncementColor(String type) {
    switch (type.toLowerCase()) {
      case 'emergency':
        return const Color(0xFFFF3B30); // Red color for emergency
      case 'maintenance':
        return const Color(0xFF34C759); // Green color for maintenance
      case 'general':
        return const Color(0xFF6B4EFF); // Purple color for general
      default:
        return const Color(0xFF6B4EFF); // Default color
    }
  }
}
