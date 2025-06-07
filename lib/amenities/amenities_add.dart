import 'package:flutter/material.dart';
import 'package:society_gate/constents/sizedbox.dart';

class AmenitiesAdd extends StatefulWidget {
  const AmenitiesAdd({
    super.key,
  });

  @override
  State<AmenitiesAdd> createState() => _AmenitiesAddState();
}

class _AmenitiesAddState extends State<AmenitiesAdd> {
  List<String> amenities = [];
  String v = "c";
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
  TextEditingController otherAmenitiesName = TextEditingController();
  TextEditingController otherAmenitiesPrice = TextEditingController();
  String? otherAmenitiesDuration;

  List<Map<String, dynamic>> otherAminitiesDataList = [];

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
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Amenities",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  sizedBoxH20(context),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: swimmingPoolChecked,
                          onChanged: (newValue) {
                            setState(() {
                              swimmingPoolChecked = newValue;
                              if (swimmingPoolChecked == true) {
                                amenities.add("Swimming Pool");
                              } else {
                                amenities.remove("Swimming Pool");
                              }
                            });
                          }),
                      const Text(
                        "Swimming Pool",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  swimmingPoolChecked == true
                      ? swimmingPoolMethod()
                      : const SizedBox.shrink(),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: gardenChecked,
                          onChanged: (newValue) {
                            setState(() {
                              gardenChecked = newValue;
                              if (gardenChecked == true) {
                                amenities.add("Garden");
                              } else {
                                amenities.remove("Garden");
                              }
                            });
                          }),
                      const Text(
                        "Garden",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  gardenChecked == true
                      ? gardenMethod()
                      : const SizedBox.shrink(),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: parkingChecked,
                          onChanged: (newValue) {
                            setState(() {
                              parkingChecked = newValue;
                              if (parkingChecked == true) {
                                amenities.add("Parking");
                              } else {
                                amenities.remove("Parking");
                              }
                            });
                          }),
                      const Text(
                        "Parking",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  parkingChecked == true
                      ? parkingMethod()
                      : const SizedBox.shrink(),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: gymChecked,
                          onChanged: (newValue) {
                            setState(() {
                              gymChecked = newValue;
                              if (gymChecked == true) {
                                amenities.add("Gym");
                              } else {
                                amenities.remove("Gym");
                              }
                            });
                          }),
                      const Text(
                        "Gym",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  gymChecked == true ? gymMethod() : const SizedBox.shrink(),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: playGroundChecked,
                          onChanged: (newValue) {
                            setState(() {
                              playGroundChecked = newValue;
                              if (playGroundChecked == true) {
                                amenities.add("Playground");
                              } else {
                                amenities.remove("Playground");
                              }
                            });
                          }),
                      const Text(
                        "Playground",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  playGroundChecked == true
                      ? playgroundMethod()
                      : const SizedBox.shrink(),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: clubHouse,
                          onChanged: (newValue) {
                            setState(() {
                              clubHouse = newValue;
                              if (clubHouse == true) {
                                amenities.add("Club House");
                              } else {
                                amenities.remove("Club House");
                              }
                            });
                          }),
                      const Text(
                        "Club House",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  clubHouse == true
                      ? clubHouseMethod()
                      : const SizedBox.shrink(),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: spa,
                          onChanged: (newValue) {
                            setState(() {
                              spa = newValue;
                              if (spa == true) {
                                amenities.add("Spa");
                              } else {
                                amenities.remove("Spa");
                              }
                            });
                          }),
                      const Text(
                        "Spa",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  spa == true ? spaMethod() : const SizedBox.shrink(),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: buildingWifi,
                          onChanged: (newValue) {
                            setState(() {
                              buildingWifi = newValue;
                              if (buildingWifi == true) {
                                amenities.add("Building Wi-Fi");
                              } else {
                                amenities.remove("Building Wi-Fi");
                              }
                            });
                          }),
                      const Text(
                        "Building Wi-Fi",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  buildingWifi == true ? wifiMethod() : const SizedBox.shrink(),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: rooftopGarden,
                          onChanged: (newValue) {
                            setState(() {
                              rooftopGarden = newValue;
                              if (rooftopGarden == true) {
                                amenities.add(" Rooftop Garden");
                              } else {
                                amenities.remove(" Rooftop Garden");
                              }
                            });
                          }),
                      const Text(
                        " Rooftop Garden",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  rooftopGarden == true
                      ? roofTopGardenMethod()
                      : const SizedBox.shrink(),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: other,
                          onChanged: (newValue) {
                            setState(() {
                              other = newValue;
                              if (other == true) {
                                amenities.add("Other");
                              } else {
                                amenities.remove("Other");
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
                  other == true ? otherAddButton() : const SizedBox.shrink(),
                  other == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                otherAminitiesDataList
                                    .asMap()
                                    .entries
                                    .map((entry) =>
                                        "${entry.key + 1}. ${entry.value['name']} - ${entry.value['price']} (${entry.value['duration']})")
                                    .join("\n"),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 40),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void adminRegisterMethod() async {
    String finalAmenities = "";
    String add;
    for (int i = 0; i < amenities.length; i++) {
      if (finalAmenities == "") {
        add = "";
      } else {
        add = ", ";
      }
      finalAmenities = "$finalAmenities $add ${amenities[i]}";
      print(finalAmenities);
    }
    try {
      if (v != "p") {
        // ApiRepository apiRepository = ApiRepository();
        // AdminRegister? data = await apiRepository.registerSocietyAdmin(
        //     widget.societyNameController,
        //     widget.societyAddressController,
        //     widget.totalwingsController,
        //     widget.totalFlatController,
        //     finalAmenities.toString(),
        //     widget.nameController,
        //     widget.emailController,
        //     widget.mobileNoController,
        //     widget.flatNoController,
        //     widget.blockController,
        //     widget.floorNoNoController);
        // Fluttertoast.showToast(msg: data!.message.toString());
        Navigator.pop(context);

        // Navigator.pop(context);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Widget swimmingPoolMethod() {
    String? swimmingPoolSelectedDuration;

    final List<String> durations = [
      'Monthly',
      '3 Months',
      '6 Months',
      'Yearly',
    ];
    TextEditingController swimmingPoolPriceController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: swimmingPoolPriceController,
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
            width: MediaQuery.of(context).size.width * 0.45,
            child: DropdownButtonFormField<String>(
              dropdownColor: Colors.black,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                labelText: 'Select Duration',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              value: swimmingPoolSelectedDuration,
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
                  swimmingPoolSelectedDuration = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget gardenMethod() {
    String? gardernSelectedDuration;

    final List<String> durations = [
      'Monthly',
      '3 Months',
      '6 Months',
      'Yearly',
    ];
    TextEditingController gardernPriceController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: gardernPriceController,
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
            width: MediaQuery.of(context).size.width * 0.45,
            child: DropdownButtonFormField<String>(
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
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              value: gardernSelectedDuration,
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
                  gardernSelectedDuration = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget parkingMethod() {
    String? parkingSelectedDuration;

    final List<String> durations = [
      'Monthly',
      '3 Months',
      '6 Months',
      'Yearly',
    ];
    TextEditingController parkingPriceController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: parkingPriceController,
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
            width: MediaQuery.of(context).size.width * 0.45,
            child: DropdownButtonFormField<String>(
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
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              value: parkingSelectedDuration,
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
                  parkingSelectedDuration = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget gymMethod() {
    String? gymSelectedDuration;

    final List<String> durations = [
      'Monthly',
      '3 Months',
      '6 Months',
      'Yearly',
    ];

    TextEditingController gymPriceController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: gymPriceController,
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
            width: MediaQuery.of(context).size.width * 0.45,
            child: DropdownButtonFormField<String>(
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
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              value: gymSelectedDuration,
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
                  gymSelectedDuration = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget playgroundMethod() {
    String? playGroungSelectedDuration;

    final List<String> durations = [
      'Monthly',
      '3 Months',
      '6 Months',
      'Yearly',
    ];
    TextEditingController playGroundPriceController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: playGroundPriceController,
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
            width: MediaQuery.of(context).size.width * 0.45,
            child: DropdownButtonFormField<String>(
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
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              value: playGroungSelectedDuration,
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
                  playGroungSelectedDuration = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget clubHouseMethod() {
    String? clubHouseSelectedDuration;

    final List<String> durations = [
      'Monthly',
      '3 Months',
      '6 Months',
      'Yearly',
    ];
    TextEditingController clubHouseController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: clubHouseController,
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
            width: MediaQuery.of(context).size.width * 0.45,
            child: DropdownButtonFormField<String>(
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
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              value: clubHouseSelectedDuration,
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
                  clubHouseSelectedDuration = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget spaMethod() {
    String? spaSelectedDuration;

    final List<String> durations = [
      'Monthly',
      '3 Months',
      '6 Months',
      'Yearly',
    ];
    TextEditingController spaPriceController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: spaPriceController,
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
            width: MediaQuery.of(context).size.width * 0.45,
            child: DropdownButtonFormField<String>(
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
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              value: spaSelectedDuration,
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
                  spaSelectedDuration = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget wifiMethod() {
    String? wifiSelectedDuration;

    final List<String> durations = [
      'Monthly',
      '3 Months',
      '6 Months',
      'Yearly',
    ];
    TextEditingController wifiPriceController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: wifiPriceController,
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
            width: MediaQuery.of(context).size.width * 0.45,
            child: DropdownButtonFormField<String>(
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
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              value: wifiSelectedDuration,
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
                  wifiSelectedDuration = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget roofTopGardenMethod() {
    String? roofTopGardernSelectedDuration;

    final List<String> durations = [
      'Monthly',
      '3 Months',
      '6 Months',
      'Yearly',
    ];
    TextEditingController roofTopPriceController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: roofTopPriceController,
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
            width: MediaQuery.of(context).size.width * 0.45,
            child: DropdownButtonFormField<String>(
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
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              value: roofTopGardernSelectedDuration,
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
                  roofTopGardernSelectedDuration = newValue;
                });
              },
            ),
          )
        ],
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
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
            width: MediaQuery.of(context).size.width * 0.30,
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
            width: MediaQuery.of(context).size.width * 0.30,
            child: DropdownButtonFormField<String>(
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
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
          padding: const EdgeInsets.only(top: 10.0, left: 10),
          child: GestureDetector(
            onTap: () {
              if (otherAmenitiesName.text.isNotEmpty &&
                  otherAmenitiesPrice.text.isNotEmpty &&
                  otherAmenitiesDuration.toString().isNotEmpty) {
                otherAminitiesDataList.add({
                  'name': otherAmenitiesName.text,
                  'price': otherAmenitiesPrice.text,
                  'duration': otherAmenitiesDuration.toString(),
                });

                otherAmenitiesName.clear();
                otherAmenitiesPrice.clear();
              }
              setState(() {});
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.32,
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
