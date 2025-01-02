import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controllers/get_all_user_length_controller.dart';
import 'package:ecom/controllers/is_sale_controller.dart';
import 'package:ecom/models/categories_model.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/models/user_moidel.dart';
import 'package:ecom/screens/admin-panel/Admin_single_product_screen.dart';
import 'package:ecom/screens/admin-panel/add_produt_screnn.dart';
import 'package:ecom/screens/admin-panel/edit_product_screen.dart';
import 'package:ecom/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AdminAllProductScreen extends StatefulWidget {
  const AdminAllProductScreen({super.key});

  @override
  State<AdminAllProductScreen> createState() => _AdminAllProductscreenState();
}

class _AdminAllProductscreenState extends State<AdminAllProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("All product "),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(() => AddProdutScrenn());
              },
              child: Icon(
                Icons.add,
                color: AppConstant.apptextColor,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
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
            return Center(
              child: Text('No product found!'),
            );
          }
          if (snapshot.data != null) {
            // ignore: sized_box_for_whitespace
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                ProductModel productModel = ProductModel(
                    productId: data['productId'],
                    categoryId: data['categoryId'],
                    productName: data['productName'],
                    categoryName: data['categoryName'],
                    salePrice: data['salePrice'],
                    fullPrice: data['fullPrice'],
                    productImages: data['productImages'],
                    deliveryTime: data['deliveryTime'],
                    isSale: data['isSale'],
                    productDescription: data['productDescription']);
                return SwipeActionCell(
                    key: ObjectKey(productModel.productId),

                    /// this key is necessary
                    trailingActions: <SwipeAction>[
                      SwipeAction(
                          title: "delete ",
                          onTap: (CompletionHandler handler) async {
                            await Get.defaultDialog(
                              title: "Delete Product",
                              content: Text(
                                  "Are you sure you want to delete this product?"),
                              textCancel: "Cancel",
                              textConfirm: "Delete",
                              contentPadding: EdgeInsets.all(10.0),
                              confirmTextColor: Colors.white,
                              onCancel: () {},
                              onConfirm: () async {
                                Get.back(); // Close the dialog
                                EasyLoading.show(status: 'Please wait..');

                                await FirebaseFirestore.instance
                                    .collection('products')
                                    .doc(productModel.productId)
                                    .delete();

                                EasyLoading.dismiss();
                              },
                              buttonColor: Colors.red,
                              cancelTextColor: Colors.black,
                            );
                          },
                          color: Colors.red),
                    ],
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          Get.to(() => AdminSingleProductScreen(
                                productModel: productModel,
                              ));
                        },
                        leading: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              productModel.productImages[0]),
                        ),
                        title: Row(
                          children: [
                            Text(productModel.productName),
                          ],
                        ),
                        subtitle: Text(productModel.productId),
                        trailing: GestureDetector(
                            onTap: () {
                              // ignore: non_constant_identifier_names
                              final isSaleController =
                                  Get.put(IsSaleController());
                              isSaleController
                                  .setIsSaleOldValue(productModel.isSale);
                              Get.to(() => EditProductScreen(
                                  productModel: productModel));
                            },
                            child: Icon(Icons.edit)),
                      ),
                    ));
              },
            );
          }
          return Text("error1");
        },
      ),
    );
  }
}
