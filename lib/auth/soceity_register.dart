import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_society/auth/login_screen.dart';
import 'package:my_society/constents/sizedbox.dart';

class SocietyRegister extends StatefulWidget {
  const SocietyRegister({super.key});

  @override
  State<SocietyRegister> createState() => _SocietyRegister();
}

class _SocietyRegister extends State<SocietyRegister> {
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
  final _formkey = GlobalKey<FormState>();

  List<String> amenities = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f3fa),
      body: Stack(children: [
        Form(
          key: _formkey,
          child: Container(
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
                ], // Gradient from https://learnui.design/tools/gradient-generator.html
                tileMode: TileMode.mirror,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Center(
                        child: Text(
                      "Create an account",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Log In",
                            style: TextStyle(
                                color: Color.fromARGB(255, 105, 178, 237),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    sizedBoxH10(context),
                    const Text(
                      "Name",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          counterText: "",
                          hintText: "Enter your name",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Phone Numbers",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
                            return "Enter Phone Number";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
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
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Email";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
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
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: TextFormField(
                        controller: societyNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Society Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
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
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: TextFormField(
                        controller: societyAddressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Society Address";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
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
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
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
                                      return "Enter Total Flats";
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
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
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
                                      return "please enter numbers!";
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
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        Row(
                          children: [
                            Checkbox(
                                side: const BorderSide(color: Colors.white),
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
                            const Text(
                              "More",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      "By Creating account, you agree to our",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
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
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          Fluttertoast.showToast(msg: "msg");
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
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 30),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
