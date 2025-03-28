import 'dart:convert';

import 'package:my_society/models/shoplist_model.dart';

import '../../../api/api_constant.dart';
import 'package:http/http.dart' as http;

Future<ShopListModel?> shopList(String societyId) async {
  String api = ApiConstant.shopList;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {
    'society_id': societyId,
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      return ShopListModel.fromJson(jsonData);
    }
  } catch (e) {
    throw Exception(e);
  }
  return null;
}

Future<AddShopModel?> addShopAPI(
    String societyId,
    String shopName,
    String shopType,
    String ownerName,
    String shopPhone,
    String shopAddress) async {
  String api = ApiConstant.addShop;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {
    'society_id': societyId,
    'shop_name': shopName,
    'shop_type': shopType,
    'name': ownerName,
    'phone': shopPhone,
    'address': shopAddress
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return AddShopModel.fromJson(jsonData);
    }
  } catch (e) {
    throw Exception(e);
  }
  return null;
}

class AddShopModel {
  int? status;
  String? message;

  AddShopModel({this.status, this.message});

  factory AddShopModel.fromJson(Map<String, dynamic> json) {
    return AddShopModel(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<int?> updateShopAPI(
    String shopId,
    String societyId,
    String shopName,
    String shopType,
    String ownerName,
    String shopPhone,
    String shopAddress) async {
  String api = ApiConstant.updateShop;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {
    'shop_id': shopId,
    'society_id': societyId,
    'shop_name': shopName,
    'shop_type': shopType,
    'name': ownerName,
    'phone': shopPhone,
    'address': shopAddress
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return jsonData['status'];
    }
  } catch (e) {
    throw Exception(e);
  }
  return null;
}

Future<int?> deleteShopAPI(
  String shopId,
) async {
  String api = ApiConstant.deleteShop;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {'shop_id': shopId};
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return jsonData['status'];
    }
  } catch (e) {
    throw Exception(e);
  }
  return null;
}
