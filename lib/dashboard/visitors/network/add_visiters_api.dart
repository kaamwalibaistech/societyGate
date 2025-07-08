import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/api_constant.dart';
import 'package:http/http.dart' as http;

Future<AddVisitoModel?> addVisitorApi(
    String flatId,
    String soceityId,
    String requestBy,
    String name,
    String phone,
    String relation,
    String gender,
    String purpose,
    String visitingDate) async {
  String api = ApiConstant.insertVisitor;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {
    'flat_id': flatId,
    'name': name,
    'phone': phone,
    'relation': relation,
    'society_id': soceityId,
    'visiting_request_by': requestBy,
    'gender': gender,
    'visiting_purpose': purpose,
    'visiting_date': visitingDate
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return AddVisitoModel.fromJson(data);
    }
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
    throw Exception(e);
  }
  return null;
}

//model

class AddVisitoModel {
  int status;
  String message;
  String uniqueCode;

  AddVisitoModel(
      {required this.status, required this.message, required this.uniqueCode});

  factory AddVisitoModel.fromJson(Map<String, dynamic> json) {
    return AddVisitoModel(
      status: json['status'] ?? "",
      message: json['message'] ?? "Error",
      uniqueCode: json['unique_code'] ?? "No code found",
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'unique_code': uniqueCode};
  }
}
