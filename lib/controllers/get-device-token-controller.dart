// ignore_for_file: file_names, override_on_non_overriding_member, avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../utils/app-constant.dart';

class GetDeviceTokenController extends GetxController {
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();
    requestPermission(); // ✅ Pehle permissions request karenge
    getDeviceToken();
  }

  // ✅ Permissions check & request karein
  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print("Permission Denied");
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Permission Granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("Provisional Permission Granted");
    }
  }

  // ✅ Device Token Get Function
  Future<void> getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        deviceToken = token;
        update();
        print("FCM Token: $deviceToken");
      } else {
        print("Error: Token is null");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appMainColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}
