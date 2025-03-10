// ignore_for_file: file_names, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youcollection/Button/Google-container.dart';
import 'package:youcollection/Button/comon_button.dart';
import 'package:youcollection/auth-ui/sign-up-screen.dart';
import 'package:youcollection/utils/app-constant.dart';

class WelCome extends StatelessWidget {
  const WelCome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          'WelCome to app',
          style: TextStyle(fontFamily: 'font', color: AppConstant.appTextColor),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: AppConstant.appMainColor,
            child: Lottie.asset('assets/images/splash.json'),
          ),
          Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                'Happy Shopping',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppConstant.appTextColor),
              )),
          SizedBox(
            height: Get.height / 12,
          ),
          GoogleContainer(),
          SizedBox(
            height: Get.height / 50,
          ),
          ComonButton(
            title: 'Sign in with Email',
            icon: Icon(Icons.mail),
            onTap: () => Get.offAll(SignUpScreen()),
          )
        ],
      ),
    );
  }
}
