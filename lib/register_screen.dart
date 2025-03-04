import 'package:flutter/material.dart';

import 'features/auth/presentation/create_account.dart';
import 'features/auth/presentation/login_screen.dart';

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
                      builder: (context) => const CreateNewAccount()));
            },
            child: Container(
              height: 45,
              width: 250,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(
                  child: Text(
                "Register as a Society",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
    );
  }
}
