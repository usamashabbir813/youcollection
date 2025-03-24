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
  bool hasSubmittedReview = false; // To track if the user already reviewed

  @override
  void initState() {
    super.initState();
    _checkIfReviewed(); // Check if the user has already submitted a review
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  // Function to check if the user has already submitted a review
  Future<void> _checkIfReviewed() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    DocumentSnapshot reviewSnapshot = await FirebaseFirestore.instance
        .collection("products")
        .doc(widget.orderModel.productId)
        .collection("reviews")
        .doc(user.uid)
        .get();

    if (reviewSnapshot.exists) {
      setState(() {
        hasSubmittedReview = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          "Add Reviews",
          style: TextStyle(fontFamily: 'font', color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Add your rating and reviews",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'font1',
                  color: AppConstant.appTextColor),
            ),
            const SizedBox(height: 20.0),
            RatingBar.builder(
              initialRating: 0,
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
                  ? (double
                      rating) {} // Disable rating update by providing an empty function
                  : (double rating) {
                      setState(() {
                        productRating = rating;
                      });
                    },
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Feedback",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'font1',
                  color: AppConstant.appTextColor),
            ),
            TextFormField(
              controller: feedbackController,
              enabled: !hasSubmittedReview, // Disable if already reviewed
              decoration: InputDecoration(
                labelText: hasSubmittedReview
                    ? "You have already submitted a review"
                    : "Share your feedback",
                labelStyle: TextStyle(color: AppConstant.appTextColor),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: hasSubmittedReview ||
                      productRating == 0 ||
                      feedbackController.text.trim().isEmpty
                  ? null // Disable button if already submitted or invalid input
                  : () async {
                      EasyLoading.show(status: "Please wait...");
                      try {
                        User? user = FirebaseAuth.instance.currentUser;
                        ReviewModel reviewModel = ReviewModel(
                          customerName: widget.orderModel.customerName,
                          customerPhone: widget.orderModel.customerPhone,
                          customerDeviceToken:
                              widget.orderModel.customerDeviceToken,
                          customerId: widget.orderModel.customerId,
                          feedback: feedbackController.text.trim(),
                          rating: productRating.toString(),
                          createdAt: DateTime.now(),
                        );

                        await FirebaseFirestore.instance
                            .collection("products")
                            .doc(widget.orderModel.productId)
                            .collection("reviews")
                            .doc(user!.uid)
                            .set(reviewModel.toMap());

                        EasyLoading.dismiss();

                        // Show success message
                        Get.snackbar(
                          'Review Submitted',
                          "Your review has been successfully submitted!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appMainColor,
                          colorText: AppConstant.appTextColor,
                          duration: const Duration(seconds: 3),
                        );

                        // Navigate to All Orders Screen
                        Get.off(() => AllOrdersScreen());
                      } catch (error) {
                        EasyLoading.dismiss();
                        Get.snackbar(
                          'Review Submission Failed',
                          "Something went wrong. Please try again!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: AppConstant.appTextColor,
                          duration: const Duration(seconds: 3),
                        );
                      }
                    },
              child: const Text(
                "Submit Review",
                style: TextStyle(
                    fontFamily: 'font1',
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
