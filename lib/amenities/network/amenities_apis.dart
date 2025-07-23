import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:society_gate/api/api_constant.dart';
import 'package:society_gate/models/amenities_buy_done.dart';
import 'package:society_gate/models/amenities_ceate_order.dart';
import 'package:society_gate/models/amenities_model.dart';
import 'package:society_gate/models/get_user_purchase_amenities_model.dart';

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
      final Map<String, dynamic> data = jsonDecode(response.body);
      return CreateOrderForAmenities.fromJson(data);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<BuyAmenitiesDone?> buyAmenities(
  String userId,
  String societyId,
  String amenities,
  String paymentId,
) async {
  String api = ApiConstant.amenitiesBookbyUser;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);
  final body = {
    'society_id': societyId,
    'user_id': userId,
    'amenities[]': amenities,
    'payment_id': paymentId,
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

Future<AmenitiesModel?> fetchAmenities(societyid) async {
  String api = ApiConstant.getAmenityForSociety;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);
  final body = {
    'society_id': societyid.toString(),
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      log("Api DATA: ${data.toString()}");
      return AmenitiesModel.fromJson(data);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
  return null;
}

Future<GetUserPurchaseAmenitiesModel?> getUserPurchaseAmenities(
    societyId, userId) async {
  String api = ApiConstant.getAmenityByUserId;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);
  final body = {
    'user_id': userId,
    'society_id': societyId,
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == 200) {
        return GetUserPurchaseAmenitiesModel.fromJson(data);
      }
      return GetUserPurchaseAmenitiesModel.fromJson(data);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
  return null;
}

Future<Map<String, dynamic>?> editAmenitiesApi(
  String societyId,
  String amenityId,
  String name,
  String amount,
  String duration,
) async {
  String api = ApiConstant.editAmenity;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);
  final body = {
    'society_id': societyId,
    'amenity_id': amenityId,
    'name': name,
    'amount': amount,
    'duration': duration,
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
  return null;
}

Future<Map<String, dynamic>?> deleteAmenitiesApi(
  String amenityId,
) async {
  String api = ApiConstant.deleteAmenity;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);
  final body = {
    'amenity_id': amenityId,
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
  return null;
}
