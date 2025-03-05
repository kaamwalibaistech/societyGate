import 'package:flutter/material.dart';

import '../navigation_screen.dart';

import '../../../navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<LoginScreen> {
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordHidden = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xfff0f3fa),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xfff0f3fa),
      //   leading: GestureDetector(
      //       onTap: () {
      //         Navigator.pop(context);
      //       },
      //       child: const Icon(Icons.arrow_back)),
      // ),
      body: Container(
        decoration: BoxDecoration(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Text(
                "Welcome back!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    "Get started",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              // const Text(
              //   "Phone Numbers",
              //   style: TextStyle(fontSize: 16, color: Colors.grey),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: _mobileNoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    counterText: "",
                    hintText: "Enter number",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // const Text(
              //   "Password",
              //   style: TextStyle(fontSize: 16, color: Colors.grey),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: 10,
                  controller: _passwordController,
                  obscureText: !isPasswordHidden,
                  decoration: InputDecoration(
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
                        color: Colors.blueGrey,
                      ),
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    counterText: "",
                    hintText: "******",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Navigationscreen()));
                },
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 115, 6, 204),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                        child: Text(
                      "Log in",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 15,
              // ),
              // const Row(
              //   children: [
              //     Expanded(child: Divider()),
              //     Text(
              //       "    or connect with    ",
              //       style: TextStyle(color: Colors.grey),
              //     ),
              //     Expanded(child: Divider()),
              //   ],
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       height: 45,
              //       width: 170,
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(20)),
              //       child: Center(
              //         child: Row(
              //           children: [
              //             Padding(
              //                 padding: EdgeInsets.only(left: 25.0, right: 10),
              //                 child: Image.asset(
              //                   "lib/assets/icons/googlelogo.png",
              //                   scale: 2,
              //                 )),
              //             Text("Google")
              //           ],
              //         ),
              //       ),
              //     ),
              //     Container(
              //       height: 45,
              //       width: 170,
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(20)),
              //       child: Row(
              //         children: [
              //           Padding(
              //               padding: EdgeInsets.only(left: 30.0),
              //               child: Image.asset(
              //                 "lib/assets/icons/applelogo.png",
              //                 scale: 2,
              //               )),
              //           const Padding(
              //             padding: EdgeInsets.only(left: 7.0),
              //             child: Text(
              //               "Apple",
              //             ),
              //           )
              //         ],
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
