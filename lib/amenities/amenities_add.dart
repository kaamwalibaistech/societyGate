import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/auth/login_success.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/constents/sizedbox.dart';

import '../navigation_screen.dart';

class AmenitiesAdd extends StatefulWidget {
  const AmenitiesAdd({
    super.key,
  });

  @override
  State<AmenitiesAdd> createState() => _AmenitiesAddState();
}

class _AmenitiesAddState extends State<AmenitiesAdd> {
  List<Map<String, dynamic>> amenities = [];
  // String v = "c";
  bool? swimmingPoolChecked = false;
  bool? gardenChecked = false;
  bool? parkingChecked = false;
  bool? gymChecked = false;
  bool? playGroundChecked = false;
  bool? buildingWifi = false;
  bool? rooftopGarden = false;
  bool? other = false;

  bool? spa = false;
  bool? clubHouse = false;

  //
  TextEditingController otherAmenitiesName = TextEditingController();
  TextEditingController otherAmenitiesPrice = TextEditingController();
  TextEditingController selectedAmenitiesPrice = TextEditingController();

  //
  String? gardernSelectedDuration;
  String? playGroungSelectedDuration;
  String? clubHouseSelectedDuration;
  String? swimmingPoolSelectedDuration;
  String? parkingSelectedDuration;
  String? gymSelectedDuration;
  String? spaSelectedDuration;
  String? wifiSelectedDuration;
  String? roofTopGardernSelectedDuration;
  String? otherAmenitiesDuration;

  //
  String? selectedAmenitiesDuration;

  //
  TextEditingController swimmingPoolPriceController = TextEditingController();
  TextEditingController gardernPriceController = TextEditingController();
  TextEditingController parkingPriceController = TextEditingController();
  TextEditingController gymPriceController = TextEditingController();
  TextEditingController playGroundPriceController = TextEditingController();
  TextEditingController clubHouseController = TextEditingController();
  TextEditingController spaPriceController = TextEditingController();
  TextEditingController wifiPriceController = TextEditingController();
  TextEditingController roofTopPriceController = TextEditingController();

  String? amenitiesSelectedOption;
  final List<String> amenitiesList = [
    'Swimming Pool',
    'Garden',
    'Parking',
    'Gym',
    'Playground',
    'Club House',
    'Spa',
    'Building Wi-Fi',
    'Rooftop Garden',
    // '',
  ];
  final List<String> durations = [
    'Monthly',
    '3 Months',
    '6 Months',
    'Yearly',
  ];

  //
  final formKey = GlobalKey<FormState>();
  final _formKeyOtherButton = GlobalKey<FormState>();

  //

  List<Map<String, dynamic>> selectedAmenitiesList = [];
  // List<Map<String, dynamic>> otherAminitiesDataList = [];
  // List<Map<String, dynamic>> finalAminitiesList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            Color(0xff1f005c),
            Color(0xff5b0060),
            Color(0xff870160),
            Color(0xffac255e),
            Color(0xffca485c),
            Color(0xffe16b5c),
            Color(0xfff39060),
            Color(0xffffb56b),
            Color(0xfff39060),
            Color(0xffffb56b),
          ], // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.mirror,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          title: const Text("Amenities"),
          centerTitle: true,
          // elevation: 100,
          foregroundColor: Colors.white,
          actions: [
            OutlinedButton(
                onPressed: () {
                  LocalStoragePref().setAmenitiesBool(true);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Navigationscreen()));
                },
                child: const Text(
                  "SKIP",
                  style: TextStyle(color: Colors.white),
                )),
            sizedBoxW10(context)
          ],
        ),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      other == true
                          ? const SizedBox.shrink()
                          : sizedBoxH20(context),
                      other == true
                          ? const SizedBox.shrink()
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.70,
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null) {
                                    return "Please Select";
                                  }
                                  return null;
                                },
                                dropdownColor: Colors.black,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  labelText: 'Select Amenities',
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                ),
                                value: amenitiesSelectedOption,
                                style: const TextStyle(color: Colors.white),
                                items: amenitiesList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    amenitiesSelectedOption = newValue;
                                  });
                                },
                              ),
                            ),
                      other == true
                          ? const SizedBox.shrink()
                          : sizedBoxH10(context),
                      other == true
                          ? const SizedBox.shrink()
                          : Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: selectedAmenitiesPrice,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "please enter Price!";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 10),
                                      counterText: "",
                                      hintText: "Eg-Rs 2000/--",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  child: DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value == null) {
                                        return "Please Select";
                                      }
                                      return null;
                                    },
                                    dropdownColor: Colors.black,
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      labelText: 'Select Duration',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2)),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                    ),
                                    value: selectedAmenitiesDuration,
                                    style: const TextStyle(color: Colors.white),
                                    items: durations.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedAmenitiesDuration = newValue;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                      other == true
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (formKey.currentState!.validate() &&
                                      amenitiesSelectedOption
                                          .toString()
                                          .isNotEmpty &&
                                      selectedAmenitiesPrice.text.isNotEmpty &&
                                      selectedAmenitiesDuration
                                          .toString()
                                          .isNotEmpty) {
                                    setState(() {
                                      selectedAmenitiesList.add({
                                        'name':
                                            amenitiesSelectedOption.toString(),
                                        'amount': selectedAmenitiesPrice.text,
                                        'duration': selectedAmenitiesDuration
                                            .toString(),
                                      });
                                    });
                                    selectedAmenitiesDuration = null;
                                    selectedAmenitiesPrice.clear();
                                    Fluttertoast.showToast(
                                        msg: "Added Successfully");
                                  }

                                  log(selectedAmenitiesList.toString());
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                      sizedBoxH10(context),
                      Row(
                        children: [
                          Checkbox(
                              side: const BorderSide(color: Colors.white),
                              value: other,
                              onChanged: (newValue) {
                                setState(() {
                                  other = newValue;
                                  if (other == false) {
                                    selectedAmenitiesList.clear();
                                  }
                                });
                              }),
                          const Text(
                            "Others",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      other == true ? others() : const SizedBox.shrink(),
                      other == true
                          ? otherAddButton()
                          : const SizedBox.shrink(),
                      other == true
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    selectedAmenitiesList
                                        .asMap()
                                        .entries
                                        .map((entry) =>
                                            "${entry.key + 1}. ${entry.value['name']} - ${entry.value['amount']} (${entry.value['duration']})")
                                        .join("\n"),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      if (amenitiesSelectedOption != null || other == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                          child: GestureDetector(
                            onTap: () async {
                              if (other == true ||
                                  selectedAmenitiesList.isNotEmpty) {
                                final loginModel =
                                    LocalStoragePref().getLoginModel();
                                ApiRepository apiRepository = ApiRepository();

                                final dataa =
                                    await apiRepository.amenitiesSendRawJson(
                                        selectedAmenitiesList,
                                        loginModel?.user?.societyId);
                                if (dataa?["status"] == 200) {
                                  Fluttertoast.showToast(
                                      msg: dataa?["message"] ??
                                          "Something Went Wrong!");
                                  LocalStoragePref().setAmenitiesBool(true);
                                  Navigator.pushReplacement(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginSuccess()));
                                } else {
                                  log(selectedAmenitiesList.toString());
                                  Fluttertoast.showToast(
                                      msg: dataa?["message"] ??
                                          "Something Went Wrong!");
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Selected Amenities are not Added");
                              }
                            },
                            child: Center(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Center(
                                    child: Text(
                                  "Register",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 12.0, top: 40),
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //     child: const Icon(
          //       Icons.arrow_back,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }

  Widget others() {
    final List<String> durations = [
      'Monthly',
      '3 Months',
      '6 Months',
      'Yearly',
    ];

    return Form(
      key: _formKeyOtherButton,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.27,
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: otherAmenitiesName,
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter Name!";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                counterText: "",
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.27,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: otherAmenitiesPrice,
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter Price!";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                counterText: "",
                hintText: "Eg-Rs 2000/--",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.27,
            child: DropdownButtonFormField<String>(
              validator: (value) {
                if (value == null) {
                  return "Please Select";
                }
                return null;
              },
              dropdownColor: Colors.black,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                labelText: 'Select Duration',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              ),
              value: otherAmenitiesDuration,
              style: const TextStyle(color: Colors.white),
              items: durations.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  otherAmenitiesDuration = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget otherAddButton() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          child: GestureDetector(
            onTap: () {
              if (_formKeyOtherButton.currentState!.validate() &&
                  otherAmenitiesName.text.isNotEmpty &&
                  otherAmenitiesPrice.text.isNotEmpty &&
                  otherAmenitiesDuration.toString().isNotEmpty) {
                selectedAmenitiesList.add({
                  'name': otherAmenitiesName.text,
                  'amount': otherAmenitiesPrice.text,
                  'duration': otherAmenitiesDuration.toString(),
                });
              }
              setState(() {});
              log(selectedAmenitiesList.toString());
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.27,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                  child: Text(
                "Add",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
