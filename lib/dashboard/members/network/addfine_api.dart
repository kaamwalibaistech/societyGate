import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../api/api_constant.dart';
import '../../../models/memberlist_model.dart';

Future<MemberlistModel?> addFineApi(
  String soceityId,
) async {
  String api = ApiConstant.societyMembersList;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {'society_id': soceityId};
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      //data.forEach((key, value) => log('$key: $value'));

      return MemberlistModel.fromJson(data);
    }
  } catch (e) {
    throw Exception();
  }
  return null;
}
