import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youcollection/utils/app-constant.dart';

class ComonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget? icon; // آئیکن کو optional بنایا

  const ComonButton({
    super.key,
    required this.title,
    required this.onTap,
    this.icon, // optional آئیکن
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height / 18,
        width: Get.width / 1.5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppConstant.appMainColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.2), // Shadow color with transparency
              spreadRadius: 1, // How much the shadow spreads
              blurRadius: 6, // Blur effect
              offset: Offset(0, 3), // Moves the shadow downward
            ),
          ], // تھوڑا بہتر UI کے لیے
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!, // اگر آئیکن دستیاب ہو تو دکھائیں
              SizedBox(width: 8), // آئیکن اور ٹیکسٹ کے درمیان اسپیس
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
