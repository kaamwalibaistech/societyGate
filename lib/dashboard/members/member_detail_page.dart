import 'package:flutter/material.dart';
import 'package:society_gate/constents/sizedbox.dart';
import 'package:society_gate/models/login_model.dart';
import 'package:society_gate/models/memberlist_model.dart';

import '../../constents/local_storage.dart';

class MemberDetailPage extends StatefulWidget {
  final Members member;
  const MemberDetailPage({super.key, required this.member});

  @override
  State<MemberDetailPage> createState() => _MemberDetailPageState();
}

class _MemberDetailPageState extends State<MemberDetailPage> {
  bool isAdmin = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final LoginModel? getLoginModel = LocalStoragePref().getLoginModel();
    String admin = getLoginModel?.user?.role ?? "";
    setState(() {
      if (admin == "admin") {
        isAdmin = true;
      } else {
        isAdmin = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.member.uname ?? ""),
        actions: !isAdmin
            ? [
                ElevatedButton(onPressed: () {}, child: Text("Add a Fine")),
                sizedBoxW10(context)
              ]
            : null,
        backgroundColor: Colors.purple.shade200,
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
