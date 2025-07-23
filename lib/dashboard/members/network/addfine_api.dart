import 'dart:convert';
import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../../../api/api_constant.dart';

Future<int?> addFineApi(
  String soceityId,
  String userId,
  String flatId,
  String fineTitle,
  String fineReason,
  String fineAmount,
  String fineData,
  String image,
) async {
  String api = ApiConstant.fine;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  try {
    final request = http.MultipartRequest("POST", url);

    request.fields['society_id'] = soceityId;
    request.fields['user_id'] = userId;
    request.fields['flat_id'] = flatId;
    request.fields['fine_title'] = fineTitle;
    request.fields['fine_reason'] = fineReason;
    request.fields['fine_amount'] = fineAmount;
    request.fields['fine_date'] = fineData;

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

/*
{
    "status": 200,
    "message": "Fine added successfully",
    "fine": {
        "society_id": "1",
        "user_id": "2",
        "flat_id": "3",
        "fine_title": "Test2 Violation",
        "fine_reason": "He is trying to unplug.",
        "fine_amount": "100",
        "fine_date": "2025-07-15",
        "status": "unpaid",
        "attachment": null,
        "paid_at": null,
        "fine_id": 16
    }
}
*/
