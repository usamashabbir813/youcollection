// ignore_for_file: file_names, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youcollection/utils/app-constant.dart';

class WelCome extends StatelessWidget {
  const WelCome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Lottie.asset('assets/images/splash-icon.json'),
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
          Material(
            child: Container(
              width: Get.width / 1.5,
              height: Get.height / 15,
              decoration: BoxDecoration(
                color: AppConstant.appMainColor,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 6, // Blur radius
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: TextButton.icon(
                icon: Image.asset(
                  'assets/images/google.png',
                  width: Get.width / 12,
                  height: Get.height / 12,
                ),
                label: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontFamily: 'font1',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppConstant.appTextColor,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(
            height: Get.height / 50,
          ),
          Material(
            child: Container(
              width: Get.width / 1.5,
              height: Get.height / 15,
              decoration: BoxDecoration(
                color: AppConstant.appMainColor,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.2), // Shadow color with transparency
                    spreadRadius: 1, // How much the shadow spreads
                    blurRadius: 6, // Blur effect
                    offset: Offset(0, 3), // Moves the shadow downward
                  ),
                ],
              ),
              child: TextButton.icon(
                icon: Icon(
                  Icons.email,
                  color: AppConstant.appTextColor,
                ),
                label: Text(
                  'Sign in with Email',
                  style: TextStyle(
                    fontFamily: 'font1',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppConstant.appTextColor,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
