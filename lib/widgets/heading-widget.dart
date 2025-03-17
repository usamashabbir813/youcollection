// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app-constant.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final String headingSubTitle;
  final VoidCallback onTap;
  final String buttonText;
  const HeadingWidget({
    super.key,
    required this.headingTitle,
    required this.headingSubTitle,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headingTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'font1',
                    color: Colors.grey.shade800,
                  ),
                ),
                Text(
                  headingSubTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'font1',
                    fontSize: 12.0,
                    color: AppConstant.grey,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                        color: AppConstant.appMainColor, width: 1.5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'font1',
                      fontSize: 12.0,
                      color: AppConstant.appMainColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
