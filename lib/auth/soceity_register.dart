import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:society_gate/models/admin_register_model.dart';

import '../api/api_repository.dart';
import 'login_screen.dart';

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
  final TextEditingController flatNoController = TextEditingController();
  final TextEditingController floorNoNoController = TextEditingController();
  final TextEditingController blockController = TextEditingController();

  Map<String, dynamic> datamap = {
    'sname': '',
    'uphone': '',
  };

  final _formkey = GlobalKey<FormState>();
  String? validateEmail(String? email) {
    RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegEx.hasMatch(email ?? "");
    if (!isEmailValid) return "please  Enter a valid email";
    return null;
  }

  void errorPopUp(Map<String, List<String>> message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Something went wrong!"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: message.values
                .expand((list) => list) // Flatten all error messages
                .map((msg) =>
                    Text(msg, style: const TextStyle(color: Colors.red)))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void approvalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          "Registration Successful",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Your society is registered successfully.\nPlease wait for approval.",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              nameController.clear();
              mobileNoController.clear();
              emailController.clear();
              societyNameController.clear();
              societyAddressController.clear();
              totalFlatController.clear();
              totalwingsController.clear();
              flatNoController.clear();
              floorNoNoController.clear();
              blockController.clear();
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                const Text(
                  "Register Your Society",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                ),
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
                        "Already registered? ",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        "Log In",
                        style: TextStyle(
                            color: Color.fromARGB(255, 105, 178, 237),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Enter Secretary details",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Text(
                      "Name",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          counterText: "",
                          hintText: "Enter your name",
                          hintStyle: const TextStyle(color: Colors.grey),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "+91",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          // keyboardType: TextInputType.number,
                          // maxLength: 10,
                          // controller: mobileNoController,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Enter Phone Number";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.77,
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
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              counterText: "",
                              // hintText: "+91",
                              // hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
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
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: validateEmail,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          counterText: "",
                          hintText: "Enter Email Address",
                          hintStyle: const TextStyle(color: Colors.grey),
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
                                "Your Flat No",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: flatNoController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Your flat no";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    counterText: "",
                                    hintText: "Your flat no.",
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Your Floor no.",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: floorNoNoController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter floor";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    counterText: "",
                                    hintText: "Your floor no",
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "block (eg. A)",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: blockController,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "Enter block";
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    counterText: "",
                                    hintText: "block/wing",
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 80,
                    ),
                    const Center(
                      child: Text(
                        "Enter Society details",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
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
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          counterText: "",
                          hintText: "Enter Society Name",
                          hintStyle: const TextStyle(color: Colors.grey),
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
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          counterText: "",
                          hintText: "Enter Society Address",
                          hintStyle: const TextStyle(color: Colors.grey),
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
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    counterText: "",
                                    hintText: "Enter Total flats",
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
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
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    counterText: "",
                                    hintText: "Enter Total Wings",
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          AdminRegister? dataa = await ApiRepository()
                              .registerSocietyAdmin(
                                  societyNameController.text,
                                  societyAddressController.text,
                                  totalwingsController.text,
                                  totalFlatController.text,
                                  nameController.text,
                                  emailController.text,
                                  mobileNoController.text,
                                  flatNoController.text,
                                  blockController.text,
                                  floorNoNoController.text);

                          if (dataa?.status == 200) {
                            approvalDialog();
                            return;
                          } else {
                            setState(() {
                              datamap = dataa?.message;
                            });

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Something went wrong!"),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text((datamap["sname"] ?? [""])
                                          .join(", ")),
                                      Text((datamap["uphone"] ?? [""])
                                          .join(", ")),
                                      Text((datamap["uemail"] ?? [""])
                                          .join(", ")),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Close"),
                                  ),
                                ],
                              ),
                            );
                          }
                          // Navigator.push(
                        } else {
                          EasyLoading.showToast("Fill all mandatory feilds!");
                        }
                      },
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 40, bottom: 15),
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
                    const Center(
                        child: Text(
                      "By Creating account, you agree to our",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AmenitiesAdd()));
                      },
                      child: Center(
                        child: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
