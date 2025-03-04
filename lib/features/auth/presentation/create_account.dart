import 'package:flutter/material.dart';

import '../network/auth_repository.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController societyNameController = TextEditingController();
  final TextEditingController societyAddressController =
      TextEditingController();
  final TextEditingController totalFlatController = TextEditingController();
  final TextEditingController totalwingsController = TextEditingController();
  bool? swimmingPoolChecked = false;
  bool? gardenChecked = false;
  bool? parkingChecked = false;
  bool? gymChecked = false;
  bool? playGroundChecked = false;
  bool? moreChecked = false;

  final _formKey = GlobalKey<FormState>();

  List<String> amenities = [];
  String? validateEmail(String? email) {
    RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegEx.hasMatch(email ?? "");
    if (!isEmailValid) return "Enter a valid email";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f3fa),
      appBar: AppBar(
        backgroundColor: const Color(0xfff0f3fa),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                    child: Text(
                  "Create an account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      "Log In",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Name",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Full Name!";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      filled:
                          true, // This is required to apply a background color
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                      hintText: "Enter Full Name.",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Phone Numbers",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: mobileNoController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Phone number!";
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
                      hintText: "+91",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: emailController,
                    validator: validateEmail,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      counterText: "",
                      hintText: "Enter Email Address",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Society Name",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: societyNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Society Name!";
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
                      hintText: "Enter Society Name",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Society Address",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: societyAddressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Society Address!";
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
                      hintText: "Enter Society Address",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Flats",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: totalFlatController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Total Flats!";
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
                                hintText: "Enter Total flats",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Wings",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: totalwingsController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Total Wings!";
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
                                hintText: "Enter Total Wings",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    "amenities",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 123, 121, 121)),
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
                        const Text("Swimming Pool")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 123, 121, 121)),
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
                        const Text("Garden")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 123, 121, 121)),
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
                        const Text("Parking")
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 123, 121, 121)),
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
                        const Text("Gym")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 123, 121, 121)),
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
                        const Text("Playground")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 123, 121, 121)),
                            value: moreChecked,
                            onChanged: (newValue) {
                              setState(() {
                                moreChecked = newValue;
                                if (moreChecked == true) {
                                  amenities.add("More");
                                } else {
                                  amenities.remove("More");
                                }
                              });
                            }),
                        const Text("More")
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                    child: Text(
                  "By Creating account, you agree to our",
                  style: TextStyle(color: Colors.black45),
                )),
                Center(
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      AuthRepository authRepository = AuthRepository();
                      await authRepository.registerSociety(
                          nameController.text,
                          mobileNoController.text,
                          emailController.text,
                          societyNameController.text,
                          societyAddressController.text,
                          totalFlatController.text,
                          totalwingsController.text,
                          amenities.toString());
                    }
                  },
                  child: Center(
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
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
