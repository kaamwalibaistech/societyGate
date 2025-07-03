import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/models/unpaid_maintainence_mdel.dart';
import 'package:society_gate/payments_screen/bloc/payments_bloc.dart';

class SocietyPaymentsScreen extends StatefulWidget {
  const SocietyPaymentsScreen({super.key});

  @override
  State<SocietyPaymentsScreen> createState() => _SocietyPaymentsScreenState();
}

class _SocietyPaymentsScreenState extends State<SocietyPaymentsScreen>
    with TickerProviderStateMixin {
  //payment logic
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

  //payment logic

  String? dataLength;
  double totalPayment = 0.0;
  bool isChecked = false;

  late TabController _tabController;
  // double getSelectedTotal() {
  //   return unpaidList
  //       .where((item) => item['selected'] == true)
  //       .fold(0.0, (sum, item) => sum + (item['amount'] as num));
  // }

  // final List<Map<String, dynamic>> unpaidList = [
  //   {
  //     'id': 'Society Fine',
  //     'amount': 1000,
  //     'date': 'May 30, 2025 12:03',
  //     'selected': false,
  //   },
  //   {
  //     'id': 'maintenance',
  //     'amount': 7000,
  //     'date': 'April 30, 2025 17:32',
  //     'selected': false,
  //   },
  // ];

  //Api calling for unpaid
  UnPaidMaintainenceModel? unpaidData;

  getUnpaidData() async {
    final locaData = LocalStoragePref().getLoginModel();
    unpaidData = await ApiRepository().getUnpaidMaintainence(
        locaData?.user?.societyId.toString(),
        locaData?.user?.userId.toString());
  }

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
    final locaData = LocalStoragePref().getLoginModel();
    BlocProvider.of<PaymentsBloc>(context).add(PaymentsEvent(
        societyId: locaData?.user?.societyId.toString() ?? "",
        userId: locaData?.user?.userId.toString() ?? ""));
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
            Tab(text: "Unpaid (${dataLength ?? 0})"),
            Tab(text: "Paid (${paidList.length})"),
          ],
        ),
      ),
      // Inside TabBarView:
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUnpaidPaymentList(),
          _buildPaidPaymentList(),
        ],
      ),

      bottomNavigationBar: unpaidData?.data == null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (totalPayment > 0.0)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text("Payment Selected for Rs. $totalPayment"
                            // '${unpaidList.where((e) => e['selected'] == true).length} Payments selected for Rs. ${getSelectedTotal().toStringAsFixed(2)}',
                            // style: const TextStyle(
                            //     color: Colors.green, fontWeight: FontWeight.w600),
                            ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  dataLength == null
                      ? const SizedBox.shrink()
                      : SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              if (totalPayment < 1.0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Please select at least one Payment."),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              final price = totalPayment;

                              openCheckOut(price.toString());
                              _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                                  handlePaymentSuccessResponse);
                              _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                                  handlePaymentErrorResponse);
                              _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                  handleExternalWalletSelected);

                              // Add payment logic for selected
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text("Pay All",
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildUnpaidPaymentList() {
    return BlocConsumer<PaymentsBloc, PaymentsState>(
      listener: (context, state) {
        if (state is PaymentsLoadedState) {
          setState(() {
            dataLength = state.unpaidData?.data?.length.toString();
          });
        }
      },
      // bloc: PaymentsBloc(),
      buildWhen: (previous, current) =>
          current is PaymentsLoadedState || current is PaymentsLoading,
      builder: (context, state) {
        if (state is PaymentsLoadedState) {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.unpaidData?.data?.length,
            itemBuilder: (context, index) {
              final item = unpaidData?.data?[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Checkbox(
                    value: state.unpaidData?.data![index].isChecked ?? false,
                    onChanged: (value) {
                      setState(() {
                        state.unpaidData?.data![index].isChecked =
                            value ?? false;

                        final a =
                            state.unpaidData?.data![index].totalAmount ?? 0.0;
                        final double amount = (a is num)
                            ? a.toDouble()
                            : double.tryParse(a.toString()) ?? 0.0;
                        if (value == true) {
                          totalPayment += amount;
                        } else {
                          totalPayment -= amount;
                        }

                        log("Total Payment: $totalPayment");
                      });
                    },
                  ),
                  title: Text(
                    state.unpaidData?.data![index].type.toString() ?? "",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    state.unpaidData?.data![index].date.toString() ?? "",
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${state.unpaidData?.data![index].totalAmount.toString() ?? ""}',
                        style: const TextStyle(
                          color: Colors.red,
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
              );
            },
          );
        } else if (state is PaymentsFailed) {
          return const Center(child: Text("No Unpaid Payments"));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildPaidPaymentList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: paidList.length,
      itemBuilder: (context, index) {
        final item = paidList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: Text(
              item['id'],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(item['date']),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${item['amount']}',
                  style: const TextStyle(
                    color: Colors.grey,
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
        );
      },
    );
  }
}
