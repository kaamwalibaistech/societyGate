import 'dart:convert';

// import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

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

  // Future<void> storeUserPhoto(File photo) async {
  //   final bytes = photo.path;
  //   // String data = bytes.substring(7, bytes.length - 1);
  //   log(bytes);
  //   await storage?.setString(LocalStorageKeys.userPhoto, bytes);
  // }
  // Future<void> storeUserPhoto(photo) async {
  //   final userPhoto = await photo;

  //   await storage?.setString(LocalStorageKeys.userPhotoo, userPhoto ?? "");
  // }

  // String? getUserPhoto() {
  //   storage?.getString(LocalStorageKeys.userPhoto);
  //   String? photoPath = storage?.getString(LocalStorageKeys.userPhoto);
  //   if (photoPath == null) return null;
  //   return photoPath;
  // }
  // String? getUserPhoto() {
  //   final userPhoto = storage?.getString(LocalStorageKeys.userPhotoo);
  //   if (userPhoto == null) return null;
  //   return userPhoto; // Convert Base64 back to Uint8List
  // }

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

  Future<void> setAmenitiesBool(bool value) async {
    await storage?.setBool(LocalStorageKeys.isAmenitiesAdded, value);
  }

  bool? getAmenitiesBool() {
    return storage?.getBool(LocalStorageKeys.isAmenitiesAdded);
  }
}

class LocalStorageKeys {
  static const userProfile = 'user_profile';
  static const isLoggedIn = 'isLoggedIn';
  static const userPhotoo = 'user_photo';
  static const isAmenitiesAdded = 'is_amenities_added';
}
