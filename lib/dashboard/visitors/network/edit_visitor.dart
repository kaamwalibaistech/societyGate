import 'dart:convert';
import '../../../api/api_constant.dart';
import 'package:http/http.dart' as http;

Future<String?> editVisitorApi(
  String flatId,
  String name,
  String phone,
  String relation,
  String? gender,
  String purpose,
  String? visitingDate,
  String requestBy,
  String soceityId,
  String visitoerId,
) async {
  String api = ApiConstant.editVisitor;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {
    'flat_id': flatId,
    'name': name,
    'phone': phone,
    'relation': relation,
    'gender': gender,
    'visiting_purpose': purpose,
    'visiting_date': visitingDate,
    'visiting_request_by': requestBy,
    'society_id': soceityId,
    'visitor_id': visitoerId,
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['message'];
    }
  } catch (e) {
    throw Exception(e);
  }
  return null;
}

// //model

// class AddVisitoModel {
//   int status;
//   String message;

//   AddVisitoModel(
//       {required this.status, required this.message});

//   factory AddVisitoModel.fromJson(Map<String, dynamic> json) {
//     return AddVisitoModel(
//       status: json['status'] ?? "",
//       message: json['message'] ?? "Error",
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {'status': status, 'message': message};
//   }
// }
