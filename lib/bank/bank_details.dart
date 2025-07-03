import 'dart:convert';
import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_gate/bank/bank_api.dart';
import 'package:society_gate/bank/bank_model.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/constents/sizedbox.dart';
import 'package:society_gate/dashboard/notice_board/notice_api.dart';

class BankDetailsPage extends StatelessWidget {
  final bool isPending;
  final RazorpayAccountModel? razorpayAccountModel;
  const BankDetailsPage(
      {super.key, required this.isPending, required this.razorpayAccountModel});

  @override
  Widget build(BuildContext context) {
    final account = razorpayAccountModel;
    final legal = account?.legalInfo;
    // final issPending = isPending;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Society Payment Account"),
        backgroundColor: isPending ? Colors.green : Colors.amber,
        foregroundColor: isPending ? Colors.white : Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: account == null
            ? Center(
                child: CircularProgressIndicator(
                color: isPending ? Colors.green : Colors.amber,
              ))
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DottedBorder(
                      borderPadding: const EdgeInsets.all(10),
                      color: isPending ? Colors.green : Colors.amber,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      strokeWidth: 2,
                      dashPattern: const [5, 3],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified_user,
                            color: isPending
                                ? Colors.green
                                : Colors.amber.shade700,
                          ),
                          const SizedBox(width: 8),
                          Text("Status: ${account.status}"),
                          const SizedBox(width: 12),
                          Chip(
                            label: Text(
                                account.live == true ? "Activated" : "Pending"),
                            backgroundColor: isPending
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            labelStyle: TextStyle(
                              color: isPending ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Legal & Contact Info
                    _infoTile("Business Name", account.legalBusinessName),
                    _infoTile("Customer Facing Name",
                        account.customerFacingBusinessName),
                    _infoTile("Contact Person", account.contactName),
                    _infoTile("Email", account.email),
                    _infoTile("Phone", account.phone),
                    _infoTile("PAN Number", legal?.pan),
                    _infoTile("GST Number", legal?.gst),
                    const SizedBox(height: 16),
                    _infoTile("Business Type",
                        account.businessType ?? "Not Provided"),
                    _infoTile("Category",
                        account.profile?.category ?? "Not Provided"),
                    _infoTile("PAN", account.legalInfo?.pan ?? "Not Provided"),
                    Text(_formatAddress(account.profile?.addresses)),
                    const SizedBox(height: 25),

                    /// Business Profile
                    Text(
                      "Business Profile",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isPending ? Colors.green : Colors.amber.shade700,
                      ),
                    ),
                    const Divider(),
                    _infoTile("Type", account?.type),
                    _infoTile("Business Type", account?.businessType),
                    _infoTile("Category",
                        account?.profile?.category ?? 'Not Provided'),
                    _infoTile("Subcategory",
                        account?.profile?.subcategory ?? 'Not Provided'),
                    const SizedBox(height: 25),

                    /// Address Section
                    Text(
                      "Registered Address",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isPending ? Colors.green : Colors.amber.shade700,
                      ),
                    ),
                    const Divider(),
                    Text(
                      _formatAddress(account?.profile?.addresses),
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isPending ? Colors.green : Colors.amber,
                        foregroundColor:
                            isPending ? Colors.white : Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   createRouteAccount();
                        // }
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit"),
                    ),

                    Visibility(
                      visible: !isPending,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.support_agent),
                          label: const Text("Support"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),

                            // padding: const EdgeInsets.symmetric(
                            //     vertical: 12, horizontal: ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  String _formatAddress(Map<String, dynamic>? addresses) {
    if (addresses == null || addresses['registered'] == null) {
      return "Not Available";
    }

    final reg = addresses['registered'];
    return "${reg['street1'] ?? ''}, ${reg['street2'] ?? ''},\n"
        "${reg['city'] ?? ''}, ${reg['state'] ?? ''} - ${reg['postal_code'] ?? ''}, ${reg['country'] ?? ''}";
  }

  Widget _infoTile(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.black54),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value ?? 'N/A',
                style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
