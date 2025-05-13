import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  // ignore: non_constant_identifier_names
  static String IMG_KEY = 'image_key';

  static Future<bool?> saveImageToLocalStorage(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(IMG_KEY, value);
  }

  static Future<String?> getImageFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(IMG_KEY);
  }

  static Future<bool?> removeImageFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(IMG_KEY);
  }

  static Future<bool?> clearAllLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static String base64String(Uint8List data) {
    return const Base64Encoder().convert(data);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }
}
