import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_society/api/api_constant.dart';
import 'package:my_society/models/login_model.dart';

Future<LoginModel?> login(
  String phone,
  String password,
) async {
  String api = ApiConstant.loginApi;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {
    'uemail': phone,
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
