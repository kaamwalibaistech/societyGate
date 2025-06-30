import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/payments_screen/paid_bills_detail_screen.dart';

class SocietyPaymentsScreen extends StatefulWidget {
  const SocietyPaymentsScreen({super.key});

  @override
  State<SocietyPaymentsScreen> createState() => _SocietyPaymentsScreenState();
}

class _SocietyPaymentsScreenState extends State<SocietyPaymentsScreen>
    with TickerProviderStateMixin {
  late Razorpay _razorpay;

  void handleExternalWalletSelected(ExternalWalletResponse response) {}

  Future<void> handlePaymentSuccessResponse(
      PaymentSuccessResponse response) async {
    String paymentId = response.paymentId ?? "N/A";

    Fluttertoast.showToast(
      msg: "Payment Successful!\nPayment ID: $paymentId",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  void openCheckOut(String price) async {
    final data = LocalStoragePref().getLoginModel();
    var options = {
      'key': 'rzp_test_Kc0D3gsG5D09RJ',
      'amount': double.parse(price) * 100,
      'name': 'Society Gate',
      'send_sms_hash': true,
      // 'description': ,
      'prefill': {'contact': data?.user?.uphone, 'email': data?.user?.uemail}
    };
    try {
      _razorpay.open(options);
      log("Opened");
    } catch (e) {
      print('erroe $e');
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    String errorMessage = "Payment Failed";

    try {
      // Extract details from the response
      int? code = response.code;
      String? message = response.message;

      errorMessage = "Error Code: $code\nMessage: $message";
      Fluttertoast.showToast(msg: errorMessage);
    } catch (e) {
      throw (e.toString());
    }
  }

  late TabController _tabController;
  double getSelectedTotal() {
    return unpaidList
        .where((item) => item['selected'] == true)
        .fold(0.0, (sum, item) => sum + (item['amount'] as num));
  }

  final List<Map<String, dynamic>> unpaidList = [
    {
      'id': 'Society Fine',
      'amount': 1000,
      'date': 'May 30, 2025 12:03',
      'selected': false,
    },
    {
      'id': 'maintenance',
      'amount': 7000,
      'date': 'April 30, 2025 17:32',
      'selected': false,
    },
  ];

  final List<Map<String, dynamic>> paidList = [
    {
      'id': 'maintenance',
      'amount': 7000,
      'date': 'Jan 15, 2024 09:15',
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _razorpay = Razorpay();
  }

  @override
  Widget build(BuildContext context) {
    // double totalDue =
    //     unpaidList.fold(0, (sum, item) => sum + (item['amount'] as num));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Society Payments"),
        backgroundColor: const Color(0xFF002366),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: "Unpaid (${unpaidList.length})"),
            Tab(text: "Paid (${paidList.length})"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPaymentList(unpaidList, unpaid: true),
          _buildPaymentList(paidList, unpaid: false),
        ],
      ),
      bottomNavigationBar: unpaidList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (getSelectedTotal() > 0)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${unpaidList.where((e) => e['selected'] == true).length} Payments selected for Rs. ${getSelectedTotal().toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        final selected = unpaidList
                            .where((item) => item['selected'] == true)
                            .toList();
                        if (selected.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Please select at least one Payment."),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final price = getSelectedTotal();

                        openCheckOut(price.toString());
                        _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                            handlePaymentSuccessResponse);
                        _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                            handlePaymentErrorResponse);
                        _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                            handleExternalWalletSelected);

                        // Add payment logic for selected
                        print("Proceed to pay ${getSelectedTotal()}");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                          const Text("Pay All", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildPaymentList(List<Map<String, dynamic>> list,
      {required bool unpaid}) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final price = list[index];

        return GestureDetector(
          onTap: () {
            unpaid
                ? null
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaidBillsDetailScreen()));
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: unpaid
                  ? Checkbox(
                      value: price['selected'] ?? false,
                      onChanged: (value) {
                        setState(() {
                          price['selected'] = value;
                        });
                      },
                    )
                  : const Icon(Icons.check_circle, color: Colors.green),
              title: Text(
                price['id'],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(price['date']),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${price['amount']}',
                    style: TextStyle(
                      color: unpaid ? Colors.red : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Icon(Icons.arrow_forward_ios,
                      size: 14, color: Colors.grey),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
