import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:youcollection/models/order-model.dart';
import 'package:youcollection/models/review_model.dart';

import '../utils/app-constant.dart';
import 'all_orders_screen.dart';

class AddReviewScreen extends StatefulWidget {
  final OrderModel orderModel;
  const AddReviewScreen({super.key, required this.orderModel});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  TextEditingController feedbackController = TextEditingController();
  double productRating = 0;
  bool hasSubmittedReview = false;

  @override
  void initState() {
    super.initState();
    _fetchExistingReview();
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  Future<void> _fetchExistingReview() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    DocumentSnapshot reviewSnapshot = await FirebaseFirestore.instance
        .collection("products")
        .doc(widget.orderModel.productId)
        .collection("reviews")
        .doc(user.uid)
        .get();

    if (reviewSnapshot.exists) {
      ReviewModel review =
          ReviewModel.fromMap(reviewSnapshot.data() as Map<String, dynamic>);

      setState(() {
        hasSubmittedReview = true;
        productRating = double.parse(review.rating);
        feedbackController.text = review.feedback;
      });
    }
  }

  Future<void> _submitReview() async {
    if (productRating == 0 || feedbackController.text.trim().isEmpty) {
      Get.snackbar(
          "Error", "Please provide a rating and feedback before submitting.",
          backgroundColor: Colors.red,
          colorText: AppConstant.appTextColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    EasyLoading.show(status: "Submitting review...");
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      ReviewModel reviewModel = ReviewModel(
        customerName: widget.orderModel.customerName,
        customerPhone: widget.orderModel.customerPhone,
        customerDeviceToken: widget.orderModel.customerDeviceToken,
        customerId: widget.orderModel.customerId,
        feedback: feedbackController.text.trim(),
        rating: productRating.toString(),
        createdAt: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection("products")
          .doc(widget.orderModel.productId)
          .collection("reviews")
          .doc(user.uid)
          .set(reviewModel.toMap());

      EasyLoading.dismiss();

      Get.snackbar('Success', "Your review has been submitted!",
          backgroundColor: AppConstant.appMainColor,
          colorText: AppConstant.appTextColor,
          snackPosition: SnackPosition.BOTTOM);

      setState(() {
        hasSubmittedReview = true;
      });

      Get.to(() => const AllOrdersScreen());
    } catch (error) {
      EasyLoading.dismiss();
      Get.snackbar('Error', "Failed to submit review. Try again later.",
          backgroundColor: AppConstant.appRedColor,
          colorText: AppConstant.appTextColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          "Add Review",
          style: TextStyle(fontFamily: 'font', color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Rate & Review",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppConstant.appTextColor),
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: productRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: hasSubmittedReview
                  ? (double value) {}
                  : (rating) {
                      setState(() {
                        productRating = rating;
                      });
                    },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: feedbackController,
              maxLines: 3,
              enabled: !hasSubmittedReview,
              decoration: InputDecoration(
                hintText: hasSubmittedReview
                    ? "Review submitted. Editing disabled."
                    : "Write your feedback...",
                hintStyle: TextStyle(color: AppConstant.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppConstant.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppConstant.appblackColor, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: hasSubmittedReview ? null : _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    hasSubmittedReview ? Colors.grey : AppConstant.appMainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                hasSubmittedReview ? "Review Submitted" : "Submit Review",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstant.appTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
