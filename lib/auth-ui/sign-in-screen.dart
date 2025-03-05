// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:youcollection/utils/app-constant.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.appMainColor,
          title: Text(
            'Sign In',
            style: TextStyle(
                fontFamily: 'font',
                fontWeight: FontWeight.bold,
                color: AppConstant.appTextColor),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Column(
                children: [],
              )
            ],
          ),
        ),
      );
    });
  }
}
