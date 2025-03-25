import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 19, 52, 84),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            "Privacy Policy",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(children: [
            Text(
                "At The Society Gate , we value your privacy and are committed to protecting the personal information that you share with us. This Privacy Policy explains the types of information we collect, how we use it, how we protect it, and the rights you have regarding your personal data. This policy applies to all users of The Society Gate mobile application (hereinafter referred to as 'the App') for Android devices. The App is designed to provide subscription-based services for managing and facilitating residential society operations."),
            Text(
                "By using The Society Gate App, you consent to the collection and use of your information as described in this Privacy Policy."),
            Text("")
          ]),
        ));
  }
}
