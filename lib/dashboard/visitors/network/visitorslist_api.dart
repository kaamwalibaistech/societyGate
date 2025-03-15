import 'dart:convert';
import 'dart:developer';
import 'package:my_society/models/visitorslist_model.dart';

import '../../../api/api_constant.dart';
import 'package:http/http.dart' as http;

Future<VisitorsListModel?> visitorsListApi(
  String soceityId,
  String flatId,
) async {
  String api = ApiConstant.visitorsbysocietyAndFlatId;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {'society_id': soceityId, 'flat_id': flatId};
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      data.forEach((key, value) => log('$key: $value'));

      return VisitorsListModel.fromJson(data);
    }
  } catch (e) {
    throw Exception();
  }
  return null;
}
