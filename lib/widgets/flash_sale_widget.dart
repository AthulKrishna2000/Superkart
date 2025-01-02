import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:ecom/models/categories_model.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/screens/user-panel/product_details_screen.dart';
import 'package:ecom/utils/app_constant.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('products')
            .where('isSale', isEqualTo: true)
            .get(),
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
          if (snapshot.data!.docs.isEmpty) {
            print("list ${snapshot.data!.docs}");
            return Center(
              child: Text('No product found!'),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            final docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              print('No matching documents found.');
              return Center(child: Text('No products found!'));
            }
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
                  final productData = snapshot.data!.docs[index];
                  ProductModel productModel = ProductModel(
                      productId: productData['productId'],
                      categoryId: productData['categoryId'],
                      productName: productData['productName'],
                      categoryName: productData['categoryName'],
                      salePrice: productData['salePrice'],
                      fullPrice: productData['fullPrice'],
                      productImages: productData['productImages'],
                      deliveryTime: productData['deliveryTime'],
                      isSale: productData['isSale'],
                      productDescription: productData['productDescription']);
                  // CategoriesModel categoriesModel = CategoriesModel(
                  // categoryId: snapshot.data!.docs[index]['categoryId'],
                  // categoryName: snapshot.data!.docs[index]['categoryName'],
                  // categoryImg: snapshot.data!.docs[index]['categoryImg'],
                  // );
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ProductDetailsScreen(
                                productModel: productModel,
                              ));
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
                                  productModel.productImages[0]),
                              title: Center(
                                child: Text(
                                  productModel.categoryName,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ),
                              footer: Row(
                                children: [
                                  Text(
                                    "Rs${productModel.salePrice}",
                                    style: TextStyle(fontSize: 10.0),
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Text(
                                    productModel.fullPrice,
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        color: AppConstant.appSecendoryColor,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              ),
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
