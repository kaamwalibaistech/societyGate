import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/auth/login_bloc/login_bloc.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/constents/sizedbox.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: const Color(0xfff0f3fa),
        appBar: AppBar(
          backgroundColor: const Color(0xfff0f3fa),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back)),
          title: const Text(
            "Edit profile",
            style: TextStyle(fontSize: 16),
          ),
          // actions: const [
          //   Padding(
          //     padding: EdgeInsets.only(right: 12.0),
          //     child: Text(
          //       "Save",
          //       style:
          //           TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          //     ),
          //   )
          // ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: CircleAvatar(
                        radius: 45,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Name",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (nameController.text.isEmpty) {
                        return "Enter Name";
                      }
                      return null;
                    },
                    controller: nameController,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "please enter numbers!";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      counterText: "",
                      hintText: "Enter your name",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "please phone number",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: phoneNumberController,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
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
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      counterText: "",
                      hintText: "[xxx] xx xxxxxx",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Email",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter Email!";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      counterText: "",
                      hintText: "Example@gmail.com",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: GestureDetector(
                      onTap: () async {
                        passwordDialog(nameController.text,
                            emailController.text, phoneNumberController.text);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void passwordDialog(String name, String email, String phone) {
    TextEditingController passwordController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                padding: const EdgeInsets.only(top: 15),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("* Enter Your Last Password"),
                    sizedBoxH15(context),
                    TextFormField(
                      decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter Last Password",
                          counterText: ""),
                      controller: passwordController,
                    ),
                    sizedBoxH15(context),
                    GestureDetector(
                        onTap: () async {
                          if (passwordController.text.isNotEmpty) {
                            ApiRepository apiRepository = ApiRepository();
                            final data =
                                LocalStoragePref.instance!.getLoginModel();

                            final dataa = await apiRepository.updateUser(
                                data!.user!.userId.toString(),
                                name,
                                email,
                                phone);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: dataa!.message.toString());

                            BlocProvider.of<LoginBloc>(context).add(
                                LoginButtonEvent(
                                    phone, passwordController.text));
                          }
                        },
                        child: Center(
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  color: ThemeData().primaryColor),
                              child: const Center(
                                child: Text(
                                  "update",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ))
                  ],
                ),
              ),
            ));
  }
}
