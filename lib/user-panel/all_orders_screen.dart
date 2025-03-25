// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, sort_child_properties_last, unnecessary_import, prefer_interpolation_to_compose_strings, unused_import, sized_box_for_whitespace, avoid_print, await_only_futures, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:youcollection/Button/checkout_button.dart';
import 'package:youcollection/models/cart_model.dart';
import 'package:youcollection/models/order-model.dart';
import 'package:youcollection/user-panel/add_review_screen.dart';
import 'package:youcollection/user-panel/checkout_screen.dart';
import 'package:youcollection/user-panel/main_screen.dart';

import '../controllers/cart_price_controller.dart';
import '../utils/app-constant.dart';
import '../widgets/custom-drawer-widget.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<AllOrdersScreen> {
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "All Orders",
          style: TextStyle(fontFamily: 'font', color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Get.offAll(() =>
                MainScreen()); // Navigate to MainScreen and remove current screen
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection("confirmOrders")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No products found!"),
            );
          }

          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  OrderModel orderModel = OrderModel(
                    productId: productData['productId'],
                    categoryId: productData['categoryId'],
                    productName: productData['productName'],
                    categoryName: productData['categoryName'],
                    salePrice: productData['salePrice'],
                    fullPrice: productData['fullPrice'],
                    productImages: productData['productImages'],
                    deliveryTime: productData['deliveryTime'],
                    isSale: productData['isSale'],
                    productDescription: productData['productDescription'],
                    createdAt: productData['createdAt'],
                    updatedAt: productData['updatedAt'],
                    productQuantity: productData['productQuantity'],
                    productTotalPrice: double.parse(
                        productData['productTotalPrice'].toString()),
                    customerId: productData['customerId'],
                    status: productData['status'],
                    customerName: productData['customerName'],
                    customerPhone: productData['customerPhone'],
                    customerAddress: productData['customerAddress'],
                    customerDeviceToken: productData['customerDeviceToken'],
                  );

                  // calculate price
                  productPriceController.fetchProductPrice();
                  return Card(
                    elevation: 5,
                    color: AppConstant.white,
                    child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppConstant.appMainColor,
                          backgroundImage:
                              NetworkImage(orderModel.productImages[0]),
                        ),
                        title: Text(orderModel.productName),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(orderModel.productTotalPrice.toString()),
                            SizedBox(
                              width: 10.0,
                            ),
                            orderModel.status != true
                                ? Text(
                                    "Pending..",
                                    style: TextStyle(color: Colors.green),
                                  )
                                : Text(
                                    "Deliverd",
                                    style: TextStyle(color: Colors.red),
                                  )
                          ],
                        ),
                        trailing: orderModel.status == true
                            ? ElevatedButton(
                                onPressed: () {
                                  Get.to(() => AddReviewScreen(
                                        orderModel: orderModel,
                                      ));
                                },
                                child: Text(
                                  "Review",
                                  style: TextStyle(
                                      color: AppConstant.appMainColor,
                                      fontFamily: 'font1',
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : SizedBox.shrink()),
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
