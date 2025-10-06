import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:society_gate/amenities/amenities_add.dart';
import 'package:society_gate/auth/forget_password_otp.dart';
import 'package:society_gate/auth/register_waiting_page.dart';
import 'package:society_gate/navigation_screen.dart';

import '../constents/sizedbox.dart';
import 'login_bloc/login_bloc.dart';
import 'register_member.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<LoginScreen> {
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordHidden = false;

  LoginBloc? loginBloc;

  // String? validateEmail(String? email) {
  //   RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
  //   final isEmailValid = emailRegEx.hasMatch(email ?? "");
  //   if (!isEmailValid) return "please  Enter a valid email";
  //   return null;
  // }
  void showMobileNotRegisteredPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mobile Number Error'),
        content: const Text('The mobile number you entered is not registered.'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 80.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    // const RegisterMember();
                    _mobileNoController.clear();
                    _passwordController.clear();
                    return const RegisterMember();
                  })),
                  child: const Text('Register here'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// <<<<<<< HEAD
  // void showForgotPasswordDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //         title: const Text("Forgot Password"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Text("Enter your Phone Number to reset your password."),
  //             const SizedBox(height: 12),
  //             TextField(
  //               controller: phoneNumber,
  //               keyboardType: TextInputType.number,
  //               decoration: InputDecoration(
  //                 hintText: "Phone No.",
  //                 prefixIcon: const Icon(Icons.call),
  //                 filled: true,
  //                 fillColor: Colors.blue.shade50,
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(10),
  //                   borderSide: BorderSide.none,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context); // Close dialog
  //             },
  //             child: const Text("Cancel"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               // String email = emailController.text.trim();

  //               if (phoneNumber.text.isEmpty ||
  //                   int.parse(phoneNumber.text) < 10) {
  //                 Fluttertoast.showToast(msg: "Enter a Valid Phone Number");
  //               } else {
  //                 // ApiRepository apiRepository = ApiRepository();
  //                 // final forgotPasswordData = await apiRepository
  //                 //     .getForgotPassword(phoneNumber.text);
// =======
  // void showForgotPasswordDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //         title: const Text("Forgot Password"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Text("Enter your Phone Number to reset your password."),
  //             const SizedBox(height: 12),
  //             TextField(
  //               maxLength: 10,
  //               controller: emailController,
  //               keyboardType: TextInputType.number,
  //               decoration: InputDecoration(
  //                 hintText: "Phone No",
  //                 counterText: "",
  //                 prefixIcon: const Icon(Icons.call),
  //                 filled: true,
  //                 fillColor: Colors.blue.shade50,
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(10),
  //                   borderSide: BorderSide.none,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context); // Close dialog
  //             },
  //             child: const Text("Cancel"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               String email = emailController.text.trim();

  // //               if (email.isEmpty || !email.contains('@')) {
  // //                 Fluttertoast.showToast(msg: "Enter A valid Phone Number");
  // //               } else {
  // //                 ApiRepository apiRepository = ApiRepository();
  // //                 final forgotPasswordData = await apiRepository
  // //                     .getForgotPassword(emailController.text);

  //                 Fluttertoast.showToast(
  //                     msg: forgotPasswordData!.message.toString());
  //                 Navigator.pop(context);
  //               }
  //             },
  //             child: const Text("Submit"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          EasyLoading.dismiss();
          // context.read<LoginBloc>().add(
          //         AmenitiesChecker(),
          //       );
          if (state.loginModel.user?.role == "admin") {
            EasyLoading.dismiss();
            state.isAmenitiesAvailable == true
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Navigationscreen()),
                  )
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const AmenitiesAdd()),
                  );
          } else {
            EasyLoading.dismiss();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Navigationscreen()),
            );
          }
        } else if (state is LoginNotApproveState) {
          EasyLoading.dismiss();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ApprovalPendingPage()),
          );
        } else if (state is LoginErrorState) {
          EasyLoading.dismiss();
          Fluttertoast.showToast(
            msg: state.errMsg,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          // showMobileNotRegisteredPopup(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: loginScreen(),
      ),
    );
  }

  Widget loginScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                  child: Text(
                "Welcome back!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.deepPurple[700]),
              )),
              sizedBoxH5(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Lottie.asset("lib/assets/lottie_json/login.json"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterMember()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    Text(
                      "Register Here",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                child: TextFormField(
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter mobile no.";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: _mobileNoController,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.red),
                    counterText: "",
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 0.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    hintText: "Phone No ",
                    hintStyle: TextStyle(color: Colors.deepPurple[200]),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Password";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  obscureText: !isPasswordHidden,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.red),
                    filled: true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                      child: Icon(
                        isPasswordHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.deepPurple.shade400,
                      ),
                    ),
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 0.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    counterText: "",
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.deepPurple[200]),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  // showForgotPasswordDialog(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const EmployerForgetPassword()));
                },
                child: const Center(
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    EasyLoading.show();
                    context.read<LoginBloc>().add(
                          LoginButtonEvent(_mobileNoController.text,
                              _passwordController.text),
                        );
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                      child: Text(
                    "Log In",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
