// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_import, prefer_interpolation_to_compose_strings, unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youcollection/Button/button.dart';
import 'package:youcollection/Button/comon_button.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.productModel.productName),
                              Icon(AppIcon.favourite)
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Text("PKR: " + widget.productModel.fullPrice)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                              "Category: " + widget.productModel.categoryName)),
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
                          Button(title: "Add to Card", onTap: () {}),
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
}
