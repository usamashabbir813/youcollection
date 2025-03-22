// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, sort_child_properties_last, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youcollection/Button/checkout_button.dart';

import '../utils/app-constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Cart Screen",
          style: TextStyle(fontFamily: 'font', color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              color: AppConstant.white,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppConstant.appMainColor,
                  child: Text(
                    "U",
                    style: TextStyle(
                        fontFamily: 'font', color: AppConstant.appTextColor),
                  ),
                ),
                title: Text(
                  "New Dress for Womens",
                  style: TextStyle(
                      fontFamily: 'font1', color: AppConstant.appTextColor),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "2200",
                      style: TextStyle(
                          fontFamily: 'font1', color: AppConstant.appTextColor),
                    ),
                    SizedBox(
                      width: Get.width / 20.0,
                    ),
                    CircleAvatar(
                      child: Text(
                        "-",
                        style: TextStyle(
                            fontFamily: 'font1',
                            color: AppConstant.appTextColor),
                      ),
                      backgroundColor: AppConstant.appMainColor,
                      radius: 12.0,
                    ),
                    SizedBox(
                      width: Get.width / 20.0,
                    ),
                    CircleAvatar(
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontFamily: 'font1',
                            color: AppConstant.appTextColor),
                      ),
                      backgroundColor: AppConstant.appMainColor,
                      radius: 12.0,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.width / 100.0,
            ),
            Text(
              "Totall",
              style: TextStyle(
                fontFamily: 'font1',
                color: AppConstant.appTextColor,
              ),
            ),
            Text(
              "PKR 12,00",
              style: TextStyle(
                  fontFamily: 'font1',
                  color: AppConstant.appTextColor,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckOutButton(title: "Checkout", onTap: () {}),
            )
          ],
        ),
      ),
    );
  }
}
