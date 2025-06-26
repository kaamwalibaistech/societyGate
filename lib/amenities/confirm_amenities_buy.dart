import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ConfirmAmenitiesBuy extends StatefulWidget {
  final List<Map<String, String>> selectedAmenitiesList;
  final double total;

  const ConfirmAmenitiesBuy({
    super.key,
    required this.selectedAmenitiesList,
    required this.total,
  });

  @override
  State<ConfirmAmenitiesBuy> createState() => _ConfirmAmenitiesBuyState();
}

class _ConfirmAmenitiesBuyState extends State<ConfirmAmenitiesBuy> {
  // bool isTermsAccepted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Bookings"),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: widget.selectedAmenitiesList.length,
                itemBuilder: (context, index) {
                  final item = widget.selectedAmenitiesList[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.room_preferences,
                          color: Colors.pink),
                      title: Text(
                        item['amenity_name'] ?? 'No name',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        "₹${item['amount'] ?? '0'} / ${item['duration'] ?? ''}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -1),
                      blurRadius: 5)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Amount:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      Text(
                        "₹${widget.total.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.payment,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Proceed to Pay",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          Razorpay razorpay = Razorpay();
                          var options = {
                            'key': 'rzp_test_Kc0D3gsG5D09RJ',
                            'amount': 20000,
                            'currency': 'INR',
                            'name': 'Acme Corp.',
                            'description': 'Amenity Booking',
                            // 'order_id': 'order_Qlhxs6KFORi5kU',
                            'order_id': 'order_QlmN1ijZm8xto8',
                            'retry': {'enabled': true, 'max_count': 2},
                            'send_sms_hash': true,
                            'prefill': {
                              'contact': '9892986314',
                              'email': 'test@razorpay.com',
                            },
                            'external': {
                              'wallets': ['paytm']
                            }
                          };
                          razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                              handlePaymentErrorResponse);
                          razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                              handlePaymentSuccessResponse);
                          razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                              handleExternalWalletSelected);
                          try {
                            razorpay.open(options);
                          } catch (e) {
                            EasyLoading.showToast(e.toString());
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.greenAccent,
                              content: Text(
                                "Proceeding to payment...",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Razor Pay Payment handles

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * Payment Failure Response contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    log("Payment successful");
    log("Order ID: ${response.orderId}");
    log("Payment ID: ${response.paymentId}");
    log("Signature: ${response.signature}");
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
