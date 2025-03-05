// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youcollection/auth-ui/welcome-screen.dart';
import '../user-panel/main_screen.dart';
import '../utils/app-constant.dart';

// ✅ Corrected: StatefulWidget ko define kiya
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 6), () {
      Get.offAll(() => WelCome());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: Get.width,
              alignment: Alignment.center,
              child: Lottie.asset(
                'assets/images/splash-icon.json',
                repeat: true,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            width: Get.width,
            alignment: Alignment.center,
            child: Text(
              AppConstant.appPoweredby,
              style: TextStyle(
                fontFamily: 'font1',
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppConstant.appTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
