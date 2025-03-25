import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_society/account_screen.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/dashboard/watchman_profile_page.dart';
import 'package:my_society/homepage_screen.dart';
import 'package:my_society/message_screen.dart';
import 'package:my_society/timeline_screen.dart';

class Navigationscreen extends StatefulWidget {
  const Navigationscreen({super.key});

  @override
  State<Navigationscreen> createState() => _Navigationscreen();
}

class _Navigationscreen extends State<Navigationscreen> {
  int selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  final loginModel = LocalStoragePref().getLoginModel();

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        final shouldExit = await _onWillPop();

        if (shouldExit) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else {
            exit(0);
          }
        }
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => selectedIndex = index);
          },
          children: [
            const HomepageScreen(),
            const TimelineScreen(),
            const MessageScreen(),
            loginModel!.user!.role != "watchman"
                ? const AccountScreen()
                : const WatchmanProfilePage()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: changeTab, // Update PageView when tapping tabs
          type: BottomNavigationBarType.fixed,
          // backgroundColor: Colors.amber,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          selectedItemColor: Colors.deepOrangeAccent,
          unselectedItemColor: Colors.blueGrey,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
                activeIcon: Icon(Icons.home_rounded)),
            const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: "Needs",
                activeIcon: Icon(Icons.shopping_bag_rounded)),
            const BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined),
                label: "Messege",
                activeIcon: Icon(Icons.message)),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "lib/assets/man.png",
                  scale: 14,
                ),
                label: "Profile",
                activeIcon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 0.5, color: Colors.deepOrangeAccent)),
                  child: Image.asset(
                    "lib/assets/man.png",
                    scale: 18,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm Exit"),
            content: const Text("Do you really want to exit the app?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // Cancel
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // Exit
                child: const Text("Exit"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
