import 'package:flutter/material.dart';
<<<<<<< HEAD:lib/auth/register_screen.dart
import 'package:my_society/auth/register_member.dart';
import 'soceity_register.dart';
import 'login_screen.dart';
=======

import 'features/auth/presentation/create_account.dart';
import 'features/auth/presentation/login_screen.dart';
>>>>>>> 9bbebaa4b45d8b734479d74538a72b049fbd4ce6:lib/register_screen.dart

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f3fa),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
          ),
          const Center(
              child: Text(
            " Smart App",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          )),
          Center(
              child: Text(
            "Make Your Life Easy With MySociety",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 200,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
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
                Text("or"),
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
          ),
          const Spacer(),
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
                  text: TextSpan(
                      text: "Want to Register your Society?",
                      style: const TextStyle(color: Colors.blueGrey),
                      children: [
                    TextSpan(
                        text: " Register here!",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ))
                  ])),
            ),
          ),
        ],
      ),
    );
  }
}
