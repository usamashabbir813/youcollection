// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:youcollection/Button/comon_button.dart';
import 'package:youcollection/Fields/textformfield.dart';
import 'package:youcollection/auth-ui/sign-in-screen.dart';
import 'package:youcollection/utils/app-constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController citycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        backgroundColor: AppConstant.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppConstant.appMainColor,
          centerTitle: true,
          title: Text(
            'Sign Up',
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
                    ? SizedBox(
                        height: Get.height / 20,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Welcome my app',
                            style: TextStyle(
                                fontFamily: 'font1',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: AppConstant.appTextColor),
                          ),
                        ),
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
                          hintText: 'Enter your UserName',
                          controller: usernamecontroller,
                          prefixIcon: Icon(Icons.person_2),
                        ))),
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
                          hintText: 'Enter your Phone',
                          controller: phonecontroller,
                          prefixIcon: Icon(Icons.phone),
                        ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ComonTextField(
                          hintText: 'Enter your Password',
                          controller: passwordcontroller,
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: Icon(Icons.visibility_off),
                        ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ComonTextField(
                          hintText: 'Enter your City',
                          controller: citycontroller,
                          prefixIcon: Icon(Icons.location_pin),
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
                ComonButton(title: 'Sign Up ', onTap: () {}),
                SizedBox(
                  height: Get.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an acount ?",
                      style: TextStyle(
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w500,
                          color: AppConstant.appMainColor),
                    ),
                    SizedBox(
                      width: Get.width / 200,
                    ),
                    GestureDetector(
                      onTap: () => Get.offAll(SigninScreen()),
                      child: Text(
                        " Sign In ",
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
