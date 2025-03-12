// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youcollection/Button/comon_button.dart';
import 'package:youcollection/Fields/textformfield.dart';
import 'package:youcollection/auth-ui/sign-up-screen.dart';
import 'package:youcollection/controllers/sign-in-controller.dart';
import 'package:youcollection/user-panel/main_screen.dart';
import 'package:youcollection/utils/app-constant.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SignInController signInController = Get.put(SignInController());
  final TextEditingController useremail = TextEditingController();
  final TextEditingController userpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        backgroundColor: AppConstant.backgroundColor,
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
                          'Welcome  to my app',
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
                          controller: useremail,
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
                      child: Obx(
                        () => TextFormField(
                          controller: userpassword,
                          obscureText: signInController.isPasswordVisible.value,
                          cursorColor: AppConstant.appMainColor,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "Enter your Password",
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signInController.isPasswordVisible.toggle();
                              },
                              child: signInController.isPasswordVisible.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                            contentPadding:
                                EdgeInsets.only(top: 2.0, left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      )),
                ),
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
                    title: 'SIGN IN ',
                    onTap: () async {
                      String email = useremail.text.trim();
                      String password = userpassword.text.trim();
                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "PLease enter your all deatails",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appMainColor,
                          colorText: AppConstant.appTextColor,
                        );
                      } else {
                        UserCredential? userCredential = await signInController
                            .signInMethod(email, password);
                        if (userCredential != null) {
                          if (userCredential.user!.emailVerified) {
                            Get.snackbar(
                              'Success',
                              "Login Successfully!",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appMainColor,
                              colorText: AppConstant.appTextColor,
                            );
                            Get.offAll(() => MainScreen());
                          } else {
                            Get.snackbar(
                              "Error",
                              "Please verify your email before Login",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appMainColor,
                              colorText: AppConstant.appTextColor,
                            );
                          }
                        } else {
                          Get.snackbar(
                            "Error",
                            "Please try again",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appMainColor,
                            colorText: AppConstant.appTextColor,
                          );
                        }
                      }
                    }),
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
