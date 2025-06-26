import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:society_gate/api/api_constant.dart';
import 'package:society_gate/models/order.dart';

Future<CreateOrder?> createOrderAmenities(
  String amount,
  String societyId,
  String userId,
) async {
  String api = ApiConstant.createorderAmenities;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);
  final body = {
    'amount': amount,
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      log("Api DATA: ${data.toString()}");
      return CreateOrder.fromJson(data);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
  return null;
}
