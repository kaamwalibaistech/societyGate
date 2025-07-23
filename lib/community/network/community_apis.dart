import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:society_gate/models/comments_model.dart';

import '../../../api/api_constant.dart';
import '../../models/community_model.dart';

Future<int?> addCommunityPost(
  String societyId,
  String adminId,
  String title,
  String description,
  String photoPath, // <- pass file path here
) async {
  // final url = Uri.parse("${baseUrl}communitypostinsert");
  String api = ApiConstant.addCommunityPosts;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  try {
    final request = http.MultipartRequest("POST", url);

    request.fields['society_id'] = societyId;
    request.fields['admin_id'] = adminId;
    request.fields['title'] = title;
    request.fields['description'] = description;

    // Add the image file

    if (photoPath.isNotEmpty && File(photoPath).existsSync()) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          photoPath,
          // contentType: MediaType('image', 'jpeg'),
        ),
      );
    } else {
      print("Invalid or missing image path: $photoPath");
    }
    request.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        photoPath,
        // contentType: MediaType(
        //     'image', 'jpeg'), // Optional: adjust based on your file type
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> data = jsonDecode(responseBody);
      return data['status'];
    } else {
      print('Upload failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception(e.toString());
  }

  return null;
}

/*

 */

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

Future<void> insertComment(
  String communitypostid,
  String societyid,
  String memberid,
  String comment,
) async {
  String api = ApiConstant.insertComment;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  final body = {
    'community_post_id': communitypostid,
    'society_id': societyid,
    'member_id': memberid,
    'comment': comment
  };

  try {
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      // final Map<String, dynamic> data = jsonDecode(response.body);
      //data.forEach((key, value) => log('$key: $value'));
      // return InsertComment.fromJson(data);
    } else {
      log(response.body.toString());
    }
  } catch (e) {
    throw Exception(e.toString());
  }
  // return null;
}

Future<String> deleteComment(
  String id,
) async {
  String api = ApiConstant.deleteComment;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  try {
    final response = await http.post(url, body: {'id': id});
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

Future<String> deletePost(
  String id,
) async {
  String api = ApiConstant.deleteCommunityPost;
  String baseUrl = ApiConstant.baseUrl;
  Uri url = Uri.parse(baseUrl + api);

  try {
    final response = await http.post(url, body: {'id': id});
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
