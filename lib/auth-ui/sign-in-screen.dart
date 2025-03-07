// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youcollection/Button/comon_button.dart';
import 'package:youcollection/Fields/textformfield.dart';
import 'package:youcollection/auth-ui/sign-up-screen.dart';
import 'package:youcollection/utils/app-constant.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController password = TextEditingController();
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
                fontFamily: 'font1',
                fontWeight: FontWeight.bold,
                color: AppConstant.appTextColor),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                isKeyboardVisible
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Welcome my app',
                          style: TextStyle(
                              fontFamily: 'font1', fontWeight: FontWeight.bold),
                        ),
                      )
                    : Column(
                        children: [Lottie.asset('assets/images/signin.json')],
                      ),
                SizedBox(
                  height: Get.height / 20,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ComonTextField(
                          hintText: 'Enter your Email',
                          controller: emailcontroller,
                          prefixIcon: Icon(Icons.mail),
                        ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ComonTextField(
                          hintText: 'Enter your Password',
                          controller: password,
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: Icon(Icons.visibility_off),
                        ))),
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
                    GestureDetector(
                      onTap: () => Get.offAll(SignUpScreen()),
                      child: Text(
                        " Sign Up ",
                        style: TextStyle(
                            fontFamily: 'font1',
                            fontWeight: FontWeight.bold,
                            color: AppConstant.appTextColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
