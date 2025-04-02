import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';

class LocalStoragePref {
  static LocalStoragePref? _instance;
  static SharedPreferences? storage;

  static LocalStoragePref? get instance {
    _instance ??= LocalStoragePref();

    return _instance;
  }

  Future initPrefBox() async {
    storage ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAllPref() async {
    await storage?.clear();
  }

  // Optional: for strongly typed usage
  Future<void> storeLoginModel(LoginModel model) async {
    await storage?.setString(
        LocalStorageKeys.userProfile, jsonEncode(model.toJson()));
  }

  LoginModel? getLoginModel() {
    final jsonStr = storage?.getString(LocalStorageKeys.userProfile);
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
    await storage?.setBool(LocalStorageKeys.isLoggedIn, value);
  }

  bool? getLoginBool() {
    return storage?.getBool(LocalStorageKeys.isLoggedIn);
  }
}

class LocalStorageKeys {
  static const userProfile = 'user_profile';
  static const isLoggedIn = 'isLoggedIn';
}
