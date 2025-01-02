import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/categories_model.dart';
import 'package:ecom/screens/user-panel/single_category_product_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class CategoryWidger extends StatelessWidget {
  const CategoryWidger({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('categories').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No category found!'),
            );
          }
          if (snapshot.data != null) {
            // ignore: sized_box_for_whitespace
            return Container(
              height: Get.height / 5,
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  CategoriesModel categoriesModel = CategoriesModel(
                    categoryId: snapshot.data!.docs[index]['categoryId'],
                    categoryName: snapshot.data!.docs[index]['categoryName'],
                    categoryImg: snapshot.data!.docs[index]['categoryImg'],
                  );
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AllSingalCategoryProductScreen(
                              categoryId: categoriesModel.categoryId));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            child: FillImageCard(
                              borderRadius: 20.0,
                              width: Get.width / 4.0,
                              heightImage: Get.height / 9,
                              imageProvider: CachedNetworkImageProvider(
                                  categoriesModel.categoryImg),
                              title: Center(
                                  child: Text(
                                categoriesModel.categoryName,
                                style: TextStyle(fontSize: 12.0),
                              )),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          }
          return Text("error");
        });
  }
}
