import 'package:flutter/material.dart';

import 'manual_visitors_form.dart';

class ManualVisitorsScreen extends StatefulWidget {
  const ManualVisitorsScreen({super.key});

  @override
  State<ManualVisitorsScreen> createState() => _ManualVisitorsScreenState();
}

class _ManualVisitorsScreenState extends State<ManualVisitorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManualVisitorsForm()));
            },
            child: Container(
                margin: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.amber),
                    color: Colors.amber.shade50,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          color: Colors.amber.shade100)
                    ]),
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width,
                child: const Center(child: Text("Add Manual Visitor"))),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 250.0),
            child: Text("No Visitors"),
          )
        ],
      ),
    );
  }
}
