import 'package:flutter/material.dart';

import 'profile_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Center(
            child: Container(
              height: 500,
              width: 350,
              decoration: const BoxDecoration(color: Colors.pink),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "my account",
                      style: TextStyle(color: Colors.white),
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "my address",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                    title: Text(
                      "language",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.privacy_tip,
                      color: Colors.white,
                    ),
                    title: Text(
                      "privacy",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.privacy_tip_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      "terms & conditions",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      "log out",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
