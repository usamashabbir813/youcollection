// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, sort_child_properties_last, unnecessary_import, prefer_interpolation_to_compose_strings, unused_import, sized_box_for_whitespace, avoid_print, await_only_futures

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
import 'package:youcollection/user-panel/checkout_screen.dart';
import 'package:youcollection/user-panel/payment_screen.dart';

import '../controllers/cart_price_controller.dart';
import '../utils/app-constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
          "Cart Screen",
          style: TextStyle(fontFamily: 'font', color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection("cartOrder")
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
                  CartModel cartModel = CartModel(
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
                    productQuantity: productData["productQuantity"],
                    productTotalPrice: productData["productTotalPrice"],
                  );

                  // calculate price
                  productPriceController.fetchProductPrice();
                  return SwipeActionCell(
                    key: ObjectKey(cartModel.productId),
                    trailingActions: [
                      SwipeAction(
                          title: "Delete",
                          forceAlignmentToBoundary: true,
                          performsFirstActionWithFullSwipe: true,
                          onTap: (CompletionHandler handler) async {
                            print("dleted");
                            await FirebaseFirestore.instance
                                .collection("cart")
                                .doc(user!.uid)
                                .collection("cartOrder")
                                .doc(cartModel.productId)
                                .delete();
                          })
                    ],
                    child: Card(
                      elevation: 5,
                      color: AppConstant.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppConstant.appMainColor,
                          backgroundImage:
                              NetworkImage(cartModel.productImages[0]),
                        ),
                        title: Text(cartModel.productName),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(cartModel.productTotalPrice.toString()),
                            SizedBox(
                              width: Get.width / 20.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (cartModel.productQuantity > 1) {
                                  await FirebaseFirestore.instance
                                      .collection("cart")
                                      .doc(user!.uid)
                                      .collection("cartOrder")
                                      .doc(cartModel.productId)
                                      .update({
                                    "productQuantity":
                                        cartModel.productQuantity - 1,
                                    "productTotalPrice":
                                        (double.parse(cartModel.fullPrice) *
                                            (cartModel.productQuantity - 1))
                                  });
                                }
                              },
                              child: CircleAvatar(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontFamily: 'font1',
                                      color: AppConstant.white),
                                ),
                                backgroundColor: AppConstant.appRedColor,
                                radius: 12.0,
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 20.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (cartModel.productQuantity > 0) {
                                  await FirebaseFirestore.instance
                                      .collection("cart")
                                      .doc(user!.uid)
                                      .collection("cartOrder")
                                      .doc(cartModel.productId)
                                      .update({
                                    "productQuantity":
                                        cartModel.productQuantity + 1,
                                    "productTotalPrice":
                                        (double.parse(cartModel.fullPrice) +
                                            double.parse(cartModel.fullPrice) *
                                                (cartModel.productQuantity))
                                  });
                                }
                              },
                              child: CircleAvatar(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontFamily: 'font1',
                                      color: AppConstant.white),
                                ),
                                backgroundColor: AppConstant.appgreenColor,
                                radius: 12.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                " Total Price:"
                "${productPriceController.totalPrice.value.toStringAsFixed(1)}:PKR",
                style: TextStyle(
                    fontFamily: 'font1',
                    color: AppConstant.appTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckOutButton(
                  title: "PayNow",
                  onTap: () {
                    Get.to(() => PaymentScreen());
                  }),
            )
          ],
        ),
      ),
    );
  }
}
