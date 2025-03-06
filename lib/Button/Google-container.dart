// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youcollection/utils/app-constant.dart';

class GoogleContainer extends StatelessWidget {
  const GoogleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Image.asset(
              'assets/images/google.png',
              height: 25,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Sign in with Google',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'font1',
                  color: AppConstant.appTextColor,
                  fontSize: 17),
            )
          ],
        ),
      ),
      height: Get.height / 18,
      width: Get.width / 1.5,
      decoration: BoxDecoration(
        color: AppConstant.appMainColor,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.2), // Shadow color with transparency
            spreadRadius: 1, // How much the shadow spreads
            blurRadius: 6, // Blur effect
            offset: Offset(0, 3), // Moves the shadow downward
          ),
        ],
      ),
    );
  }
}
