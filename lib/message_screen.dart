import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Image.asset("lib/assets/working.jpeg"),
        ),
        const Text("We are working on this feature")
      ],
    ));
  }
}
