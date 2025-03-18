// ignore_for_file: file_names, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:youcollection/models/category-model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('categories').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 5.0,
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text("Error loading categories"),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No categories found'),
          );
        }

        return SizedBox(
          height: MediaQuery.of(context).size.height / 5.5,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              CategoriesModel categoriesModel = CategoriesModel(
                categoryId: doc['categoryId'],
                categoryImg: doc['categoryImg'],
                categoryName: doc['categoryName'],
                createdAt: doc['createdAt'],
                updatedAt: doc['updatedAt'],
              );

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: FillImageCard(
                  borderRadius: 20.0,
                  width: Get.width / 3.5,
                  heightImage: Get.height / 12.0,
                  imageProvider:
                      CachedNetworkImageProvider(categoriesModel.categoryImg),
                  title: Center(
                    child: Text(
                      categoriesModel.categoryName,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
