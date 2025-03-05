// ignore_for_file: file_names

import 'package:flutter/material.dart';
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
          style: TextStyle(fontFamily: 'font'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: AppConstant.appMainColor,
            child: Lottie.asset('assets/images/splash-icon.json'),
          )
        ],
      ),
    );
  }
}
