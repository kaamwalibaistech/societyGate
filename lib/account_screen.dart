import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'api/api_repository.dart';
import 'constents/local_storage.dart';
import 'models/add_daily_help_model.dart';
import 'models/add_vehicle_model.dart';
import 'models/get_daily_help_model.dart';
import 'models/get_family_members_model.dart';
import 'models/get_vehicle_detail_model.dart';
import 'setting_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  GetFamilyMemberModel? getFamilyMemberData;
  GetDailyHelpModel? getDailyHelpData;
  GetVehicleDetailsModel? getVehicledetails;
  String? loginType;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getfamilymembers();
    getDailyHelpmembers();
    getVehicleData();
  }

  getfamilymembers() async {
    ApiRepository apiRepository = ApiRepository();
    final data = LocalStoragePref.instance!.getLoginModel();
    final getFamilyMember =
        await apiRepository.getFamilyMembers(data!.user!.flatId.toString());
    setState(() {
      getFamilyMemberData = getFamilyMember;
    });
  }

  getVehicleData() async {
    ApiRepository apiRepository = ApiRepository();
    final data = LocalStoragePref.instance!.getLoginModel();
    var getVehicleData =
        await apiRepository.getVehicleDetails(data!.user!.flatId.toString());
    setState(() {
      getVehicledetails = getVehicleData;
    });
  }

  getDailyHelpmembers() async {
    ApiRepository apiRepository = ApiRepository();
    final data = LocalStoragePref.instance!.getLoginModel();
    final getDailyHelpMember = await apiRepository.getDailyHelpMembers(
        data!.user!.societyId.toString(), data.user!.flatId.toString());

    setState(() {
      getDailyHelpData = getDailyHelpMember;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add to Household',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: loginType == "watchman"
                        ? const Color(0xFFFF9933)
                        : const Color(0xFF6B4EFF),
                  ),
                ),
                const SizedBox(height: 20),
                _buildOptionTile(
                  icon: Icons.family_restroom_rounded,
                  title: 'Add Family Member',
                  onTap: () {
                    Navigator.pop(context);
                    familyMemberModelBottomSheet();
                  },
                ),
                _buildOptionTile(
                  icon: Icons.cleaning_services_rounded,
                  title: 'Add Daily Help',
                  onTap: () {
                    Navigator.pop(context);
                    dailyHelpModelBottomSheet();
                  },
                ),
                _buildOptionTile(
                  icon: Icons.directions_car_rounded,
                  title: 'Add Vehicle',
                  onTap: () {
                    Navigator.pop(context);
                    vehicleModelBottomSheet();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    // Define different light colors for each icon type
    Color getIconColor() {
      switch (icon) {
        case Icons.family_restroom_rounded:
          return const Color(0xFF4CAF50); // Light green
        case Icons.cleaning_services_rounded:
          return const Color(0xFF2196F3); // Light blue
        case Icons.directions_car_rounded:
          return const Color(0xFF9C27B0); // Light purple
        case Icons.person_rounded:
          return const Color(0xFFFF9800); // Light orange
        case Icons.apartment_rounded:
          return const Color(0xFFE91E63); // Light pink
        case Icons.settings_rounded:
          return const Color(0xFF009688); // Light teal
        default:
          return loginType == "watchman"
              ? const Color(0xFFFF9933)
              : const Color(0xFF6B4EFF);
      }
    }

    Color getIconBackgroundColor() {
      switch (icon) {
        case Icons.family_restroom_rounded:
          return const Color(0xFFE8F5E9); // Very light green
        case Icons.cleaning_services_rounded:
          return const Color(0xFFE3F2FD); // Very light blue
        case Icons.directions_car_rounded:
          return const Color(0xFFF3E5F5); // Very light purple
        case Icons.person_rounded:
          return const Color(0xFFFFF3E0); // Very light orange
        case Icons.apartment_rounded:
          return const Color(0xFFFCE4EC); // Very light pink
        case Icons.settings_rounded:
          return const Color(0xFFE0F2F1); // Very light teal
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: getIconBackgroundColor(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: getIconColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D3142),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginModel = LocalStoragePref().getLoginModel();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddOptionsDialog,
        backgroundColor: loginType == "watchman"
            ? const Color(0xFFFF9933)
            : const Color(0xFF6B4EFF),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              loginType == "watchman"
                  ? const Color(0xFFFFF5E6)
                  : const Color(0xFFF8F9FF),
              loginType == "watchman"
                  ? const Color(0xFFFFE5CC)
                  : const Color(0xFFEEF1FF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // Profile Header
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(
                                  0xFFFFF3E0), // Very light orange background
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              color: Color(0xFFFF9800), // Light orange icon
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loginModel?.user?.uname ?? "---",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2D3142),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  loginModel?.user?.uemail ?? "---",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFE0F2F1), // Very light teal background
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.settings_rounded,
                                color: Color(0xFF009688), // Light teal icon
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.apartment_rounded,
                              color: Color(0xFFE91E63), // Light pink
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Society',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    loginModel?.user?.societyName ?? "---",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2D3142),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Household Section Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Household",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: loginType == "watchman"
                          ? const Color(0xFFFF9933)
                          : const Color(0xFFE91E63),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Family Members Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFE8F5E9), // Very light green background
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.family_restroom_rounded,
                                color: Color(0xFF4CAF50), // Light green icon
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "My Family",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2D3142),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Add family members for quick entry",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              getFamilyMemberData?.familyMembers.length ?? 2,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 15),
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: loginType == "watchman"
                                            ? const Color(0xFFFF9933)
                                                .withOpacity(0.2)
                                            : const Color(0xFF6B4EFF)
                                                .withOpacity(0.2),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.person_rounded,
                                      color: loginType == "watchman"
                                          ? const Color(0xFFFF9933)
                                          : const Color(0xFF6B4EFF),
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    getFamilyMemberData
                                            ?.familyMembers[index].uname ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    getFamilyMemberData
                                            ?.familyMembers[index].relation ??
                                        "",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Daily Help Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFE3F2FD), // Very light blue background
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.cleaning_services_rounded,
                                color: Color(0xFF2196F3), // Light blue icon
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Daily Help",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2D3142),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Add daily help members",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      if (getDailyHelpData?.employees.isNotEmpty ?? false)
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(15),
                          itemCount: getDailyHelpData?.employees.length ?? 0,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final help = getDailyHelpData?.employees[index];
                            return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: loginType == "watchman"
                                            ? const Color(0xFFFF9933)
                                                .withOpacity(0.2)
                                            : const Color(0xFF6B4EFF)
                                                .withOpacity(0.2),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.person_rounded,
                                      color: loginType == "watchman"
                                          ? const Color(0xFFFF9933)
                                          : const Color(0xFF6B4EFF),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          help?.name ?? "",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          help?.empType ?? "",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Center(
                            child: Text(
                              "No daily help members added",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Vehicles Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFF3E5F5), // Very light purple background
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.directions_car_rounded,
                                color: Color(0xFF9C27B0), // Light purple icon
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Vehicles",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2D3142),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Add your vehicles",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: getVehicledetails?.data.length ?? 2,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 15),
                              width: 140,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: loginType == "watchman"
                                            ? const Color(0xFFFF9933)
                                                .withOpacity(0.2)
                                            : const Color(0xFF6B4EFF)
                                                .withOpacity(0.2),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.directions_car_rounded,
                                      color: loginType == "watchman"
                                          ? const Color(0xFFFF9933)
                                          : const Color(0xFF6B4EFF),
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    getVehicledetails?.data[index].vehicleNo ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    getVehicledetails?.data[index].model ?? "",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  familyMemberModelBottomSheet() {
    TextEditingController familyNameController = TextEditingController();
    TextEditingController familyMobileNoController = TextEditingController();
    TextEditingController familyEmailController = TextEditingController();
    TextEditingController familyRelationController = TextEditingController();
    TextEditingController familyPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFE8F5E9), // Very light green background
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.family_restroom_rounded,
                                color: Color(0xFF4CAF50), // Light green icon
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add Family Member",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: loginType == "watchman"
                                        ? const Color(0xFFFF9933)
                                        : const Color(0xFF6B4EFF),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Add family members for quick entry",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        _buildTextField(
                          controller: familyNameController,
                          label: "Name",
                          hint: "Enter name",
                          validator: (value) {
                            if (value!.isEmpty || value.length < 2) {
                              return "Enter valid name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: familyMobileNoController,
                          label: "Mobile Number",
                          hint: "Enter mobile number",
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          validator: (value) {
                            if (value!.length != 10) {
                              return "Mobile number should be 10 digits";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: familyEmailController,
                          label: "Email",
                          hint: "Enter email",
                          validator: (value) {
                            RegExp emailRegEx = RegExp(
                                r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
                            final isEmailValid =
                                emailRegEx.hasMatch(value ?? "");
                            if (!isEmailValid) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: familyRelationController,
                          label: "Relation",
                          hint: "Enter relation",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your relation";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: familyPasswordController,
                          label: "Password",
                          hint: "Enter password",
                          isPassword: true,
                          validator: (value) {
                            if (value!.length < 6) {
                              return "Password should be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                if (formKey.currentState!.validate()) {
                                  final data = LocalStoragePref.instance!
                                      .getLoginModel();
                                  ApiRepository apiRepository = ApiRepository();
                                  final dataa =
                                      await apiRepository.addFamilyMembers(
                                    data!.user!.societyId.toString(),
                                    data.user!.flatId.toString(),
                                    data.user!.userId.toString(),
                                    familyNameController.text,
                                    familyEmailController.text,
                                    familyMobileNoController.text,
                                    familyRelationController.text,
                                    familyPasswordController.text,
                                  );
                                  getfamilymembers();
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: dataa!.message.toString());
                                }
                              } catch (e) {
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: "Phone Number is Already Taken");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: loginType == "watchman"
                                  ? const Color(0xFFFF9933)
                                  : const Color(0xFF6B4EFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Add Member",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  dailyHelpModelBottomSheet() {
    TextEditingController dailyHelpNameController = TextEditingController();
    TextEditingController dailyHelpMobileNoController = TextEditingController();
    TextEditingController dailyHelpAddressController = TextEditingController();
    TextEditingController dailyHelpTypeController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFE3F2FD), // Very light blue background
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.cleaning_services_rounded,
                                color: Color(0xFF2196F3), // Light blue icon
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add Daily Help",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: loginType == "watchman"
                                        ? const Color(0xFFFF9933)
                                        : const Color(0xFF6B4EFF),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Add daily help for quick entry",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        _buildTextField(
                          controller: dailyHelpNameController,
                          label: "Name",
                          hint: "Enter name",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: dailyHelpMobileNoController,
                          label: "Mobile Number",
                          hint: "Enter mobile number",
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          validator: (value) {
                            if (value!.length != 10) {
                              return "Mobile number should be 10 digits";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: dailyHelpAddressController,
                          label: "Address",
                          hint: "Enter address",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: dailyHelpTypeController,
                          label: "Help Type",
                          hint: "Select service type",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter service type";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final data =
                                    LocalStoragePref.instance!.getLoginModel();
                                ApiRepository apiRepository = ApiRepository();
                                AddDailyHelpModel? dailyHelpData =
                                    await apiRepository.addDailyHelpMembers(
                                  data!.user!.societyId.toString(),
                                  data.user!.userId.toString(),
                                  data.user!.flatId.toString(),
                                  dailyHelpNameController.text,
                                  dailyHelpMobileNoController.text,
                                  dailyHelpAddressController.text,
                                  dailyHelpTypeController.text,
                                );
                                getDailyHelpmembers();
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: dailyHelpData!.message.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: loginType == "watchman"
                                  ? const Color(0xFFFF9933)
                                  : const Color(0xFF6B4EFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Add Help",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  vehicleModelBottomSheet() {
    TextEditingController vehicleNumberController = TextEditingController();
    TextEditingController vehicleTypeController = TextEditingController();
    TextEditingController vehicleModelController = TextEditingController();
    TextEditingController vehicleParkingSlotController =
        TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFF3E5F5), // Very light purple background
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.directions_car_rounded,
                                color: Color(0xFF9C27B0), // Light purple icon
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add Vehicle",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: loginType == "watchman"
                                        ? const Color(0xFFFF9933)
                                        : const Color(0xFF6B4EFF),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Add your vehicle for quick entry",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        _buildTextField(
                          controller: vehicleNumberController,
                          label: "Vehicle Number",
                          hint: "Enter vehicle number",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter vehicle number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: vehicleTypeController,
                          label: "Vehicle Type",
                          hint: "E.g Car / Bike",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter vehicle type";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: vehicleModelController,
                          label: "Vehicle Model",
                          hint: "Enter vehicle company",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter vehicle model";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: vehicleParkingSlotController,
                          label: "Parking Slot",
                          hint: "Enter parking slot",
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final data =
                                    LocalStoragePref.instance!.getLoginModel();
                                ApiRepository apiRepository = ApiRepository();
                                AddVehicleModel? addVehicleData =
                                    await apiRepository.addVehicle(
                                  data!.user!.societyId.toString(),
                                  data.user!.userId.toString(),
                                  data.user!.flatId.toString(),
                                  vehicleNumberController.text,
                                  vehicleTypeController.text,
                                  vehicleModelController.text,
                                  vehicleParkingSlotController.text,
                                );
                                getVehicleData();
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: addVehicleData!.message.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: loginType == "watchman"
                                  ? const Color(0xFFFF9933)
                                  : const Color(0xFF6B4EFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Add Vehicle",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int? maxLength,
    bool isPassword = false,
    String? Function(String?)? validator,
    // bool obscureText = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2D3142),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          // obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            // suffixIcon: isPassword
            // ? GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         obscureText = !obscureText;
            //       });
            //     },
            //     child: obscureText
            //         ? const Icon(Icons.visibility)
            //         : const Icon(Icons.visibility_off_outlined))
            // : const SizedBox.shrink(),
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.grey[50],
            counterText: "",
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: loginType == "watchman"
                    ? const Color(0xFFFF9933)
                    : const Color(0xFF6B4EFF),
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red[400]!,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red[400]!,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
