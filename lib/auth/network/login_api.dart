import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../api/api_constant.dart';
import '../../models/login_model.dart';

Future<LoginModel?> login(
  String phone,
  String password,
) async {
  String api = ApiConstant.loginApi;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {
    'uphone': phone,
    'upassword': password,
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // if (data['status'] == 200) {
      return LoginModel.fromJson(data);
      // }
    }
  } catch (e) {
    throw Exception();
  }
  return null;
}

Future storeFCM(
  String fcmTkn,
  String userId,
  String societyId,
) async {
  String api = ApiConstant.storeFcm;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {
    'fcm_token': fcmTkn,
    'user_id': userId,
    'society_id': societyId,
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == 200) {
        log("fcm stored");
      }
    }
  } catch (e) {
    log(e.toString());
    throw Exception();
  }
}
