import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                // color: Colors.white,
              )),
          title: const Text(
            "Society Payments",
            // style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            labelPadding: EdgeInsets.all(15),
            indicatorPadding: EdgeInsets.symmetric(horizontal: 25),
            indicatorSize: TabBarIndicatorSize.tab,
            // controller: _tabController,
            tabs: [
              Text("Paid"),
              Text("Unpaid"),
              Text("Others"),
            ],
          ),
        ),
        body: const Column(
          children: [
            Expanded(
              child: TabBarView(children: [
                Text("Coming123456 Soon"),
                Text("Comingazsxdcfvgbhn Soon"),
                Text("Coming Soon"),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
