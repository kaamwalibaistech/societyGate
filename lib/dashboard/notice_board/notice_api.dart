import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:society_gate/models/announcements_model.dart';

import '../../api/api_constant.dart';

Future<String> deleteAnnouncement(
  String id,
) async {
  String api = ApiConstant.deleteAnnouncement;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  try {
    final response = await http.post(url, body: {'announcement_id': id});
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return (data['message']);
    } else {
      log(response.body.toString());
      return "Something wrong, try again!";
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<Announcementmodel?> getAnnouncement(String societyId) async {
  String api = ApiConstant.getAnnouncements;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);
  try {
    final response = await http.post(url, body: {'society_id': societyId});
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == 200) {
        return Announcementmodel.fromJson(data);
      }
      return Announcementmodel.fromJson(data);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
  return null;
}
