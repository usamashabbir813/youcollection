// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, unused_import, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youcollection/user-panel/cart_screen.dart';
import 'package:youcollection/user-panel/checkout_screen.dart';
import 'package:youcollection/utils/app-constant.dart';

class PaymentController extends GetxController {
  var selectedMethod = ''.obs;
}

class PaymentScreen extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  final List<Map<String, dynamic>> paymentMethods = [
    {
      "name": "UPI",
      "icon": Icons.account_balance_wallet,
      "color": AppColors.upi, // Fallback Color
    },
    {
      "name": "Credit/Debit Card",
      "icon": Icons.credit_card,
      "color": AppColors.card,
    },
    {
      "name": "Wallet",
      "icon": Icons.account_balance,
      "color": AppColors.wallet,
    },
    {
      "name": "Net Banking",
      "icon": Icons.account_balance_outlined,
      "color": AppColors.netBanking,
    },
    {
      "name": "PayPal",
      "icon": Icons.payment,
      "color": AppColors.paypal,
    },
    {
      "name": "Google Pay",
      "icon": Icons.phone_android,
      "color": AppColors.googlePay,
    },
    {
      "name": "Apple Pay",
      "icon": Icons.apple,
      "color": AppColors.applePay,
    },
    {
      "name": "Paytm",
      "icon": Icons.payment,
      "color": AppColors.paytm,
    },
    {
      "name": "PhonePe",
      "icon": Icons.phone_iphone,
      "color": AppColors.phonePe,
    },
    {
      "name": "Cash on Delivery",
      "icon": Icons.money,
      "color": AppColors.cod,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor, // Background color cards jaisa hoga
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppConstant.appMainColor,
        title: Text('Payment',
            style: TextStyle(fontFamily: 'font', color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor),
            ),
            SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: paymentMethods.map((method) {
                    return paymentOption(
                        method["name"], method["icon"], method["color"]);
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                if (controller.selectedMethod.value.isEmpty) {
                  Get.snackbar('Error', 'Please select a payment method!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.error,
                      colorText: Colors.black,
                      duration: Duration(seconds: 2));
                } else {
                  Get.to(() => CheckOutScreen())!.then((_) {
                    Get.snackbar('Success',
                        'Payment via ${controller.selectedMethod.value} completed!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.appMainColor,
                        colorText: Colors.black,
                        duration: Duration(seconds: 2));
                  });
                }
              },
              child: Container(
                width: Get.width / 0.5,
                height: Get.height / 16,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.applePay, AppColors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4))
                  ],
                ),
                child: Center(
                  child: Text('Proceed to Pay',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentOption(String method, IconData icon, Color? brandColor) {
    return Obx(() {
      bool isSelected = controller.selectedMethod.value == method;
      return GestureDetector(
        onTap: () => controller.selectedMethod.value = method,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      (brandColor ?? Colors.grey).withOpacity(0.8),
                      brandColor ?? Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      AppColors.cardColor.withOpacity(0.2),
                      AppColors.cardColor.withOpacity(0.6)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 12,
                spreadRadius: 2,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
              Icon(icon,
                  color: isSelected ? Colors.white : brandColor ?? Colors.white,
                  size: 30),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  method,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : AppColors.textColor,
                  ),
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: Colors.white, size: 26),
            ],
          ),
        ),
      );
    });
  }
}

void main() {
  runApp(GetMaterialApp(
    home: PaymentScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
