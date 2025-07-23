import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/api_constant.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> deleteVisitor(
  String visitorId,
) async {
  String api = ApiConstant.deleteVisitor;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {'visitor_id': visitorId};
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return data;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
    throw Exception(e);
  }
  return null;
}
