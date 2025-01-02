import 'package:ecom/models/product_model.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/utils/app_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminSingleProductScreen extends StatelessWidget {
  ProductModel productModel;
  AdminSingleProductScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(productModel.productName),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("product name : "),
                        Container(
                            width: Get.width / 2,
                            child: Text(
                              productModel.productName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("product prie : "),
                        Container(
                            width: Get.width / 2,
                            child: Text(
                              productModel.isSale == true
                                  ? productModel.salePrice
                                  : productModel.fullPrice,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery Time : "),
                        Container(
                          width: Get.width / 2,
                          child: Text(
                            productModel.deliveryTime,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Is sale: "),
                        Container(
                            width: Get.width / 2,
                            child: Text(
                              productModel.isSale == true ? 'true' : 'false',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 50,
                          foregroundImage:
                              NetworkImage(productModel.productImages[0]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 50,
                          foregroundImage:
                              NetworkImage(productModel.productImages[1]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
