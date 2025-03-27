import 'package:flutter/material.dart';

import 'auth/login_screen.dart';
import 'constents/local_storage.dart';
import 'privacy_policy_screen.dart';
import 'profile_screen.dart';

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
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: const Text(
              "Edit profile",
              style: TextStyle(color: Colors.black),
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
              child: const Icon(
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
          const ListTile(
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
          const ListTile(
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
          GestureDetector(
            onTap: () async {
              await LocalStoragePref.instance!.clearAllPref();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => true,
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
