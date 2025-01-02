import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controllers/is_sale_controller.dart';
import 'package:ecom/models/categories_model.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/screens/admin-panel/Admin_all_product_screen.dart';
import 'package:ecom/screens/admin-panel/edit_product_controller.dart';

import 'package:ecom/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductScreen extends StatefulWidget {
  ProductModel productModel;
  EditProductScreen({super.key, required this.productModel});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  IsSaleController isSaleController = Get.put(IsSaleController());
  TextEditingController productNameCotroller = TextEditingController();
  TextEditingController salePriceCotroller = TextEditingController();
  TextEditingController fullpriceCotroller = TextEditingController();
  TextEditingController deliveryTimeCotroller = TextEditingController();
  TextEditingController productDescriptionCotroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
  RxList<String> imageUrls = <String>[].obs;

  @override
  void initState() {
    super.initState();
    productNameCotroller.text = widget.productModel.productName;
    salePriceCotroller.text = widget.productModel.salePrice;
    fullpriceCotroller.text = widget.productModel.fullPrice;
    deliveryTimeCotroller.text = widget.productModel.deliveryTime;
    productDescriptionCotroller.text = widget.productModel.productDescription;
  }

  @override
  Widget build(BuildContext context) {
    EditProductController editProductController =
        Get.put(EditProductController(productModel: widget.productModel));

    return Scaffold(
      appBar: AppBar(
        title: Text("edit products:${widget.productModel.productName}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.4,
              width: Get.width,
              // color: Colors.amber,
              child: Obx(
                () {
                  if (editProductController.images.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: editProductController.images.length,
                    itemBuilder: (context, index) {
                      final imageurl = editProductController.images[index];

                      return Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(imageurl),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              onPressed: () {
                                editProductController.deleteImage(imageurl);
                              },
                              icon: Icon(
                                Icons.delete,
                                // color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              height: Get.height * 0.4,
              width: Get.width,
              // color: Colors.green,
              child: FutureBuilder(
                future:
                    FirebaseFirestore.instance.collection('categories').get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      child: Text('No categorie found!'),
                    );
                  }
                  if (snapshot.data != null) {
                    // ignore: sized_box_for_whitespace
                    return Column(
                      children: [
                        Text(
                          'select a category',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: Get.height * 0.3,
                          width: Get.width,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data!.docs[index];
                              CategoriesModel categoriesModel = CategoriesModel(
                                categoryId: data['categoryId'],
                                categoryName: data['categoryName'],
                                categoryImg: data['categoryImg'],
                              );

                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  onTap: () {
                                    showCustomBottomSheet(
                                        categoryid: categoriesModel.categoryId,
                                        categoryname:
                                            categoriesModel.categoryName);
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        categoriesModel.categoryImg),
                                  ),
                                  title: Text(categoriesModel.categoryId),
                                  subtitle: Text(categoriesModel.categoryName),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return Text("error1");
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void showCustomBottomSheet(
      {required String categoryid, required String categoryname}) {
    Get.bottomSheet(
      Container(
        height: Get.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("category : $categoryname"),
              Container(
                height: 50,
                width: Get.width,
                // color: Colors.amber,
                child:
                    GetBuilder<IsSaleController>(builder: (isSaleController) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("is sale"),
                          Switch(
                              value: isSaleController.isSale.value,
                              activeColor: AppConstant.appMainColor,
                              onChanged: (value) {
                                isSaleController.toggleIsSale(value);
                              })
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: productNameCotroller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    hintText: "Product Name",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              // Container(
              //   height: 65,
              //   margin: EdgeInsets.symmetric(horizontal: 10.0),
              //   child: TextFormField(
              //     cursorColor: AppConstant.appMainColor,
              //     textInputAction: TextInputAction.next,
              //     controller: imagecontroller,
              //     decoration: InputDecoration(
              //       contentPadding: EdgeInsets.symmetric(
              //         horizontal: 10.0,
              //       ),
              //       hintText: "Enter image url",
              //       hintStyle: TextStyle(fontSize: 12.0),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(10.0),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // IconButton(
              //     onPressed: () {
              //       if (imagecontroller.text.isNotEmpty) {
              //         setState(() {
              //           imageUrls.add(imagecontroller.text);
              //           // print(imagecontroller.text.trim());
              //           // print(imageUrls.length);
              //           imagecontroller.clear();
              //         });
              //       }
              //     },
              //     icon: Icon(Icons.add)),
              SizedBox(height: 10),
              // Obx(() {
              //   return imageUrls.isNotEmpty
              //       ? Container(
              //           height: 150,
              //           padding: EdgeInsets.all(8),
              //           child: GridView.builder(
              //             gridDelegate:
              //                 SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 3,
              //               crossAxisSpacing: 8.0,
              //               mainAxisSpacing: 8.0,
              //             ),
              //             itemCount: imageUrls.length,
              //             itemBuilder: (context, index) {
              //               return ClipRRect(
              //                 borderRadius: BorderRadius.circular(8.0),
              //                 child: Image.network(
              //                   imageUrls[index],
              //                   fit: BoxFit.cover,
              //                   loadingBuilder:
              //                       (context, child, loadingProgress) {
              //                     if (loadingProgress == null) {
              //                       return child;
              //                     }
              //                     return Center(
              //                       child: CircularProgressIndicator(
              //                         value:
              //                             loadingProgress.expectedTotalBytes !=
              //                                     null
              //                                 ? loadingProgress
              //                                         .cumulativeBytesLoaded /
              //                                     (loadingProgress
              //                                             .expectedTotalBytes ??
              //                                         1)
              //                                 : null,
              //                       ),
              //                     );
              //                   },
              //                 ),
              //               );
              //             },
              //           ),
              //         )
              //       : SizedBox.shrink();
              // }),
              SizedBox(height: 10),
              Obx(() {
                return isSaleController.isSale.value
                    ? Container(
                        height: 65,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          cursorColor: AppConstant.appMainColor,
                          textInputAction: TextInputAction.next,
                          controller: salePriceCotroller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            hintText: "Sale Price",
                            hintStyle: TextStyle(fontSize: 12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink();
              }),
              SizedBox(height: 10.0),
              Container(
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: fullpriceCotroller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    hintText: "Full Price",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: deliveryTimeCotroller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    hintText: "Delivery Time",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: productDescriptionCotroller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    hintText: "Product Desc",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(imageUrls);
                  try {
                    ProductModel newproductModel = ProductModel(
                      productId: widget.productModel.productId,
                      categoryId: categoryid,
                      productName: productNameCotroller.text.trim(),
                      categoryName: categoryname,
                      salePrice: salePriceCotroller.text != ''
                          ? salePriceCotroller.text.trim()
                          : '',
                      fullPrice: fullpriceCotroller.text.trim(),
                      productImages: widget.productModel.productImages,
                      deliveryTime: deliveryTimeCotroller.text.trim(),
                      isSale: isSaleController.isSale.value,
                      productDescription:
                          productDescriptionCotroller.text.trim(),
                    );
                    await FirebaseFirestore.instance
                        .collection('products')
                        .doc(widget.productModel.productId)
                        .update(newproductModel.toMap());
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("product add sucessfully"),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              navigator?.pop(context);
                            },
                            child: const Text("OK"),
                          )
                        ],
                      ),
                    );
                  } catch (e) {
                    print("error : $e");
                  }
                },
                child: Text("update"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
