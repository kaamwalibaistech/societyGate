import 'dart:convert';
import 'package:my_society/models/visitors_details_model.dart';

import '../../../api/api_constant.dart';
import 'package:http/http.dart' as http;

Future<VisitorsDetailModel?> visitorsDetailsApi(
  String visitorId,
) async {
  String api = ApiConstant.getVisitors;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {'visitor_id': visitorId};
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return VisitorsDetailModel.fromJson(data);
    }
  } catch (e) {
    throw Exception();
  }
  return null;
}
