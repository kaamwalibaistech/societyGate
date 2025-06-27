import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:society_gate/models/login_model.dart';

import 'account_tab/account_screen.dart';
import 'account_tab/watchman_profile_page.dart';
import 'community/community_page.dart';
import 'constents/local_storage.dart';
import 'homepage_screen.dart';
import 'shops/dailyneeds_tab.dart';

class Navigationscreen extends StatefulWidget {
  final int newIndexData;
  const Navigationscreen({super.key, this.newIndexData = 0});

  @override
  State<Navigationscreen> createState() => _Navigationscreen();
}

class _Navigationscreen extends State<Navigationscreen> {
  int selectedIndex = 0;
  String? loginType;

  String uiPhoto = "";
  LoginModel? loginModel;
  String userPhoto = 'https://ui-avatars.com/api/?background=random&name=ABC.';

  @override
  void initState() {
    super.initState();
    getuserPhoto();
  }

  void getuserPhoto() {
    loginModel = LocalStoragePref().getLoginModel();
    setState(() {
      loginType = loginModel!.user!.role;
      uiPhoto = loginModel!.user!.uname ?? "NA";
      selectedIndex = widget.newIndexData;
    });
  }

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
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 20,
          useLegacyColorScheme: false,
          iconSize: 30,
          unselectedItemColor: Colors.grey,
          selectedItemColor: selectedIndex == 0
              ? Colors.deepOrangeAccent
              : selectedIndex == 1
                  ? Colors.green
                  : selectedIndex == 2
                      ? Colors.blueAccent
                      : Colors.black87,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
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
              label: "Community",
              activeIcon: Icon(Icons.message),
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.green),
                ),
                child: loginModel?.user?.profileImage != null
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: loginModel!.user!.profileImage!,
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )
                    : CircleAvatar(
                        radius: 18,
                        backgroundImage: CachedNetworkImageProvider(
                            "https://ui-avatars.com/api/?background=edbdff&name=$uiPhoto.")),
              ),
              label: "Profile",
            )
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
        return loginType != "watchman"
            ? const AccountScreen()
            : const WatchmanProfilePage();
      default:
        return const HomepageScreen();
    }
  }
}
