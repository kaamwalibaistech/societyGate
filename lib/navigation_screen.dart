import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/dashboard/watchman_profile_page.dart';
import 'package:my_society/message_screen.dart';
import 'package:my_society/timeline_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'account_screen.dart';
import 'homepage_screen.dart';

class Navigationscreen extends StatefulWidget {
  const Navigationscreen({super.key});

  @override
  State<Navigationscreen> createState() => _NavigationscreenState();
}

class _NavigationscreenState extends State<Navigationscreen> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: const Color.fromARGB(255, 19, 52, 84),
        inactiveColorPrimary: CupertinoColors.systemGrey3,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.view_timeline_outlined),
        title: ("Timeline"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey3,
      ),
      PersistentBottomNavBarItem(
        // onPressed: (p0) {
        //   final userLogIn = LocalStoragePref().getUserProfile();
        //   if (userLogIn != null) {
        //     controller.index = 2;
        //   } else {
        //     checkLoginPopup();
        //   }
        // },
        icon: const Icon(Icons.message),
        title: ("message"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey3,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Account"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey3,
      ),
    ];
  }

  List<Widget> buildScreens() {
    final loginModel = LocalStoragePref().getLoginModel();

    return [
      const HomepageScreen(),
      const TimelineScreen(),
      const MessageScreen(),
      loginModel!.user!.role != "watchman"
          ? const AccountScreen()
          : const WatchmanProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: controller,
        screens: buildScreens(),
        items: navBarsItems(),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardAppears: true,

        padding: const EdgeInsets.only(top: 8),
        // backgroundColor: Colors.grey.shade900,
        isVisible: true,

        confineToSafeArea: true,
        navBarHeight: kBottomNavigationBarHeight,
        navBarStyle: NavBarStyle.style1,
        // Choose the nav bar style with this property
        backgroundColor: Colors.white,
      ),
    );
  }
}
