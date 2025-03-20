import 'package:flutter/material.dart';
import 'package:my_society/auth/register_member.dart';
import 'package:my_society/constents/sizedbox.dart';

import 'login_screen.dart';
import 'soceity_register.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.46),
          height: double.infinity,
          width: double.infinity,
          //  child: Image.asset('lib/assets/girlphoto.jpg',
          child: Image.asset('lib/assets/girlphoto1.jpg',
              //   child: Image.asset('lib/assets/girlphoto2.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Column(
              children: [
                const Center(
                    child: Text(
                  " Society Gate",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
                sizedBoxH5(context),
                const Center(
                    child: Text(
                  "Make Your Life Easy With Society Gate!",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.w400),
                )),
                const SizedBox(
                  height: 55,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: Container(
                    height: 45,
                    width: 250,
                    decoration: BoxDecoration(
                        color: const Color(0xffFAF9FE),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      "Log in",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(),
                      )),
                      Text(
                        "or",
                        style: TextStyle(color: Colors.white60),
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(),
                      ))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterMember()));
                  },
                  child: Container(
                    height: 45,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                        child: Text(
                      "Register as a Member",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SocietyRegister()));
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: RichText(
                        text: const TextSpan(
                            text: "Want to Register your Society?",
                            style: TextStyle(color: Colors.white70),
                            children: [
                          TextSpan(
                              text: " Register here!",
                              style: TextStyle(color: Colors.white))
                        ])),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
