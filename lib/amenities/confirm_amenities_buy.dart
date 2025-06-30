import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:society_gate/amenities/amenities_payment_success.dart';
import 'package:society_gate/amenities/network/amenities_apis.dart';
import 'package:society_gate/amenities/user_amenities_page.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/models/amenities_buy_done.dart';
import 'package:society_gate/models/login_model.dart';
import 'package:society_gate/models/amenities_ceate_order.dart';

import 'amenities_purchase_failled.dart';

class ConfirmAmenitiesBuy extends StatefulWidget {
  final List<Map<String, String>> selectedAmenitiesList;
  final double total;

  const ConfirmAmenitiesBuy(
      {super.key, required this.selectedAmenitiesList, required this.total});

  @override
  State<ConfirmAmenitiesBuy> createState() => _ConfirmAmenitiesBuyState();
}

class _ConfirmAmenitiesBuyState extends State<ConfirmAmenitiesBuy> {
  LoginModel? loginModel;
  CreateOrderForAmenities? createOrderForAmenitiesModel;
  String finalAmenityIds = "";
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    String amenitiesId = "";
    for (var a in widget.selectedAmenitiesList) {
      amenitiesId = amenitiesId + "${a['amenity_id']}" + ",";
    }
    // setState(() {
    loginModel = LocalStoragePref().getLoginModel();
    finalAmenityIds =
        amenitiesId.replaceRange(amenitiesId.length - 1, null, "");
    // });
    log(finalAmenityIds);
  }

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
                        "₹${widget.total}",
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
                        onPressed: _createAmenitiesOrder),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Razorpay payment
  _createAmenitiesOrder() async {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     backgroundColor: Colors.greenAccent,
    //     content: Text(
    //       "Proceeding to payment...",
    //       style: TextStyle(color: Colors.black),
    //     ),
    //   ),
    // );

    try {
      EasyLoading.show();
      createOrderForAmenitiesModel = await createOrderForAmenitiesAmenities(
          widget.total.toString(),
          loginModel?.user?.societyId.toString() ?? "",
          loginModel?.user?.userId.toString() ?? "",
          finalAmenityIds);

      if (createOrderForAmenitiesModel?.status == true) {
        Razorpay razorpay = Razorpay();
        if (createOrderForAmenitiesModel != null) {
          var options = {
            'key': createOrderForAmenitiesModel?.key,
            'amount': createOrderForAmenitiesModel?.amount,
            'currency': createOrderForAmenitiesModel?.currency,
            'name': 'Society Gate',
            'description': 'Amenity Booking',
            'order_id': createOrderForAmenitiesModel?.orderId,
            'retry': {'enabled': true, 'max_count': 2},
            'send_sms_hash': true,
            'prefill': {
              'contact': loginModel?.user?.uphone,
              'email': loginModel?.user?.uemail,
            },
            'external': {
              'wallets': ['paytm']
            }
          };
          razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
          razorpay.on(
              Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
          razorpay.on(
              Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
          try {
            razorpay.open(options);
          } catch (e) {
            Fluttertoast.showToast(msg: e.toString());
          }
        } else {
          Fluttertoast.showToast(msg: "Something went wrong! try again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong! try again.");
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.toString());
    }
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

  Future<void> handlePaymentSuccessResponse(
      PaymentSuccessResponse response) async {
    try {
      BuyAmenitiesDone? buyAmenitiesDone = await buyAmenities(
          loginModel?.user?.userId.toString() ?? "",
          loginModel?.user?.societyId.toString() ?? "",
          finalAmenityIds);

      if (buyAmenitiesDone?.status == 200) {
        EasyLoading.show();
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AmenitiesPaymentSuccess(
              buyAmenitiesDone: buyAmenitiesDone,
              orderDetails: createOrderForAmenitiesModel,
              paymentId: response.paymentId,
              signature: response.signature,
            ),
          ),
        );
        /*  showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Amenities purchase Done"),
            content: Text(
                "Payment Successful,\nPayment ID: ${response.paymentId} ${buyAmenitiesDone?.message ?? ""}"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AmenitiesPaymentSuccess(
                          buyAmenitiesDone: buyAmenitiesDone,
                          orderDetails: createOrderForAmenitiesModel,
                          paymentId: response.paymentId,
                          signature: response.signature,
                        ),
                      ),
                    );
                  },
                  child: const Text("Check Amenities"))
            ],
          ),
        );*/
      } else {
        Fluttertoast.showToast(msg: "Amenities purchase failled!");
        EasyLoading.show();
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AmenitiesPurchaseFailedPage(
              paymentId: response.paymentId,
              orderId: response.orderId,
              orderDetails: createOrderForAmenitiesModel,
            ),
          ),
        );
      }

      // showAlertDialog(context, "Payment Successful",
      //     "Payment ID: ${response.paymentId} ${buyAmenitiesDone?.message ?? ""}");
      // Future.delayed(Durations.medium4);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

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
