import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:society_gate/auth/network/login_api.dart';
import 'package:society_gate/constents/local_storage.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log("Title = ${message.notification!.title}");
  log("Body = ${message.notification!.body}");
  log("Payload = ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    log('Token = $fcmToken');
    final loginData = LocalStoragePref().getLoginModel();
    await storeFCM(
        fcmToken.toString(),
        loginData?.user?.userId.toString() ?? "",
        loginData?.user?.societyId.toString() ?? "");
    log(loginData?.user?.userId.toString() ?? "");

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
