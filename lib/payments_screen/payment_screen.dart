import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/maintainence_invoice.dart';
import 'package:society_gate/models/login_model.dart';
import 'package:society_gate/models/unpaid_maintainence_mdel.dart';
import 'package:society_gate/models/unpaid_maintainence_order_model.dart';
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
  String? paymentId;
  dynamic maintainenceIds;
  dynamic date;

  void handleExternalWalletSelected(ExternalWalletResponse response) {}

  Future<void> handlePaymentSuccessResponse(
      PaymentSuccessResponse response) async {
    paymentId = response.paymentId ?? "N/A";
    final status = await ApiRepository().updateMaintainenceStatus(
      locaData?.user?.societyId.toString() ?? "",
      locaData?.user?.userId.toString() ?? "",
      locaData?.user?.flatId.toString() ?? "",
      paymentId ?? "",
      maintainenceIds,
    );
    setState(() {
      totalPayment = 0.0;
    });
    BlocProvider.of<PaymentsBloc>(context).add(PaymentsEvent(
        societyId: locaData?.user?.societyId.toString() ?? "",
        userId: locaData?.user?.userId.toString() ?? ""));

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
      'order_id': createOrder?.orderId.toString() ?? "",
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

      Fluttertoast.showToast(msg: errorMessage);
    } catch (e) {
      throw (e.toString());
    }
  }

  //payment logic

  String? unpaidDataLength;
  String? paidDataLength;
  double totalPayment = 0.0;
  bool isChecked = false;

  late TabController _tabController;

  UnPaidMaintainenceOrderModel? createOrder;
  UnPaidMaintainenceModel? unpaidData;
  List<String> selectedMaintainenceIds = [];

  // getUnpaidData() async {

  //   unpaidData = await ApiRepository().getUnpaidMaintainence(
  //       locaData?.user?.societyId.toString(),
  //       locaData?.user?.userId.toString());
  // }

  LoginModel? locaData;

  String getMaintainenceIds() {
    String anil = "";
    for (String a in selectedMaintainenceIds) {
      anil += "$a,";
    }
    log("Before trimed:  $anil");
    if (anil.isNotEmpty) {
      log(anil.replaceRange(anil.length - 1, anil.length, ""));
      return anil.replaceRange(anil.length - 1, anil.length, "");
    } else {
      return "";
    }
  }

  late PaymentsBloc _paymentBloc;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onChange);

    locaData = LocalStoragePref().getLoginModel();
    BlocProvider.of<PaymentsBloc>(context).add(PaymentsEvent(
        societyId: locaData?.user?.societyId.toString() ?? "",
        userId: locaData?.user?.userId.toString() ?? ""));
    super.initState();
    _razorpay = Razorpay();
    _paymentBloc = BlocProvider.of<PaymentsBloc>(context);
  }

  void _onChange() {
    if (_tabController.indexIsChanging) return;
    if (_tabController.index == 0) {
      BlocProvider.of<PaymentsBloc>(context).add(PaymentsEvent(
          societyId: locaData?.user?.societyId.toString() ?? "",
          userId: locaData?.user?.userId.toString() ?? ""));
    } else {
      BlocProvider.of<PaymentsBloc>(context).add(PaymentsEvent(
          societyId: locaData?.user?.societyId.toString() ?? "",
          userId: locaData?.user?.userId.toString() ?? ""));
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Tab(text: "Unpaid (${unpaidDataLength ?? 0})"),
            Tab(text: "Paid(${paidDataLength ?? 0}) "),
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
          ? SafeArea(
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
                        child: Text("Payment Selected for Rs. $totalPayment"),
                      ),
                    ),
                  const SizedBox(height: 10),
                  unpaidDataLength == null
                      ? const SizedBox.shrink()
                      : _tabController.index == 0
                          ? SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () async {
                                  maintainenceIds = getMaintainenceIds();

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

                                  createOrder = await ApiRepository()
                                      .unpaidMaintainenceOrder(
                                          locaData?.user?.societyId
                                                  .toString() ??
                                              "",
                                          locaData?.user?.userId.toString() ??
                                              "",
                                          // selectedMaintainenceIds,
                                          maintainenceIds,
                                          totalPayment.toString(),
                                          locaData?.user?.flatId.toString() ??
                                              "");

                                  final price = totalPayment;
                                  if (createOrder?.orderId != null) {
                                    openCheckOut(price.toString());
                                    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                                        handlePaymentSuccessResponse);
                                    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                                        handlePaymentErrorResponse);
                                    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                        handleExternalWalletSelected);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Something went Wrong");
                                  }

                                  // Add payment logic for selected
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Pay ",
                                    style: TextStyle(fontSize: 16)),
                              ),
                            )
                          : const SizedBox.shrink()
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildUnpaidPaymentList() {
    return BlocConsumer<PaymentsBloc, PaymentsState>(
      // bloc: _paymentBloc,
      listener: (context, state) {
        if (state is PaymentsUNPaidLoadedState) {
          setState(() {
            unpaidDataLength = state.unpaidData?.length.toString() ?? "0";
          });
        }
      },

      builder: (context, state) {
        if (state is PaymentsUNPaidLoadedState) {
          return state.unpaidData?.length != 0
              ? ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.unpaidData?.length ?? 0,
                  itemBuilder: (context, index) {
                    final unpaidList = state.unpaidData ?? [];
                    date = state.unpaidData?[index].date;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: Checkbox(
                          value: unpaidList[index].isChecked ?? false,
                          onChanged: (value) {
                            setState(() {
                              unpaidList[index].isChecked = value ?? false;

                              final a = unpaidList[index].totalAmount ?? 0.0;
                              final double amount = (a is num)
                                  ? a.toDouble()
                                  : double.tryParse(a.toString()) ?? 0.0;
                              if (value == true) {
                                totalPayment += amount;
                              } else {
                                totalPayment -= amount;
                              }

                              log("Total Payment: $totalPayment");
                              if (value == true) {
                                selectedMaintainenceIds
                                    .add(unpaidList[index].id.toString());
                              } else {
                                selectedMaintainenceIds
                                    .remove(unpaidList[index].id.toString());
                              }
                            });
                          },
                        ),
                        title: Text(
                          unpaidList[index].type.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          unpaidList[index].date.toString(),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '₹${unpaidList[index].totalAmount.toString()}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            // const SizedBox(height: 8),
                            // const Icon(Icons.arrow_forward_ios,
                            //     size: 14, color: Colors.grey),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text("No Unpaid Payments"));
        } else if (state is PaymentsFailed) {
          return const Center(child: Text("No Unpaid Payments"));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _buildPaidPaymentList() {
    return BlocConsumer(
      bloc: _paymentBloc,
      listener: (context, state) {
        if (state is PaymentsPaidLoadedState) {
          setState(() {
            paidDataLength = state.paidData?.length.toString() ?? "0";
          });
        }
      },
      buildWhen: (previous, current) =>
          previous is PaymentsUNPaidLoadedState ||
          previous is PaymentsLoading ||
          current is PaymentsPaidLoadedState,
      builder: (context, state) {
        if (state is PaymentsPaidLoadedState) {
          return state.paidData?.isNotEmpty == true
              ? ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.paidData?.length,
                  itemBuilder: (context, index) {
                    final paidList = state.paidData ?? [];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: Colors.grey.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.green.withOpacity(0.1),
                              child: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    paidList[index].type ?? "",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    paidList[index].date ?? "",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  paidList[index].totalAmount ?? "",
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                GestureDetector(
                                  onTap: () async {
                                    EasyLoading.show(
                                        status: "Loading Invoice...");
                                    generateInvoicePdf(
                                      // invoiceNumber: "INV-2025-0001",
                                      customerName: locaData?.user?.uname ?? "",
                                      contact: locaData?.user?.uphone ?? "",
                                      email: locaData?.user?.uemail ?? "",
                                      societyName:
                                          locaData?.user?.societyName ?? "",
                                      block: locaData?.user?.block ?? "",
                                      flatNo: locaData?.user?.flatNumber ?? "",
                                      paymentDate:
                                          paidList[index].date.toString(),
                                      paymentMode: "UPI",
                                      paidAmount: paidList[index]
                                          .totalAmount
                                          .toString(),
                                      fineType: paidList[index].type.toString(),
                                    );
                                  },
                                  child: const Text(
                                    "Invoice",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "No Paid Payments",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
        } else if (state is PaymentsFailed) {
          return const Center(
            child: Text(
              "Failed to load paid payments",
              style: TextStyle(fontSize: 16, color: Colors.redAccent),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
