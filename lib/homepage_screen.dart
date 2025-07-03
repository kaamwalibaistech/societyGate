import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:society_gate/bank/add_bank_form.dart';
import 'package:society_gate/community/community_post_add.dart';
import 'package:society_gate/dashboard/notice_board/notice_api.dart';
import 'package:society_gate/payments_screen/payment_screen.dart';

import 'amenities/book_amenities.dart';
import 'community/community_page.dart';
import 'constents/local_storage.dart';
import 'dashboard/members/members_page.dart';
import 'dashboard/notice_board/notice_board_screen.dart';
import 'dashboard/visitors/visitors_page.dart';
import 'models/announcements_model.dart';
import 'models/login_model.dart';
import 'shops/dailyneeds_tab.dart';
import 'watchman_tools/scanner_page.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  Announcementmodel? announcementmodel;
  LoginModel? loginModel;
  String? loginType;
  List<int> visibleIndices = [];
  bool isAccountCreated = true;

  String profilePhoto = "https://ui-avatars.com/api/?background=edbdff&name=.";
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    loginModel = LocalStoragePref().getLoginModel();

    final String name = loginModel?.user?.uname ?? "NA";
    profilePhoto = loginModel?.user?.profileImage ??
        "https://ui-avatars.com/api/?background=edbdff&name=$name";
    loginType = loginModel?.user?.role ?? "NA";
    if (loginType != "watchnam") {
      announcementmodel =
          await getAnnouncement(loginModel?.user!.societyId.toString() ?? "");
    }
    if (loginType == "admin") {
      if (announcementmodel?.accId != null &&
          announcementmodel!.accId!.isNotEmpty) {
        LocalStoragePref().setBankAddedBool(true);
      } else {
        LocalStoragePref().setBankAddedBool(false);
      }
    }

    visibleIndices = List.generate(6, (index) => index);
    if (loginType == "watchman") {
      visibleIndices.removeWhere((index) => index == 3 || index == 4);
    }

    setState(() {});
  }

  bool _showAddBank() {
    final isBankAdded = LocalStoragePref().getBankAddedBool();

    if (loginType != "admin") return false;
    if (isBankAdded == null || isBankAdded == false) {
      log("Bank not added. Showing field.");
      return true;
    } else {}
    return false;
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
  final List<Map<String, String>> promoList = [
    {
      "title": "Secure Your Society",
      "description":
          "Monitor visitors, approve entries, and maintain safety using our app.",
      "tag": "New"
    },
    {
      "title": "Instant Notifications",
      "description":
          "Get real-time alerts for deliveries, guests, and announcements.",
      "tag": "Update"
    },
    {
      "title": "One-Tap Approvals",
      "description":
          "Approve or reject gate entries with a single tap on your phone.",
      "tag": "Tip"
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          radius: 25,
                          backgroundImage: CachedNetworkImageProvider(
                            profilePhoto,
                          ),
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
                      Visibility(
                        visible: loginType == "admin",
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(100)),
                          child: const Text(
                            "secretary",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: "No Notifications");
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => loginType == "admin"
                              ? const CreatePost()
                              : const CommunityPage())),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(30),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        loginType == "admin"
                            ? Center(
                                child: ListTile(
                                leading: const Icon(
                                  Icons.add_comment_rounded,
                                  color: Colors.green,
                                ),
                                title: Text(
                                  "Create a post!",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color(0xFF6B4EFF).withAlpha(100),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xFF6B4EFF),
                                  ),
                                ),
                              ))
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "New Post is arrived",
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
                                            Icons.error,
                                            color: Colors.green[400],
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "A new post is here from Admin.",
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
                                      color: const Color(0xFF6B4EFF)
                                          .withAlpha(100),
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
                ),

                const SizedBox(height: 16),
                /*
After added acc details:
account status (not activated, activated),
contact support,
Edit details.
Once acc is activated it should be hidden.
 */
                Visibility(
                  visible: _showAddBank(),
                  child: Card(
                    margin: EdgeInsets.all(20),
                    elevation: 10,
                    color: Colors.white,
                    shadowColor: Colors.blue.shade100,
                    child: DottedBorder(
                        // borderPadding: const EdgeInsets.all(12),
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 20),
                        strokeWidth: 2,
                        dashPattern: const [5, 3],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.account_balance_wallet_outlined,
                                size: 36, color: Colors.red),
                            const SizedBox(height: 12),
                            const Text(
                              "Create Your Society Payment Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "Add bank details to receive maintenance and other payments.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black54),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.add),
                                  label: const Text("Add Bank Details"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddBankDetailsPage(
                                                    loginModel: loginModel)));
                                  },
                                ),
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.support_agent),
                                  label: const Text("Support"),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    side: const BorderSide(color: Colors.red),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        )
                        /* Column(
                              children: [
                                const Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 36,
                                    color: Colors.blue),
                                const SizedBox(height: 12),
                                const Text(
                                  "Account pending",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  "Please wait untill we are approve you account!.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.edit),
                                      label: const Text("Edit details"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                      ),
                                      onPressed: () {
                                        // TODO: Add bank details logic
                                      },
                                    ),
                                    OutlinedButton.icon(
                                      icon: const Icon(Icons.support_agent),
                                      label: const Text("Support"),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                      ),
                                      onPressed: () {
                                        // TODO: Support contact logic
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                            */
                        ),
                  ),
                ),

                // Announcements Section (if not watchman)
                if (loginType != "watchman") ...[
                  (announcementmodel?.announcements?.isEmpty ?? false)
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: CarouselSlider.builder(
                            itemCount: promoList.length,
                            itemBuilder: (context, index, realIndex) {
                              final promo = promoList[index];

                              return Card(
                                color: const Color(0xFF6B4EFF).withAlpha(20),
                                elevation: 0,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6B4EFF)
                                            .withOpacity(0.04),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.campaign_rounded,
                                              color: Color(0xFF6B4EFF),
                                              size: 18),
                                          const SizedBox(width: 8),
                                          const Text(
                                            "Promotions",
                                            style: TextStyle(
                                              color: Color(0xFF6B4EFF),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                    Icons
                                                        .local_fire_department_rounded,
                                                    color: Color(0xFF6B4EFF),
                                                    size: 12),
                                                const SizedBox(width: 4),
                                                Text(
                                                  promo["tag"] ?? "Promo",
                                                  style: const TextStyle(
                                                    color: Color(0xFF6B4EFF),
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
                                              promo["title"] ?? "",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Expanded(
                                              child: Text(
                                                promo["description"] ?? "",
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
                                                GestureDetector(
                                                  onTap: () {
                                                    // You can change this to open a promo details page
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFF6B4EFF)
                                                          .withOpacity(0.08),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Row(
                                                      children: [
                                                        Text(
                                                          "Learn More",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF6B4EFF),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        SizedBox(width: 4),
                                                        Icon(
                                                            Icons.arrow_forward,
                                                            color: Color(
                                                                0xFF6B4EFF),
                                                            size: 12),
                                                      ],
                                                    ),
                                                  ),
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
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: CarouselSlider.builder(
                            itemCount:
                                (announcementmodel?.announcements?.isNotEmpty ??
                                        false)
                                    ? announcementmodel?.announcements?.length
                                    : 1,
                            itemBuilder: (context, index, realIndex) {
                              bool hasAnnouncements = announcementmodel
                                      ?.announcements?.isNotEmpty ??
                                  false;
                              String annType = announcementmodel
                                      ?.announcements?[index]
                                      .announcementType ??
                                  "";
                              return Card(
                                color: _getAnnouncementColor(annType)
                                    .withAlpha(20),
                                elevation: 0,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6B4EFF)
                                            .withOpacity(0.04),
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
                                                ? _getAnnouncementColor(annType)
                                                : const Color(0xFF6B4EFF),
                                            size: 18,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            hasAnnouncements
                                                ? annType
                                                : "Notice",
                                            style: TextStyle(
                                              color: hasAnnouncements
                                                  ? _getAnnouncementColor(
                                                      annType)
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
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: _getAnnouncementColor(
                                                      annType),
                                                  size: 12,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  "New",
                                                  style: TextStyle(
                                                    color:
                                                        _getAnnouncementColor(
                                                            annType),
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
                                                  ? announcementmodel
                                                          ?.announcements![
                                                              index]
                                                          .title ??
                                                      ""
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
                                                  announcementmodel!
                                                          .announcements![index]
                                                          .description ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey[600],
                                                    height: 1.3,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const NoticeBoardScreen()));
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFF6B4EFF)
                                                          .withOpacity(0.08),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Row(
                                                      children: [
                                                        Text(
                                                          "Read More",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF6B4EFF),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        SizedBox(width: 4),
                                                        Icon(
                                                          Icons.arrow_forward,
                                                          color:
                                                              Color(0xFF6B4EFF),
                                                          size: 12,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                /*
                              ------------------------------     This is Save and Share Button -------------------------
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
                                          ),*/
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScannerPage()),
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.20,
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
                                          const SocietyPaymentsScreen()));
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
                                      builder: (context) => const DailyneedsTab(
                                            valuee: true,
                                          )));
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
        return Colors.greenAccent.shade700; // Green color for maintenance
      case 'general':
        return const Color(0xFF6B4EFF); // Purple color for general
      default:
        return const Color(0xFF6B4EFF); // Default color
    }
  }
}
