// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_import, prefer_interpolation_to_compose_strings, unused_import, unused_local_variable, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youcollection/Button/button.dart';
import 'package:youcollection/Button/comon_button.dart';
import 'package:youcollection/models/cart_model.dart';
import 'package:youcollection/models/product-model.dart';

import '../utils/app-constant.dart';
import '../utils/app-icons-constant.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Product Details",
          style: TextStyle(fontFamily: 'font', color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            // product images
            SizedBox(
              height: Get.height / 60.0,
            ),
            CarouselSlider(
              items: widget.productModel.productImages
                  .map(
                    (imageUrls) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrls,
                        fit: BoxFit.cover,
                        width: Get.width - 10,
                        placeholder: (context, url) => ColoredBox(
                          color: AppConstant.white,
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(AppIcon.error),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  aspectRatio: 2.5,
                  viewportFraction: 1),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.productModel.productName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis, // Overflow
                              maxLines: 2,
                            ),
                          ),
                          Icon(AppIcon.favourite),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              widget.productModel.isSale == true &&
                                      widget.productModel.salePrice != ""
                                  ? Text(
                                      "PKR: " + widget.productModel.salePrice)
                                  : Text(
                                      "PKR: " + widget.productModel.fullPrice),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Category: " + widget.productModel.categoryName,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Text("Description: " +
                              widget.productModel.productDescription)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(title: "WhatsApp", onTap: () {}),
                          SizedBox(
                            width: 15.0,
                          ),
                          Button(
                              title: "Add to Card",
                              onTap: () async {
                                await checkProductExistence(uId: user!.uid);
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // check product exist or not
  Future<void> checkProductExistence({
    required String uId,
    int quantityIncrement = 1,
  }) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection("cart")
        .doc(uId)
        .collection("cartOrder")
        .doc(widget.productModel.productId.toString());
    DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      int currentQuantity = snapshot["productQuantity"];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice =
          double.parse(widget.productModel.fullPrice) * updatedQuantity;
      await documentReference.update({
        "productQuantity": updatedQuantity,
        "productTotalPrice": totalPrice,
      });
      print("product exists");
    } else {
      await FirebaseFirestore.instance.collection("cart").doc(uId).set(
        {
          "uId": uId,
          "createdAt": DateTime.now(),
        },
      );
      CartModel cartModel = CartModel(
          productId: widget.productModel.productId,
          categoryId: widget.productModel.categoryId,
          productName: widget.productModel.productName,
          categoryName: widget.productModel.categoryName,
          salePrice: widget.productModel.salePrice,
          fullPrice: widget.productModel.fullPrice,
          productImages: widget.productModel.productImages,
          deliveryTime: widget.productModel.deliveryTime,
          isSale: widget.productModel.isSale,
          productDescription: widget.productModel.productDescription,
          createdAt: widget.productModel.createdAt,
          updatedAt: widget.productModel.updatedAt,
          productQuantity: 1,
          productTotalPrice: double.parse(widget.productModel.fullPrice));
      await documentReference.set(cartModel.toMap());
      print("product added");
    }
  }
}
