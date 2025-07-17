import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:society_gate/account_tab/settings_pages/help_support.dart';
import 'package:society_gate/account_tab/settings_pages/profile_screen.dart';
import 'package:society_gate/account_tab/settings_pages/terms_condition.dart';
import 'package:society_gate/amenities/amenities_add.dart';
import 'package:society_gate/amenities/edit_amenities.dart';
import 'package:society_gate/auth/register_screen.dart';
import 'package:society_gate/bank/add_bank_form.dart';
import 'package:society_gate/bank/bank_api.dart';
import 'package:society_gate/bank/bank_details.dart';
import 'package:society_gate/bank/bank_model.dart';
import 'package:society_gate/dashboard/notice_board/notice_api.dart';
import 'package:society_gate/navigation_screen.dart';

import '../../constents/local_storage.dart';
import 'privacy_policy_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final loginModel = LocalStoragePref().getLoginModel();
    final loginType = loginModel?.user?.role ?? "regular";

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        //  Navigator.pop(context, true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Navigationscreen(
              newIndexData: 3,
            ),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: loginType == "watchman"
            ? const Color(0xFFFFF5E6)
            : const Color(0xFFF8F9FF),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Navigationscreen(
                      newIndexData: 4,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            "Settings",
            style: TextStyle(
              color: loginType == "watchman"
                  ? const Color(0xFFFF9933)
                  : const Color(0xFF6B4EFF),
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: loginType == "watchman"
                ? const Color(0xFFFF9933)
                : const Color(0xFF6B4EFF),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Section
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSettingTile(
                      icon: Icons.person_outline_rounded,
                      title: "Edit Profile",
                      subtitle: "Update your personal information",
                      onTap: () {
                        final userDetail =
                            LocalStoragePref.instance!.getLoginModel();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                namee: userDetail?.user?.uname,
                                phoneNumber: userDetail?.user?.uphone,
                                email: userDetail?.user?.uemail),
                          ),
                        );
                      },
                      loginType: loginType,
                    ),
                    loginType == "admin"
                        ? _buildSettingTile(
                            icon: Icons.pool,
                            title: "Edit Amenities",
                            subtitle:
                                "Update amenities lists, prices and more!",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAmenities(),
                                ),
                              );
                              /*   bool isAmenityAdded =
                                  LocalStoragePref().getAmenitiesBool() ??
                                      false;
                              if (isAmenityAdded == false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AmenitiesAdd(),
                                  ),
                                );
                              } else {
                                 Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAmenities(),
                                ),
                              );
                              }
                             */
                            },
                            loginType: loginType,
                          )
                        : const SizedBox.shrink(),
                    loginType == "admin"
                        ? _buildSettingTile(
                            icon: Icons.account_balance_rounded,
                            title: "Bank Details",
                            subtitle:
                                "Update amenities lists, prices and more!",
                            onTap: () async {
                              EasyLoading.show(status: "Loading bank details!");
                              // final data = await getAnnouncement(
                              //     loginModel?.user!.societyId.toString() ?? "");
                              String accId =
                                  LocalStoragePref().getAccId() ?? "";
                              if (accId == "" || accId.isEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddBankDetailsPage(
                                      loginModel: loginModel,
                                    ),
                                  ),
                                );
                              } else {
                                bool isPending;
                                RazorpayAccountModel? razorpayAccountModel =
                                    await getRouteAccount(accId);

                                if (razorpayAccountModel?.status !=
                                    "activated") {
                                  isPending = false;
                                } else {
                                  isPending = true;
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BankDetailsPage(
                                        isPending: isPending,
                                        razorpayAccountModel:
                                            razorpayAccountModel),
                                  ),
                                );
                              }
                              EasyLoading.dismiss();
                            },
                            loginType: loginType,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),

              // Legal Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSettingTile(
                      icon: Icons.shield_outlined,
                      title: "Privacy Policy",
                      subtitle: "Read our privacy policy",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyScreen(),
                          ),
                        );
                      },
                      loginType: loginType,
                    ),
                    const Divider(height: 1),
                    _buildSettingTile(
                      icon: Icons.description_outlined,
                      title: "Terms & Conditions",
                      subtitle: "Read our terms and conditions",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsConditionScreen(),
                          ),
                        );
                      },
                      loginType: loginType,
                    ),
                  ],
                ),
              ),

              // Support Section
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSettingTile(
                      icon: Icons.support_agent_outlined,
                      title: "Help & Support",
                      subtitle: "Get help with the app",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpSupport(),
                          ),
                        );
                      },
                      loginType: loginType,
                    ),
                  ],
                ),
              ),

              // Logout Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildSettingTile(
                  icon: Icons.logout_outlined,
                  title: "Log Out",
                  subtitle: "Sign out of your account",
                  onTap: () async {
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: const Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                        content: const Text(
                          "Are you sure you want to logout?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6C7A9C),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Color(0xFF6C7A9C),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.red[400],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (shouldLogout == true) {
                      await LocalStoragePref.instance!.clearAllPref();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  loginType: loginType,
                  isLogout: true,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required String loginType,
    bool isLogout = false,
  }) {
    // Define different light colors for each icon type
    Color getIconColor() {
      if (isLogout) return Colors.red[400]!;
      switch (icon) {
        case Icons.person_outline_rounded:
          return const Color(0xFF4CAF50); // Light green
        case Icons.account_balance_rounded:
          return Colors.pinkAccent.shade200;
        case Icons.shield_outlined:
          return const Color(0xFF2196F3); // Light blue
        case Icons.description_outlined:
          return const Color(0xFF9C27B0); // Light purple
        case Icons.support_agent_outlined:
          return const Color(0xFFFF9800); // Light orange
        default:
          return loginType == "watchman"
              ? const Color(0xFFFF9933)
              : const Color(0xFF6B4EFF);
      }
    }

    Color getIconBackgroundColor() {
      if (isLogout) return Colors.red[50]!;
      switch (icon) {
        case Icons.person_outline_rounded:
          return const Color(0xFFE8F5E9); // Very light green
        case Icons.account_balance_rounded:
          return Colors.pink.shade50;
        case Icons.shield_outlined:
          return const Color(0xFFE3F2FD); // Very light blue
        case Icons.description_outlined:
          return const Color(0xFFF3E5F5); // Very light purple
        case Icons.support_agent_outlined:
          return const Color(0xFFFFF3E0); // Very light orange
        default:
          return loginType == "watchman"
              ? const Color(0xFFFF9933).withOpacity(0.1)
              : const Color(0xFF6B4EFF).withOpacity(0.1);
      }
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: getIconBackgroundColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: getIconColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isLogout
                            ? Colors.red[400]
                            : const Color(0xFF2D3142),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: isLogout ? Colors.red[300] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: isLogout ? Colors.red[400] : getIconColor(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
