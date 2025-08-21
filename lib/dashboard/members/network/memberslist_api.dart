import 'dart:convert';
import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../api/api_constant.dart';
import 'package:http/http.dart' as http;

import '../../../models/memberlist_model.dart';

Future<MemberlistModel?> memberListApi(
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

Future<int?> updateWatchmanApi(
  String soceityId,
  String userId,
  String name,
  String email,
  String phone,
  String pass,
  String status,
  String image,
) async {
  String api = ApiConstant.fine;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  try {
    final request = http.MultipartRequest("POST", url);
    request.fields['user_id'] = userId;
    request.fields['society_id'] = soceityId;
    request.fields['uname'] = name;
    request.fields['uemail'] = email;
    request.fields['uphone'] = phone;
    request.fields['upassword'] = pass;
    request.fields['approval_status'] = status;

    request.files.add(await http.MultipartFile.fromPath('attachment', image));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> data = jsonDecode(responseBody);
      log("$data");
      return data['status'];
    }
  } catch (e) {
    EasyLoading.dismiss();
    throw Exception(e);
  }
  return null;
}
