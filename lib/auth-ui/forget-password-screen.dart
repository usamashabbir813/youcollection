// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youcollection/Button/comon_button.dart';
import 'package:youcollection/Fields/textformfield.dart';
import 'package:youcollection/utils/app-constant.dart';
import '../controllers/forget-password-controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordController forgetPasswodController =
      Get.put(ForgetPasswordController());
  final TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        backgroundColor: AppConstant.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppConstant.appMainColor,
          centerTitle: true,
          title: Text(
            'Forget Password',
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
                        children: [
                          Lottie.asset('assets/images/forgetpassword.json')
                        ],
                      ),
                // SizedBox(
                //   height: Get.height / 20,
                // ),
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
                SizedBox(
                  height: Get.height / 25,
                ),
                ComonButton(
                    title: 'Forget',
                    onTap: () async {
                      String email = userEmail.text.trim();

                      if (email.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "PLease enter your all deatails",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appMainColor,
                          colorText: AppConstant.appTextColor,
                        );
                      } else {
                        String email = userEmail.text.trim();
                        forgetPasswodController.ForgetPasswordMethod(email);
                      }
                    }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
