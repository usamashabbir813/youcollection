// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youcollection/utils/app-constant.dart';

class BuyNowButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget? icon; // Optional Icon
  final double height;
  final double width;
  final Color? color;
  final Color? textColor;

  const BuyNowButton({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.height = 30, // Default height
    this.width = 90, // Default width
    this.color, // Optional button color
    this.textColor, // Optional text color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 12), // Better padding
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? AppConstant.appMainColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.2), // Shadow color with transparency
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3), // Moves the shadow downward
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Wrap content
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 8),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: 12, // Better readability
                fontWeight: FontWeight.bold,
                fontFamily: 'font1',
                color: textColor ?? AppConstant.appTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
