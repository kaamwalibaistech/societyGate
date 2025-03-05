import 'package:flutter/material.dart';

<<<<<<<< HEAD:lib/auth/login_screen.dart
import '../navigation_screen.dart';
========
import '../../../navigation_screen.dart';
>>>>>>>> 9bbebaa4b45d8b734479d74538a72b049fbd4ce6:lib/features/auth/presentation/login_screen.dart

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
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
              height: 15,
            ),
            const Text(
              "Phone Numbers",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: _mobileNoController,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return "please enter numbers!";
                //   } else {
                //     return null;
                //   }
                // },
                decoration: const InputDecoration(
                  fillColor: Colors.white,
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
              "Password",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                  color: Theme.of(context).primaryColor,
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
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                      child: Text(
                    "Log in",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                Expanded(child: Divider()),
                Text(
                  "    or connect with    ",
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 10),
                            child: Image.asset(
                              "lib/assets/icons/googlelogo.png",
                              scale: 2,
                            )),
                        Text("Google")
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Image.asset(
                            "lib/assets/icons/applelogo.png",
                            scale: 2,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(left: 7.0),
                        child: Text(
                          "Apple",
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
