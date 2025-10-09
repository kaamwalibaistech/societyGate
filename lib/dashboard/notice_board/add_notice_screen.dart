import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:society_gate/bloc/homepage_bloc.dart';
import 'package:society_gate/bloc/homepage_event.dart';

import '../../api/api_repository.dart';
import '../../constents/local_storage.dart';
import '../../models/add_notices_model.dart';

class AddNoticeScreen extends StatefulWidget {
  const AddNoticeScreen({super.key});

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool? isChecked = false;
  bool? emergencyChecked = false;
  bool? maintenanceChecked = false;
  int selectedIndex = 0;
  String? announcementType;
  bool? emergencySelected;
  bool? maintenanceSelected;
  bool? generalSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f3fa),
      appBar: AppBar(
        backgroundColor: const Color(0xfff0f3fa),
        title: const Text("Add new notice"),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Title",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: titleController,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter Title" : null,
                  decoration: InputDecoration(
                    hintText: "Enter title",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Description",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  validator: (value) => value == null || value.isEmpty
                      ? "Enter Description"
                      : null,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: "Enter Description",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Announcement type",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildOption("General", 1, selectedIndex == 1),
                    _buildOption("Emergency", 2, selectedIndex == 2),
                    _buildOption("Maintenance", 3, selectedIndex == 3),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (generalSelected != true &&
                            maintenanceSelected != true &&
                            emergencySelected != true) {
                          Fluttertoast.showToast(
                              msg: "Announcement type is Required");
                          return; // stop execution
                        }

                        try {
                          final logInData = LocalStoragePref().getLoginModel();
                          ApiRepository apiRepository = ApiRepository();

                          AddNoticeModel? addNoticeData =
                              await apiRepository.addNotices(
                            logInData?.user?.societyId.toString() ?? "",
                            logInData?.user?.userId.toString() ?? "",
                            titleController.text,
                            descriptionController.text,
                            announcementType.toString(),
                          );

                          BlocProvider.of<HomepageBloc>(context)
                              .add(GetHomePageDataEvent());

                          Fluttertoast.showToast(
                            msg: addNoticeData?.message.toString() ??
                                "Notice added successfully",
                          );

                          Navigator.pop(context);
                        } catch (e, stack) {
                          debugPrint("Add Notice Error: $e");
                          debugPrintStack(stackTrace: stack);

                          Fluttertoast.showToast(
                            msg: "Something went Wrong",
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(msg: "All Fields Are Required");
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF133454),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Add Notice",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String label, int index, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          announcementType = label.toLowerCase();
          generalSelected = index == 1;
          emergencySelected = index == 2;
          maintenanceSelected = index == 3;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF133454).withOpacity(0.1)
              : Colors.transparent,
          border: Border.all(
              color:
                  isSelected ? const Color(0xFF133454) : Colors.grey.shade400),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 18,
              color: isSelected ? const Color(0xFF133454) : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? const Color(0xFF133454) : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
