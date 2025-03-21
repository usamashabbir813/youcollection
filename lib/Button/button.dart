import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youcollection/utils/app-constant.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget? icon; //   optional

  const Button({
    super.key,
    required this.title,
    required this.onTap,
    this.icon, // optional
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height / 16,
        width: Get.width / 3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppConstant.appMainColor,
          borderRadius: BorderRadius.circular(30),
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
