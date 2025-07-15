import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:society_gate/constents/sizedbox.dart';
import 'package:society_gate/dashboard/members/add_fine_page.dart';
import 'package:society_gate/models/login_model.dart';

import '../../constents/local_storage.dart';

class MemberWatchmanDetailPage extends StatefulWidget {
  final dynamic details;
  const MemberWatchmanDetailPage({super.key, this.details});

  @override
  State<MemberWatchmanDetailPage> createState() =>
      _MemberWatchmanDetailPageState();
}

class _MemberWatchmanDetailPageState extends State<MemberWatchmanDetailPage> {
  bool isAdmin = false;
  LoginModel? getLoginModel;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    getLoginModel = LocalStoragePref().getLoginModel();
    String admin = getLoginModel?.user?.role ?? "";
    setState(() {
      isAdmin = admin == "admin";
    });
  }

  @override
  Widget build(BuildContext context) {
    final member = widget.details;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: Text(member.uname ?? "Member Details"),
          // centerTitle: true,
          // backgroundColor: Colors.deepPurple.shade400,
          // foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Section
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(widget
                              .details.profileImage ??
                          "https://ui-avatars.com/api/?background=random&name=${widget.details.uname}."),
                    ),
                    sizedBoxH10(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          member.uname ?? "",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.verified,
                            color: Colors.green, size: 20),
                      ],
                    ),
                    Text(member.urole?.toUpperCase() ?? "",
                        style: TextStyle(color: Colors.grey.shade600)),
                    sizedBoxH10(context),
                    if (isAdmin)
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddFinePage(details: widget.details)));
                        },
                        icon: const Icon(Icons.warning_amber_rounded),
                        label: const Text("Add Fine"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                  ],
                ),
              ),
              sizedBoxH20(context),

              // Detail Cards
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.email, color: Colors.deepPurple),
                  title: const Text("Email"),
                  subtitle: Text(member.uemail ?? "Not Available"),
                ),
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.phone_android, color: Colors.teal),
                  title: const Text("Phone"),
                  subtitle: Text(member.uphone ?? "Not Available"),
                ),
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading:
                      const Icon(Icons.apartment_rounded, color: Colors.blue),
                  title: const Text("Society"),
                  subtitle: Text(
                      getLoginModel?.user?.societyName?.toString() ?? "N/A"),
                ),
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.security, color: Colors.green),
                  title: const Text("Approval Status"),
                  subtitle: Text(member.approvalStatus ?? "Pending"),
                ),
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.calendar_month_rounded,
                      color: Colors.pink),
                  title: const Text("Joined On"),
                  subtitle: Text(member.createdAt ?? "N/A"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
