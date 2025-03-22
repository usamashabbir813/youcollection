// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:youcollection/utils/app-constant.dart';

class ButtonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Button Screen")),
      body: Center(
        child: Button(
          title: "Click Me",
          onTap: () async {
            EasyLoading.show(status: 'Loading...');
            await Future.delayed(Duration(seconds: 2)); // Simulating API Call
            EasyLoading.dismiss();
            Get.snackbar("Success", "Button Pressed Successfully");
          },
          icon: Icon(Icons.touch_app, color: Colors.white),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget? icon;

  const Button({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        EasyLoading.show(status: 'Processing...');
        await Future.delayed(Duration(seconds: 2));
        EasyLoading.dismiss();
        onTap();
      },
      child: Container(
        height: Get.height / 16,
        width: Get.width / 3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppConstant.appMainColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 8),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'font1',
                color: AppConstant.appTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
