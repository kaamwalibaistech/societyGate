import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../api/api_constant.dart';
import '../../../models/visitorslist_model.dart';

Future<VisitorsListModel?> visitorsListApi(
  String soceityId,
  String flatId,
  String page,
  String limit,
) async {
  String api = ApiConstant.visitorsbysocietyAndFlatId;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {
    'society_id': soceityId,
    'flat_id': flatId,
    'page': page,
    'limit': limit
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return VisitorsListModel.fromJson(data);
    }
  } catch (e, stacktrace) {
    log("visitorsListApi error: $e");
    log("Stacktrace: $stacktrace");
    Fluttertoast.showToast(msg: e.toString());

    throw Exception("Failed to fetch visitors list");
  }
  return null;
}

Future<VisitorsListModel?> visitorsListForWatchmanApi(
  String soceityId,
  String page,
  String limit,
) async {
  String api = ApiConstant.visitorsbysocietyId;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {'society_id': soceityId, 'page': page, 'limit': limit};
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((key, value) => log('$key: $value'));

      return VisitorsListModel.fromJson(data);
    }
  } catch (e, stacktrace) {
    log("visitorsListApi error: $e");
    log("Stacktrace: $stacktrace");
    Fluttertoast.showToast(msg: e.toString());

    throw Exception("Failed to fetch visitors list");
  }
  return null;
}

Future<List<Map<String, dynamic>>?> enteredVisitorsListForWatchmanApi(
  String soceityId,
  String page,
  String limit,
) async {
  List<Map<String, dynamic>> mapData = [];
  String api = ApiConstant.visitorsbysocietyId;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {'society_id': soceityId, 'page': page, 'limit': limit};
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      data['data']['upcoming_visitors'].forEach((key, value) {
        if (key == 'udata') {
          List<dynamic> shop = value;
          for (var i in shop) {
            log('$i');

            if (i['entry_time'] != null) {
              mapData.addAll([i]);
            }
            log('$mapData');
          }
          return mapData;
        } else {
          return null;
        }
      });
      return mapData;
    }
  } catch (e, stacktrace) {
    log("visitorsListApi error: $e");
    log("Stacktrace: $stacktrace");
    Fluttertoast.showToast(msg: e.toString());
    throw Exception("Failed to fetch visitors list");
  }
  return mapData;
}
