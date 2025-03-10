import 'dart:convert';
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_society/models/login_model.dart';

class LocalStoragePref {
  static final LocalStoragePref _instance = LocalStoragePref._internal();
  static SharedPreferences? _storage;

  factory LocalStoragePref() {
    return _instance;
  }

  LocalStoragePref._internal();

  static Future<void> init() async {
    _storage ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAllPref() async {
    await _storage?.clear();
  }

  // Optional: for strongly typed usage
  Future<void> storeLoginModel(LoginModel model) async {
    await _storage?.setString(
        LocalStorageKeys.userProfile, jsonEncode(model.toJson()));
  }

  LoginModel? getLoginModel() {
    final jsonStr = _storage?.getString(LocalStorageKeys.userProfile);
    if (jsonStr == null) return null;
    return LoginModel.fromJson(jsonDecode(jsonStr));
  }
/*
  Future<void> setString(String key, String value) async {
    await _storage?.setString(key, value);
  }

  String? getString(String key) {
    return _storage?.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _storage?.setBool(key, value);
  }

  bool? getBool(String key) {
    return _storage?.getBool(key);
  }
*/

  Future<void> setLoginBool(bool value) async {
    await _storage?.setBool(LocalStorageKeys.isLoggedIn, value);
  }

  bool? getLoginBool() {
    return _storage?.getBool(LocalStorageKeys.isLoggedIn);
  }
}

class LocalStorageKeys {
  static const userProfile = 'user_profile';
  static const isLoggedIn = 'isLoggedIn';
}
