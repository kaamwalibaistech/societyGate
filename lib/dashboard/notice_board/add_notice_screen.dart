import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:society_gate/bloc/homepage_bloc.dart';
import 'package:society_gate/bloc/homepage_event.dart';

import '../../api/api_repository.dart';
import '../../constents/local_storage.dart';
import '../../constents/sizedbox.dart';
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
        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Title",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Center(
                      child: TextFormField(
                        controller: titleController,
                        validator: (value) {
                          if (titleController.text.isEmpty) {
                            return "Enter Title";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter title",
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Description",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Center(
                      child: TextFormField(
                        controller: descriptionController,
                        maxLines: 4,
                        validator: (value) {
                          if (descriptionController.text.isEmpty) {
                            return "Enter Description";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter Description",
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Announcement type",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                              announcementType = "general";
                            });
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: selectedIndex == 1
                                        ? Colors.green
                                        : Colors.black),
                                color: selectedIndex == 1
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        sizedBoxW5(context),
                        const Text(
                          "General",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 2;
                              announcementType = "emergency";
                            });
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: selectedIndex == 2
                                        ? Colors.green
                                        : Colors.black),
                                color: selectedIndex == 2
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        sizedBoxW5(context),
                        const Text(
                          "Emergency",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 3;
                              announcementType = "maintenance";
                            });
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: selectedIndex == 3
                                        ? Colors.green
                                        : Colors.black),
                                color: selectedIndex == 3
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        sizedBoxW5(context),
                        const Text(
                          "Maintenance",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          final logInData = LocalStoragePref().getLoginModel();
                          ApiRepository apiRepository = ApiRepository();
                          AddNoticeModel? addNoticeData =
                              await apiRepository.addNotices(
                            logInData!.user!.societyId.toString(),
                            logInData.user!.userId.toString(),
                            titleController.text,
                            descriptionController.text,
                            announcementType.toString(),
                          );
                          BlocProvider.of<HomepageBloc>(context)
                              .add(GetHomePageDataEvent());
                          Fluttertoast.showToast(
                              msg: addNoticeData?.message.toString() ?? "");
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.99,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(255, 19, 52, 84),
                          ),
                          child: const Center(
                            child: Text(
                              "Add Notice",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
