import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:society_gate/api/api_constant.dart';
import 'package:society_gate/models/amenities_buy_done.dart';
import 'package:society_gate/models/amenities_ceate_order.dart';

Future<CreateOrderForAmenities?> createOrderForAmenitiesAmenities(
  String amount,
  String societyId,
  String userId,
  String amenities,
) async {
  String api = ApiConstant.createOrderForAmenitiesAmenities;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);
  final body = {
    'amount': amount,
    'society_id': societyId,
    'user_id': userId,
    'amenities[]': amenities,
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // log("Api DATA: ${data.toString()}");
      return CreateOrderForAmenities.fromJson(data);
      // return data[0];
    } else {
      log("error");
    }
  } catch (e) {
    throw Exception(e.toString());
  }
  return null;
}

Future<BuyAmenitiesDone?> buyAmenities(
  String userId,
  String societyId,
  String amenities,
) async {
  String api = ApiConstant.amenitiesBookbyUser;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);
  final body = {
    'user_id': userId,
    'society_id': societyId,
    'amenity_ids[]': amenities,
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      log("Api BUY AMENITIES DATA: ${data.toString()}");
      return BuyAmenitiesDone.fromJson(data);
    } else {
      log("error");
      log("buyAmenitiesDone response: ${response.body.toString()}");
    }
  } catch (e) {
    throw Exception(e.toString());
  }
  return null;
}
