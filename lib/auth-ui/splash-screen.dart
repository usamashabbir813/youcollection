// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:youcollection/utils/app-constant.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        elevation: 0,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            Container(
              child: Lottie.asset(
                'assets/images/splash-icon.json',
                repeat: true,
                animate: true,
                reverse: false,
                options: LottieOptions(
                    enableMergePaths: true), // Optional optimization
              ),
            )
          ],
        ),
      ),
    );
  }
}
