// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, sort_child_properties_last, unnecessary_import, prefer_interpolation_to_compose_strings, unused_import, sized_box_for_whitespace, avoid_print, await_only_futures, unused_field, unused_local_variable, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:youcollection/Button/checkout_button.dart';
import 'package:youcollection/controllers/get_customer_device_token_controller.dart';
import 'package:youcollection/models/cart_model.dart';
import 'package:youcollection/services/place_order_service.dart';

import '../controllers/cart_price_controller.dart';
import '../utils/app-constant.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? customerToken;
  String? name;
  String? phone;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Checkout Screen ",
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
                  title: "Confirm Order",
                  onTap: () {
                    showCustomBottomSheet();
                  }),
            )
          ],
        ),
      ),
    );
  }

  void showCustomBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          color: AppConstant.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Container(
                  height: 55.0,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontFamily: 'font1',
                          fontWeight: FontWeight.bold,
                          color: AppConstant.appTextColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        hintStyle: TextStyle(fontSize: 12.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Container(
                  height: 55.0,
                  child: TextFormField(
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(
                          fontFamily: 'font1',
                          fontWeight: FontWeight.bold,
                          color: AppConstant.appTextColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        hintStyle: TextStyle(fontSize: 12.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Container(
                  height: 55.0,
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                        labelText: "Address",
                        labelStyle: TextStyle(
                          fontFamily: 'font1',
                          fontWeight: FontWeight.bold,
                          color: AppConstant.appTextColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        hintStyle: TextStyle(fontSize: 12.0)),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstant.appMainColor,
                  padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                ),
                onPressed: () async {
                  if (nameController.text != '' &&
                      phoneController.text != '' &&
                      addressController.text != '') {
                    String name = nameController.text.trim();
                    String phone = phoneController.text.trim();
                    String address = addressController.text.trim();
                    String customerToken = await getCustomerDeviceToken();
                    // place order service
                    placeOrder(
                      context: context,
                      customerName: name,
                      customerPhone: phone,
                      customerAddress: address,
                      customerDeviceToken: customerToken,
                    );
                  } else {
                    print("Pease fill all details");
                  }
                },
                child: Text(
                  "Place Order",
                  style: TextStyle(
                    fontFamily: 'font1',
                    fontWeight: FontWeight.bold,
                    color: AppConstant.appTextColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: AppConstant.apptransparentColor,
      isDismissible: true,
      enableDrag: true,
      elevation: 6,
    );
  }
}
