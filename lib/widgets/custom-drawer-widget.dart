// ignore_for_file: unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youcollection/utils/app-icons-constant.dart';

import '../auth-ui/welcome-screen.dart';
import '../utils/app-constant.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'You.Collection',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'font',
                    color: AppConstant.appTextColor,
                  ),
                ),
                subtitle: Text(
                  'Version 1.0.1',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'font1',
                    color: AppConstant.appTextColor,
                  ),
                ),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.white,
                  child: Text(
                    'U',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'font',
                      color: AppConstant.appTextColor,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: AppConstant.appblackColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'font1',
                    color: AppConstant.appTextColor,
                  ),
                ),
                leading: Icon(
                  AppIcon.home,
                  color: AppConstant.appblackColor,
                ),
                trailing: Icon(AppIcon.arrow),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'font1',
                    color: AppConstant.appTextColor,
                  ),
                ),
                leading: Icon(
                  AppIcon.product,
                  color: AppConstant.appTextColor,
                ),
                trailing: Icon(AppIcon.arrow),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'font1',
                    color: AppConstant.appTextColor,
                  ),
                ),
                leading: Icon(
                  AppIcon.shopping,
                  color: AppConstant.appTextColor,
                ),
                trailing: Icon(AppIcon.arrow),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'Contacts',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'font1',
                    color: AppConstant.appTextColor,
                  ),
                ),
                leading: Icon(
                  AppIcon.help,
                  color: AppConstant.appTextColor,
                ),
                trailing: Icon(AppIcon.arrow),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(() => WelCome());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'font1',
                    color: AppConstant.appTextColor,
                  ),
                ),
                leading: Icon(
                  AppIcon.logout,
                  color: AppConstant.appTextColor,
                ),
                trailing: Icon(AppIcon.arrow),
              ),
            ),
          ],
        ),
        backgroundColor: AppConstant.appMainColor,
      ),
    );
  }
}
