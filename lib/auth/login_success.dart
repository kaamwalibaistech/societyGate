import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_society/constents/sizedbox.dart';
import 'package:my_society/navigation_screen.dart';

class LoginSuccess extends StatelessWidget {
  const LoginSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("lib/assets/lottie_json/success.json",
                    repeat: false, height: 220),
                sizedBoxH30(context),
                Text(
                  "You're All Set!",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                sizedBoxH10(context),
                const Text(
                  textAlign: TextAlign.center,
                  "Start exploring, discovering, and engaging with the society facilities and amenities.",
                  style: TextStyle(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green.shade200),
                      child: const Text(
                        "Let's Go",
                        style: TextStyle(fontSize: 17, color: Colors.black87),
                      ),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Navigationscreen()));
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
