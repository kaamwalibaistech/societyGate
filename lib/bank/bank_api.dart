import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_gate/bank/bank_model.dart';

Future<RazorpayAccountModel?> getRouteAccount(String accountId) async {
  log(accountId);
  const username = "rzp_test_Kc0D3gsG5D09RJ";
  const password = "LcCmBfKtlajuiR9H2ruqRubl";
  final credentials = base64Encode(utf8.encode("$username:$password"));

  final response = await http.get(
    Uri.parse("https://api.razorpay.com/v2/accounts/$accountId"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Basic $credentials"
    },
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return RazorpayAccountModel.fromJson(data);
  } else {
    log(response.body);

    return null;
  }
}
