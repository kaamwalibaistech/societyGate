import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'account_screen.dart';
import 'constents/local_storage.dart';
import 'dashboard/watchman_profile_page.dart';
import 'homepage_screen.dart';
import 'community/community_page.dart';
import 'shops/dailyneeds_tab.dart';

class Navigationscreen extends StatefulWidget {
  const Navigationscreen({super.key});

  @override
  State<Navigationscreen> createState() => _Navigationscreen();
}

class _Navigationscreen extends State<Navigationscreen> {
  int selectedIndex = 0;
  Uint8List? _userPhoto;

  @override
  void initState() {
    super.initState();
    getuserPhoto();
  }

  void getuserPhoto() {
    final data = LocalStoragePref.instance!.getUserPhoto();
    setState(() {
      _userPhoto = data;
    });
  }

  final loginModel = LocalStoragePref().getLoginModel();

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
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
        body: _getSelectedScreen(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: changeTab,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          selectedItemColor: Colors.deepOrangeAccent,
          unselectedItemColor: Colors.blueGrey,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              activeIcon: Icon(Icons.home_rounded),
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: "Needs",
              activeIcon: Icon(Icons.shopping_bag_rounded),
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              label: "Message",
              activeIcon: Icon(Icons.message),
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border:
                      Border.all(width: 0.5, color: Colors.deepOrangeAccent),
                ),
                child: _userPhoto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.memory(
                          _userPhoto!,
                          fit: BoxFit.cover,
                          width: 30,
                          height: 30,
                        ),
                      )
                    : const Icon(Icons.person),
              ),
              label: "Profile",
              activeIcon: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border:
                      Border.all(width: 0.5, color: Colors.deepOrangeAccent),
                ),
                child: _userPhoto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.memory(
                          _userPhoto!,
                          fit: BoxFit.cover,
                          width: 30,
                          height: 30,
                        ),
                      )
                    : const Icon(Icons.person),
              ),
            ),
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

  Widget _getSelectedScreen(int index) {
    switch (index) {
      case 0:
        return const HomepageScreen();
      case 1:
        return const DailyneedsTab();
      case 2:
        return const CommunityPage();
      case 3:
        return loginModel!.user!.role != "watchman"
            ? const AccountScreen()
            : const WatchmanProfilePage();
      default:
        return const HomepageScreen();
    }
  }
}
