import 'package:flutter/material.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Image.asset("lib/assets/empty.jpg"),
        ),
        const Text("We are working on this feature")
      ],
    ));
  }
}
