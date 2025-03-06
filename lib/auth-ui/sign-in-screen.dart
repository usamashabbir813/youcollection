// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youcollection/Button/comon_button.dart';
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
          centerTitle: true,
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
              isKeyboardVisible
                  ? Text(
                      'Welcome my app',
                      style: TextStyle(
                          fontFamily: 'font1', fontWeight: FontWeight.bold),
                    )
                  : Column(
                      children: [Lottie.asset('assets/images/splash.json')],
                    ),
              SizedBox(
                height: Get.height / 20,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      cursorColor: AppConstant.appTextColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      cursorColor: AppConstant.appTextColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: Icon(Icons.visibility_off),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'Forget Password ?',
                  style: TextStyle(
                      fontFamily: 'font1',
                      fontWeight: FontWeight.bold,
                      color: AppConstant.appMainColor),
                ),
              ),
              SizedBox(
                height: Get.height / 20,
              ),
              ComonButton(title: 'Sign In ', onTap: () {}),
              SizedBox(
                height: Get.height / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an acount ?",
                    style: TextStyle(
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w500,
                        color: AppConstant.appMainColor),
                  ),
                  SizedBox(
                    width: Get.width / 200,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontFamily: 'font1',
                        fontWeight: FontWeight.bold,
                        color: AppConstant.appTextColor),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
