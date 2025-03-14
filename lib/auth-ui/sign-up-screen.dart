// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_label

import 'dart:ffi';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:youcollection/Button/comon_button.dart';
import 'package:youcollection/Fields/textformfield.dart';
import 'package:youcollection/auth-ui/sign-in-screen.dart';
import 'package:youcollection/utils/app-constant.dart';

import '../controllers/sign-up-controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController username = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userPassword = TextEditingController();

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
                          controller: username,
                          prefixIcon: Icon(
                            Icons.person_2,
                            color: AppConstant.appblackColor,
                          ),
                        ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ComonTextField(
                          hintText: 'Enter your Email',
                          controller: userEmail,
                          prefixIcon: Icon(
                            Icons.mail,
                            color: AppConstant.appblackColor,
                          ),
                        ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ComonTextField(
                          hintText: 'Enter your Phone',
                          controller: userPhone,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: AppConstant.appblackColor,
                          ),
                        ))),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(
                      () => TextFormField(
                        controller: userPassword,
                        obscureText: signUpController.isPasswordVisible.value,
                        cursorColor: AppConstant.appMainColor,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: "Enter your Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              signUpController.isPasswordVisible.toggle();
                            },
                            child: signUpController.isPasswordVisible.value
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ComonTextField(
                          hintText: 'Enter your City',
                          controller: userCity,
                          prefixIcon: Icon(
                            Icons.location_pin,
                            color: AppConstant.appblackColor,
                          ),
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
                ComonButton(
                    title: 'SIGN UP ',
                    onTap: () async {
                      String name = username.text.trim();
                      String email = userEmail.text.trim();
                      String phone = userPhone.text.trim();
                      String city = userCity.text.trim();
                      String password = userPassword.text.trim();
                      String userDeviceToken = "";
                      if (name.isEmpty ||
                          email.isEmpty ||
                          phone.isEmpty ||
                          city.isEmpty ||
                          password.isEmpty) {
                        Get.snackbar(
                          'Error',
                          "please enter all details",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appMainColor,
                          colorText: AppConstant.appTextColor,
                        );
                      } else {
                        UserCredential? userCredential =
                            await signUpController.signUpMethod(name, email,
                                phone, city, password, userDeviceToken);
                        if (userCredential != null) {
                          Get.snackbar('Verification email sent.',
                              "please check your email.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appMainColor,
                              colorText: AppConstant.appTextColor);
                        }

                        FirebaseAuth.instance.signOut();
                        Get.offAll(() => SigninScreen());
                      }
                    }),
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
