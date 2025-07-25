import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/constents/date_format.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/constents/sizedbox.dart';
import 'package:society_gate/dashboard/payments_screen/bloc/payments_bloc.dart';
import 'package:society_gate/dashboard/payments_screen/maintainence_invoice.dart';
import 'package:society_gate/models/login_model.dart';
import 'package:society_gate/models/paid_maintainence_model.dart';
import 'package:society_gate/models/unpaid_maintainence_mdel.dart';
import 'package:society_gate/models/unpaid_maintainence_order_model.dart';

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
  dynamic fineIds;
  // dynamic date;

  void handleExternalWalletSelected(ExternalWalletResponse response) {}

  Future<void> handlePaymentSuccessResponse(
      PaymentSuccessResponse response) async {
    paymentId = response.paymentId ?? "N/A";
    await ApiRepository().updateMaintainenceStatus(
      createOrder?.orderId ?? "",
      paymentId ?? "",
    );
    setState(() {
      totalPayment = 0.00;
    });
    BlocProvider.of<PaymentsBloc>(context).add(UnpaidPaymentsEvent(
        societyId: locaData?.user?.societyId.toString() ?? "",
        userId: locaData?.user?.userId.toString() ?? ""));
    // BlocProvider.of<PaymentsBloc>(context).add(PaidPaymentsEvent(
    //     societyId: locaData?.user?.societyId.toString() ?? "",
    //     userId: locaData?.user?.userId.toString() ?? ""));
    Fluttertoast.showToast(
      msg: "Payment Successful!\nPayment ID: $paymentId",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  void openCheckOut(price) async {
    EasyLoading.dismiss();

    var options = {
      'key': 'rzp_test_Kc0D3gsG5D09RJ',
      'order_id': createOrder?.orderId.toString() ?? "",

      'name': 'Society Gate',
      'send_sms_hash': true,
      // 'description': ,
      'prefill': {
        'contact': locaData?.user?.uphone,
        'email': locaData?.user?.uemail
      }
    };
    try {
      _razorpay.open(options);
      log("Opened");
      EasyLoading.dismiss();
    } catch (e) {
      print('erroe $e');
      EasyLoading.dismiss();
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
  double totalPayment = 0.00;
  bool isChecked = false;

  late TabController _tabController;

  UnPaidMaintainenceOrderModel? createOrder;
  UnPaidMaintainenceModel? newUnpaidData;
  // UnPaidMaintainenceModel? newPaidData;

  List<String> selectedMaintainenceIds = [];
  List<String> selectedFineIds = [];

  // getUnpaidData() async {

  //   unpaidData = await ApiRepository().getUnpaidMaintainence(
  //       locaData?.user?.societyId.toString(),
  //       locaData?.user?.userId.toString());
  // }

  LoginModel? locaData;

  String getMaintainenceIds() {
    String dataa = "";
    for (String a in selectedMaintainenceIds) {
      dataa += "$a,";
    }
    // log(" Maintainence Ids Before trimed:  $dataa");
    if (dataa.isNotEmpty) {
      log("Maintainence Ids ${dataa.replaceRange(dataa.length - 1, dataa.length, "")}");
      return dataa.replaceRange(dataa.length - 1, dataa.length, "");
    } else {
      return "";
    }
  }

  String getFineIds() {
    String dataa = "";
    for (String a in selectedFineIds) {
      dataa += "$a,";
    }
    // log("Fine Ids Before trimed:  $dataa");
    if (dataa.isNotEmpty) {
      log("Fine Ids ${dataa.replaceRange(dataa.length - 1, dataa.length, "")}");
      return dataa.replaceRange(dataa.length - 1, dataa.length, "");
    } else {
      return "";
    }
  }

  late PaymentsBloc _paymentBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onChange);

    locaData = LocalStoragePref().getLoginModel();
    BlocProvider.of<PaymentsBloc>(context).add(UnpaidPaymentsEvent(
        societyId: locaData?.user?.societyId.toString() ?? "",
        userId: locaData?.user?.userId.toString() ?? ""));
    // BlocProvider.of<PaymentsBloc>(context).add(PaidPaymentsEvent(
    //     societyId: locaData?.user?.societyId.toString() ?? "",
    //     userId: locaData?.user?.userId.toString() ?? ""));

    _razorpay = Razorpay();
    _paymentBloc = BlocProvider.of<PaymentsBloc>(context);
  }

  void _onChange() {
    if (_tabController.index == 0) {
      BlocProvider.of<PaymentsBloc>(context).add(UnpaidPaymentsEvent(
          societyId: locaData?.user?.societyId.toString() ?? "",
          userId: locaData?.user?.userId.toString() ?? ""));
    } else {
      totalPayment = 0.00;
      BlocProvider.of<PaymentsBloc>(context).add(UnpaidPaymentsEvent(
          societyId: locaData?.user?.societyId.toString() ?? "",
          userId: locaData?.user?.userId.toString() ?? ""));
    }
  }

  int totalUnpaid = 0;

  int totalUnpaidLength = 0;
  int totalPaidLength = 0;
  int totalPaid = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Society Payments"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "Unpaid"),
            Tab(text: "Paid"),
            // Tab(text: "Unpaid (${totalUnpaid ?? 0})"),
            // Tab(text: "Paid(${totalPaid ?? 0}) "),
          ],
        ),
      ),
      body: BlocConsumer<PaymentsBloc, PaymentsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PaymentsFullyLoadedState) {
              return TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildUnpaidPaymentList(state.unPaidFines ?? []),
                        _buildUnpaidMaintainencePaymentList(
                            state.unPaidMaintenance ?? []),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildPaidPaymentList(state.paidFines ?? []),
                        _buildPaidMaintainencePaymentList(
                            state.paidMaintenance ?? []),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      bottomNavigationBar: newUnpaidData == null
          ? SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: totalPayment > 0.00,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                            "Payment Selected for Rs. ${totalPayment.toStringAsFixed(2)}"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  totalUnpaid == 0
                      ? const SizedBox.shrink()
                      : _tabController.index == 0
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    EasyLoading.show();

                                    maintainenceIds = getMaintainenceIds();
                                    fineIds = getFineIds();

                                    if (totalPayment < 1.0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Please select at least one Payment."),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          showCloseIcon: true,
                                        ),
                                      );
                                      EasyLoading.dismiss();
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
                                            fineIds,
                                            // totalPayment.toStringAsFixed(2),
                                            locaData?.user?.flatId.toString() ??
                                                "");

                                    if (createOrder?.orderId != null) {
                                      openCheckOut(totalPayment.toString());

                                      _razorpay.on(
                                          Razorpay.EVENT_PAYMENT_SUCCESS,
                                          handlePaymentSuccessResponse);
                                      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                                          handlePaymentErrorResponse);
                                      _razorpay.on(
                                          Razorpay.EVENT_EXTERNAL_WALLET,
                                          handleExternalWalletSelected);
                                    } else {
                                      EasyLoading.dismiss();
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
                                  icon: const Icon(Icons.payment_outlined),
                                  label: const Text("Pay ",
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                  sizedBoxH10(context)
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildUnpaidPaymentList(List<UnFine> unPaidFines) {
    totalUnpaidLength = unPaidFines.length;
    return unPaidFines.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: unPaidFines.length,
            itemBuilder: (context, index) {
              final unpaidList = unPaidFines;
              final date = formatDate(unPaidFines[index].fineDate.toString());

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 0,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green.shade50,
                    child: Checkbox(
                      activeColor: Colors.green,
                      splashRadius: 50,
                      shape: const CircleBorder(),
                      side: BorderSide(
                        color: Colors.green.shade300,
                        width: 2,
                      ),
                      value: unpaidList[index].isChecked ?? false,
                      onChanged: (value) {
                        setState(() {
                          unpaidList[index].isChecked = value ?? false;

                          final a = unpaidList[index].fineAmount ?? 0.0;
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
                            selectedFineIds
                                .add(unpaidList[index].fineId.toString());
                          } else {
                            selectedFineIds
                                .remove(unpaidList[index].fineId.toString());
                          }
                        });
                      },
                    ),
                  ),
                  title: Text(
                    unpaidList[index].fineTitle.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text("DueDate : $date"),
                  trailing: Text(
                    '₹${unpaidList[index].fineAmount.toString()}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          )
        : const SizedBox.shrink();
  }

  Widget _buildUnpaidMaintainencePaymentList(
      List<UnMaintenance> newUnpaidData) {
    totalUnpaid = totalUnpaidLength + newUnpaidData.length;

    return newUnpaidData.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: newUnpaidData.length ?? 0,
            itemBuilder: (context, index) {
              final unpaidList = newUnpaidData ?? [];
              final date = formatDate(newUnpaidData[index].date.toString());

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 0,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green.shade50,
                    child: Checkbox(
                      activeColor: Colors.green,
                      splashRadius: 50,
                      shape: const CircleBorder(),
                      side: BorderSide(
                        color: Colors.green.shade300,
                        width: 2,
                      ),
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
                            selectedMaintainenceIds.add(
                                unpaidList[index].maintenanceId.toString());
                          } else {
                            selectedMaintainenceIds.remove(
                                unpaidList[index].maintenanceId.toString());
                          }
                        });
                      },
                    ),
                  ),
                  title: Text(
                    unpaidList[index].type.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text("Due date: $date"),
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
        : totalUnpaid == 0
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 300.0),
                child: Text("No Unpaid Payments"),
              )
            : const SizedBox.shrink();
  }

  Widget _buildError(String msg) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "lib/assets/empty.jpg",
              scale: 10,
            ),
          ),
        ),
        Text("No Payments history! \n $msg")
      ],
    );
  }

  _buildPaidPaymentList(List<Fine> newPaidData) {
    totalPaidLength = newPaidData.length;
    return newPaidData.isNotEmpty == true
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: newPaidData.length,
            itemBuilder: (context, index) {
              final paidList = newPaidData;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
                              paidList[index].fineTitle ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Fine date :  ${formatDate(paidList[index].fineDate.toString())}",
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
                            paidList[index].fineAmount ?? "",
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: () async {
                              EasyLoading.show(status: "Loading Invoice...");
                              generateInvoicePdf(
                                // invoiceNumber: "INV-2025-0001",
                                customerName: locaData?.user?.uname ?? "",
                                contact: locaData?.user?.uphone ?? "",
                                email: locaData?.user?.uemail ?? "",
                                societyName: locaData?.user?.societyName ?? "",
                                block: locaData?.user?.block ?? "",
                                flatNo: locaData?.user?.flatNumber ?? "",
                                paymentDate:
                                    paidList[index].fineDate.toString(),
                                paymentMode: "UPI",
                                paidAmount:
                                    paidList[index].fineAmount.toString(),
                                fineType: paidList[index].fineTitle.toString(),
                                paymentId: paymentId.toString(),
                                orderId: createOrder?.orderId.toString() ?? "",
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
        : const SizedBox.shrink();
  }

  _buildPaidMaintainencePaymentList(List<Maintenance> newPaidData) {
    totalPaid = totalPaidLength + newPaidData.length;

    return newPaidData.isNotEmpty == true
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: newPaidData.length,
            itemBuilder: (context, index) {
              final paidList = newPaidData;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
                              formatDate(paidList[index].date.toString() ?? ""),
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
                              EasyLoading.show(status: "Loading Invoice...");
                              generateInvoicePdf(
                                // invoiceNumber: "INV-2025-0001",
                                customerName: locaData?.user?.uname ?? "",
                                contact: locaData?.user?.uphone ?? "",
                                email: locaData?.user?.uemail ?? "",
                                societyName: locaData?.user?.societyName ?? "",
                                block: locaData?.user?.block ?? "",
                                flatNo: locaData?.user?.flatNumber ?? "",
                                paymentDate: paidList[index].date.toString(),
                                paymentMode: "UPI",
                                paidAmount:
                                    paidList[index].totalAmount.toString(),
                                fineType: paidList[index].type.toString(),
                                paymentId: paymentId.toString(),
                                orderId: createOrder?.orderId.toString() ?? "",
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
        : totalPaid == 0
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 300.0),
                child: Text(
                  "No Paid Payments",
                  style: TextStyle(),
                ),
              )
            : const SizedBox.shrink();
  }
}
