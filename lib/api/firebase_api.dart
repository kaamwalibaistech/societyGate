import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

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

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
