import 'dart:convert';
import 'dart:developer';

import 'package:society_gate/models/comments_model.dart';

import '../../../api/api_constant.dart';
import 'package:http/http.dart' as http;

import '../../models/community_model.dart';

Future<CommunityModel?> getCommunityPosts(
  String page,
  String limit,
) async {
  String api = ApiConstant.getCommunityPosts;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {'page': page, 'limit': limit};

  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      //data.forEach((key, value) => log('$key: $value'));

      return CommunityModel.fromJson(data);
    }
  } catch (e) {
    throw Exception();
  }
  return null;
}

Future<CommentsModel?> getCommentsApi(
  String postId,
  String page,
  String limit,
) async {
  String api = ApiConstant.getComments;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {'community_post_id': postId, 'page': page, 'limit': limit};

  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      //data.forEach((key, value) => log('$key: $value'));
      return CommentsModel.fromJson(data);
    } else {
      log(response.body.toString());
    }
  } catch (e) {
    throw Exception(e.toString());
  }
  return null;
}
