// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youcollection/Button/comon_button.dart';
import 'package:youcollection/Fields/textformfield.dart';
import 'package:youcollection/admin-panel/admin-main-screen.dart';
import 'package:youcollection/auth-ui/forget-password-screen.dart';
import 'package:youcollection/auth-ui/sign-up-screen.dart';
import 'package:youcollection/controllers/sign-in-controller.dart';
import 'package:youcollection/user-panel/main_screen.dart';
import 'package:youcollection/utils/app-constant.dart';
import 'package:youcollection/utils/app-icons-constant.dart';
import '../controllers/get-user-data-controller.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  final SignInController signInController = Get.put(SignInController());

  final TextEditingController useremail = TextEditingController();
  final TextEditingController userpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
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
                color: AppConstant.appTextColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                isKeyboardVisible
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Welcome to my app',
                          style: TextStyle(
                            fontFamily: 'font1',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Lottie.asset('assets/images/signin.json'),
                SizedBox(height: Get.height / 20),

                /// **Email Field**
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ComonTextField(
                      hintText: 'Enter your Email',
                      controller: useremail,
                      prefixIcon:
                          Icon(AppIcon.email, color: AppConstant.appblackColor),
                    ),
                  ),
                ),

                /// **Password Field**
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(
                      () => TextFormField(
                        controller: userpassword,
                        obscureText: !signInController.isPasswordVisible.value,
                        cursorColor: AppConstant.appMainColor,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: "Enter your Password",
                          prefixIcon: Icon(AppIcon.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              signInController.isPasswordVisible.toggle();
                            },
                            child: Icon(
                              signInController.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
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

                /// **Forget Password**
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ForgetPasswordScreen());
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: 'font1',
                        fontWeight: FontWeight.bold,
                        color: AppConstant.appMainColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height / 20),

                /// **Sign In Button**
                ComonButton(
                  title: 'SIGN IN',
                  onTap: () async {
                    String email = useremail.text.trim();
                    String password = userpassword.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      Get.snackbar(
                        "Error",
                        "Please enter all details",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.appMainColor,
                        colorText: AppConstant.appTextColor,
                      );
                      return;
                    }

                    try {
                      UserCredential? userCredential =
                          await signInController.signInMethod(email, password);

                      if (userCredential!.user != null) {
                        var userData = await getUserDataController
                            .getUserData(userCredential.user!.uid);

                        if (!userCredential.user!.emailVerified) {
                          Get.snackbar(
                            "Email Verification",
                            "Please verify your email before logging in.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appMainColor,
                            colorText: AppConstant.appTextColor,
                          );
                          return; // The screen will not change
                        }

                        if (userData[0]['isAdmin'] == true) {
                          Get.snackbar(
                            'Admin Login Success',
                            "Logged in successfully!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appMainColor,
                            colorText: AppConstant.appTextColor,
                          );
                          Get.offAll(() =>
                              AdminMainScreen()); // The screen changes only on successful login
                        } else {
                          Get.snackbar(
                            'User Login Success',
                            "Logged in successfully!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appMainColor,
                            colorText: AppConstant.appTextColor,
                          );
                          Get.offAll(() => MainScreen());
                        }
                      }
                    } on FirebaseAuthException catch (e) {
                      String errorMessage =
                          "Invalid email or password"; // Default message

                      if (e.code == 'user-not-found') {
                        errorMessage = "This email is not registered.";
                      } else if (e.code == 'wrong-password') {
                        errorMessage = "Incorrect password! Please try again.";
                      } else if (e.code == 'too-many-requests') {
                        errorMessage =
                            "Too many attempts! Please try again later.";
                      }

                      Get.snackbar(
                        "Login Failed",
                        errorMessage,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.appMainColor,
                        colorText: AppConstant.appTextColor,
                      );

                      // **The screen will not change; only a Snackbar will appear**
                    } catch (e) {
                      Get.snackbar(
                        "Error",
                        "Something went wrong. Please try again later.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.appMainColor,
                        colorText: AppConstant.appTextColor,
                      );
                    }
                  },
                ),

                SizedBox(height: Get.height / 20),

                /// **Sign Up Option**
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w500,
                        color: AppConstant.appMainColor,
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => Get.offAll(SignUpScreen()),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontFamily: 'font1',
                          fontWeight: FontWeight.bold,
                          color: AppConstant.appTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
