// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_import, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youcollection/auth-ui/welcome-screen.dart';
import 'package:youcollection/user-panel/all-categories-screen.dart';
import 'package:youcollection/utils/app-constant.dart';
import 'package:youcollection/widgets/banner-widget.dart';
import 'package:youcollection/widgets/category-widget.dart';
import 'package:youcollection/widgets/custom-drawer-widget.dart';
import 'package:youcollection/widgets/flash-sale-widget.dart';
import 'package:youcollection/widgets/heading-widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: TextStyle(fontFamily: 'font', color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 90.0,
              ),
              //banners
              BannerWidget(),
              //heading
              HeadingWidget(
                  headingTitle: 'Categories',
                  headingSubTitle: 'According to your budget',
                  onTap: () => Get.to(() => AllCategoriesScreen()),
                  buttonText: 'See More >'),
              //category
              CategoryWidget(),
              //heading
              HeadingWidget(
                  headingTitle: 'Flash Sale',
                  headingSubTitle: 'According to your budget',
                  onTap: () {},
                  buttonText: 'See More >'),
              //flash sale
              FlashSaleWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
