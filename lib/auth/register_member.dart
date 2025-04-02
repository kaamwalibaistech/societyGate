import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api/api_repository.dart';
import '../constents/sizedbox.dart';
import '../models/member_register_model.dart';
import 'login_screen.dart';

class RegisterMember extends StatefulWidget {
  const RegisterMember({super.key});

  @override
  State<RegisterMember> createState() => _RegisterMemberState();
}

class _RegisterMemberState extends State<RegisterMember> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController societyCodeController = TextEditingController();
  final TextEditingController flatNoController = TextEditingController();
  final TextEditingController floorNoNoController = TextEditingController();
  final TextEditingController blockController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xfff0f3fa),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Makes the AppBar transparent
        elevation: 0, // Removes AppBar shadow

        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1, left: 10, right: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xff1f005c),
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align content
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: Text(
                        "Create a member account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                                color: Color.fromARGB(255, 105, 178, 237),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  sizedBoxH20(context),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Name",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  inputFeild("Name", "Enter your name", nameController,
                      nameValidator, null),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Mobile No",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  inputFeild("Phone", "Enter your phone number",
                      phoneController, phoneValidator, TextInputType.number),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Email",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  inputFeild("Email", "Enter your email", emailController,
                      emailValidator, TextInputType.emailAddress),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Society Code ",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  inputFeild(
                      "Society Code",
                      "Enter Society Code",
                      societyCodeController,
                      societyValidator,
                      TextInputType.phone),
                  // inputFeild("Password", "Enter password", passwordController,
                  //     passwordValidator, TextInputType.visiblePassword,
                  //     isPassword: true),
                  // inputFeild(
                  //     "Confirm Password",
                  //     "Re-enter password",
                  //     confirmPasswordController,
                  //     confirmPasswordValidator,
                  //     TextInputType.visiblePassword,
                  //     isPassword: true),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //         fillColor: WidgetStateProperty.resolveWith((states) {
                  //           if (states.contains(WidgetState.selected)) {
                  //             return Colors.green;
                  //           }
                  //           return Colors.white60;
                  //         }),
                  //         value: !isPasswordHidden,
                  //         onChanged: (value) {
                  //           setState(() {
                  //             isPasswordHidden = !isPasswordHidden;
                  //           });
                  //         }),
                  //     const Text(
                  //       "Show password",
                  //       style: TextStyle(color: Colors.white70),
                  //     )
                  //   ],
                  // ),

                  // sizedBoxH10(context),
                  // SizedBox(
                  //   child: TextFormField(
                  //     controller: societyCodeController,
                  //     validator: societyValidator,
                  //     decoration: const InputDecoration(
                  //       fillColor: Colors.white,
                  //       filled: true,
                  //       border: OutlineInputBorder(borderSide: BorderSide.none),
                  //       contentPadding:
                  //           EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  //       hintText: "Society Code",
                  //       hintStyle: TextStyle(color: Colors.black54),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Flat No",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  counterText: "",
                                  hintText: "Your flat no",
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
                              "Floor",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  counterText: "",
                                  hintText: "Your floor no",
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
                              "block",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: blockController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter block";
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
                                  hintText: "block/wing",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sizedBoxH30(context),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.70,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            ApiRepository apiRepository = ApiRepository();
                            MemberRegisterModel? memberRegisterData =
                                await apiRepository.memberRegister(
                                    nameController.text,
                                    emailController.text,
                                    phoneController.text,
                                    societyCodeController.text,
                                    flatNoController.text,
                                    blockController.text,
                                    floorNoNoController.text);
                            // All validations passed
                            Fluttertoast.showToast(
                                msg: memberRegisterData!.message);
                            Navigator.pop(context);
                          }
                        },
                        child: Center(
                          child: Container(
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
                  ),
                  sizedBoxH20(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputFeild(
    String title,
    String? hintText,
    TextEditingController controller,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType, {
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   style: const TextStyle(fontSize: 16, color: Colors.white60),
        // ),
        sizedBoxH10(context),
        SizedBox(
          child: TextFormField(
            keyboardType: keyboardType,
            maxLength: title == "Phone" ? 10 : 50,
            controller: controller,
            validator: validator,
            obscureText: isPassword ? isPasswordHidden : false,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              counterText: "",
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black54),
            ),
          ),
        ),
        sizedBoxH10(context),
      ],
    );
  }

  // Validators
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  // String? passwordValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "Password is required";
  //   }
  //   if (value.length < 8) {
  //     return "Password must be at least 8 characters long";
  //   }
  //   return null;
  // }

  // String? confirmPasswordValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "Please confirm your password";
  //   }
  //   if (value != passwordController.text) {
  //     return "Passwords do not match";
  //   }
  //   return null;
  // }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    if (value.length != 10) {
      return "Phone number must be 10 digits";
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is Required";
    }
    return null;
  }

  String? societyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Society Code is Required";
    }
    return null;
  }
}
