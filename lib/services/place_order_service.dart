// ignore_for_file: file_names, avoid_print, unused_local_variable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../models/order-model.dart';
import '../user-panel/main_screen.dart';
import '../utils/app-constant.dart';
import 'generate_orderid_service.dart';

void placeOrder({
  required BuildContext context,
  required String customerName,
  required String customerPhone,
  required String customerAddress,
  required String customerDeviceToken,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: "Please Wait..");

  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrder')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      // Check if cart is empty
      if (documents.isEmpty) {
        EasyLoading.dismiss();
        Get.snackbar(
          "Cart is Empty",
          "Please add items to your cart before placing an order.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: AppConstant.appTextColor,
          duration: Duration(seconds: 5),
        );
        return; // Stop execution if cart is empty
      }

      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
        String orderId = generateOrderId();

        OrderModel cartModel = OrderModel(
          productId: data['productId'],
          categoryId: data['categoryId'],
          productName: data['productName'],
          categoryName: data['categoryName'],
          salePrice: data['salePrice'],
          fullPrice: data['fullPrice'],
          productImages: data['productImages'],
          deliveryTime: data['deliveryTime'],
          isSale: data['isSale'],
          productDescription: data['productDescription'],
          createdAt: DateTime.now(),
          updatedAt: data['updatedAt'],
          productQuantity: data['productQuantity'],
          productTotalPrice: double.parse(data['productTotalPrice'].toString()),
          customerId: user.uid,
          status: false,
          customerName: customerName,
          customerPhone: customerPhone,
          customerAddress: customerAddress,
          customerDeviceToken: customerDeviceToken,
        );

        await FirebaseFirestore.instance
            .collection('orders')
            .doc(user.uid)
            .set({
          'uId': user.uid,
          'customerName': customerName,
          'customerPhone': customerPhone,
          'customerAddress': customerAddress,
          'customerDeviceToken': customerDeviceToken,
          'orderStatus': false,
          'createdAt': DateTime.now()
        });

        // Upload order
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(user.uid)
            .collection('confirmOrders')
            .doc(orderId)
            .set(cartModel.toMap());

        // Delete cart items
        await FirebaseFirestore.instance
            .collection('cart')
            .doc(user.uid)
            .collection('cartOrder')
            .doc(cartModel.productId.toString())
            .delete();
      }

      // Save notification
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(user.uid)
          .collection('notifications')
          .doc()
          .set({
        'title': "Order Successfully placed",
        'body': "Your order has been confirmed.",
        'isSeen': false,
        'createdAt': DateTime.now(),
      });

      print("Order Confirmed");
      Get.snackbar(
        "Order Confirmed",
        "Thank you for your order!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appMainColor,
        colorText: AppConstant.appTextColor,
        duration: Duration(seconds: 5),
      );

      EasyLoading.dismiss();
      Get.offAll(() => MainScreen());
    } catch (e) {
      EasyLoading.dismiss();
      print("Error: $e");
    }
  }
}
