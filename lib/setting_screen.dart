import 'package:flutter/material.dart';
import 'package:society_gate/auth/register_screen.dart';
import 'package:society_gate/help_support.dart';
import 'package:society_gate/profile_screen.dart';
import 'package:society_gate/terms_condition.dart';

import 'constents/local_storage.dart';
import 'privacy_policy_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: Text(
                "Edit profile",
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
          // const ListTile(
          //   leading: Icon(
          //     Icons.language,
          //     color: Colors.black,
          //   ),
          //   title: Text(
          //     "language",
          //     style: TextStyle(color: Colors.black),
          //   ),
          //   trailing: Icon(
          //     Icons.arrow_forward_ios_outlined,
          //     size: 18,
          //     color: Colors.black,
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.privacy_tip,
                color: Colors.black,
              ),
              title: Text(
                "Privacy Policy",
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermsConditionScreen()));
            },
            child: const ListTile(
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
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HelpSupport()));
            },
            child: const ListTile(
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
          ),
          GestureDetector(
            onTap: () async {
              await LocalStoragePref.instance!.clearAllPref();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
                (Route<dynamic> route) => false,
              );
            },
            child: const ListTile(
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
          ),
        ],
      ),
    );
  }
}
