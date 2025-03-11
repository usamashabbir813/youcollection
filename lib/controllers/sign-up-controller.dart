// ignore_for_file: file_names, unused_field, body_might_complete_normally_nullable, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:youcollection/models/user-model.dart';
import 'package:youcollection/utils/app-constant.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // for password visibility
  var isPasswordvisibility = false.obs;

  var isKeyboardVisible;

  var isPasswordVisibility;

  get isPasswordVisible => null;
  Future<UserCredential?> signUpMethod(
    String userName,
    String userEmail,
    String userPassword,
    String userPhone,
    String usercity,
    String userDeviceToken,
  ) async {
    try {
      EasyLoading.show(status: 'Please wait');
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
// send email verification
      await userCredential.user!.sendEmailVerification();
      UserModel userModel = UserModel(
          uId: userCredential.user!.uid,
          username: userName,
          email: userName,
          phone: userPhone,
          userImg: "",
          userDeviceToken: userDeviceToken,
          country: "",
          userAddress: "",
          street: "",
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now(),
          city: "");
      // add data into database
      _firestore
          .collection('users')
          .doc(
            userCredential.user!.uid,
          )
          .set(userModel.toMap());
      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appMainColor,
          colorText: AppConstant.appTextColor);
    }
  }
}
