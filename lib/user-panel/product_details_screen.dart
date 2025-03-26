// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_import, prefer_interpolation_to_compose_strings, unused_import, unused_local_variable, avoid_print, prefer_const_declarations, unnecessary_brace_in_string_interps, deprecated_member_use, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youcollection/Button/button_screen.dart';
import 'package:youcollection/Button/comon_button.dart';
import 'package:youcollection/controllers/rating_controller.dart';
import 'package:youcollection/models/cart_model.dart';
import 'package:youcollection/models/product-model.dart';

import '../models/category-model.dart';
import '../models/review_model.dart';
import '../utils/app-constant.dart';
import '../utils/app-icons-constant.dart';
import 'cart_screen.dart';

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
    CalculateProductRatingController calculateProductRatingController = Get.put(
        CalculateProductRatingController(widget.productModel.productId));
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
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(AppIcon.cart),
            ),
          )
        ],
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
                    // Review Section with Improved Null Check
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Obx(() {
                            // Ensuring rating is at least 0.0 to prevent null errors
                            double rating = calculateProductRatingController
                                .averageRating.value;

                            return RatingBar.builder(
                              glow: false,
                              ignoreGestures: true,
                              initialRating: rating > 0
                                  ? rating
                                  : 0.0, // Avoids negative values
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 25,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (value) {},
                            );
                          }),
                        ),
                        SizedBox(
                            width:
                                10), // Proper spacing between rating stars and number
                        Obx(() {
                          double rating = calculateProductRatingController
                              .averageRating.value;
                          return Text(
                            rating > 0
                                ? rating.toStringAsFixed(1)
                                : "No Rating", // Display message if no rating
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          );
                        }),
                      ],
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
                                      "PKR: " + widget.productModel.salePrice,
                                      style: TextStyle(
                                          fontFamily: 'font1',
                                          fontWeight: FontWeight.bold,
                                          color: AppConstant.appTextColor),
                                    )
                                  : Text(
                                      "PKR: " + widget.productModel.fullPrice,
                                      style: TextStyle(
                                          fontFamily: 'font1',
                                          fontWeight: FontWeight.bold,
                                          color: AppConstant.appTextColor),
                                    ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Category: " + widget.productModel.categoryName,
                            style: TextStyle(
                                fontFamily: 'font1',
                                fontWeight: FontWeight.bold,
                                color: AppConstant.appTextColor),
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
                          Button(
                            title: "WhatsApp",
                            onTap: () {
                              sendMessageOnWhatsapp(
                                productModel: widget.productModel,
                              );
                            },
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Button(
                              title: "Add to Cart",
                              onTap: () async {
                                EasyLoading.show(status: 'Processing...');
                                await checkProductExistence(uId: user!.uid);
                                EasyLoading.dismiss();
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // reveiws
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "Customer Reviews 📝!!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: Divider(
                  color: AppConstant.appMainColor,
                  thickness: 2.5,
                ),
              ),
            ]),

            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('products')
                    .doc(widget.productModel.productId)
                    .collection('reviews')
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Icon(Icons.reviews, size: 40, color: Colors.grey),
                          Text(
                            "No reviews yet! Be the first to review this product.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  }

                  if (snapshot.data != null) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        ReviewModel reviewModel = ReviewModel(
                          customerName: data['customerName'],
                          customerPhone: data['customerPhone'],
                          customerDeviceToken: data['customerDeviceToken'],
                          customerId: data['customerId'],
                          feedback: data['feedback'],
                          rating: data['rating'],
                          createdAt: data['createdAt'],
                        );
                        return Card(
                          elevation: 5,
                          child: Stack(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppConstant.appMainColor,
                                  child: Text(
                                    reviewModel.customerName[0],
                                    style: TextStyle(
                                        fontFamily: 'font',
                                        color: AppConstant.appTextColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Text(reviewModel.customerName),
                                titleTextStyle: TextStyle(
                                    fontFamily: 'font1',
                                    color: AppConstant.appTextColor,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                                subtitle: Text(reviewModel.feedback),
                                subtitleTextStyle: TextStyle(
                                    fontFamily: 'font1',
                                    color: AppConstant.appTextColor,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),

                              // ✅ Stars + Rating in the Top Right Corner
                              Positioned(
                                top: 5, // ⭐ Adjust top position
                                right: 10, // ⭐ Adjust right position
                                child: Row(
                                  children: [
                                    RatingBar.builder(
                                      glow: false,
                                      ignoreGestures: true,
                                      initialRating:
                                          double.parse(reviewModel.rating),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 15, // Small stars
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) =>
                                          Icon(Icons.star, color: Colors.amber),
                                      onRatingUpdate: (value) {},
                                    ),
                                    SizedBox(
                                        width:
                                            5), // ⭐ Space between stars & number
                                    Text(
                                      reviewModel.rating, // Show rating number
                                      style: TextStyle(
                                          fontFamily: 'font1',
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> sendMessageOnWhatsapp(
      {required ProductModel productModel}) async {
    final number = "+923166708248";
    final message =
        "Hello You.Collection\n i want to know about this product \n ${productModel.productName} \n ${productModel.productId}";

    final url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
      Get.snackbar("Dear User", "Already added to cart",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appRedColor,
          colorText: AppConstant.appTextColor);
    } else {
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
      Get.snackbar("Success", "Successfully Added",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appMainColor,
          colorText: AppConstant.appTextColor);
    }
  }
}
