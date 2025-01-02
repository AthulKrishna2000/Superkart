import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controllers/edit_category_controller.dart';
import 'package:ecom/models/categories_model.dart';
import 'package:ecom/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EditCategoryScreen extends StatefulWidget {
  CategoriesModel categoriesModel;
  EditCategoryScreen({super.key, required this.categoriesModel});

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
  RxString imageurl = "".obs;
  @override
  void initState() {
    super.initState();
    categoryNameController.text = widget.categoriesModel.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    EditCategoryController editCategoryController = Get.put(
        EditCategoryController(categoriesModel: widget.categoriesModel));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(widget.categoriesModel.categoryName),
      ),
      body: Column(
        children: [
          Obx(() {
            return Center(
              child: editCategoryController.categoryImg.value != ''
                  ? Stack(
                      children: [
                        Obx(() {
                          return CachedNetworkImage(
                            imageUrl: editCategoryController.categoryImg.value
                                .toString(),
                            fit: BoxFit.contain,
                            height: Get.height / 5.5,
                            width: Get.width / 2,
                            placeholder: (context, url) => const Center(
                                child: CupertinoActivityIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          );
                        }),
                        CachedNetworkImage(
                          imageUrl: editCategoryController.categoryImg.value
                              .toString(),
                          fit: BoxFit.contain,
                          height: Get.height / 5.5,
                          width: Get.width / 2,
                          placeholder: (context, url) =>
                              const Center(child: CupertinoActivityIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Positioned(
                          right: 10,
                          top: 0,
                          child: InkWell(
                            onTap: () async {
                              EasyLoading.show();
                              // await editCategory.deleteImagesFromStorage(
                              //     editCategory.categoryImg.value.toString());
                              await editCategoryController
                                  .deleteImageFromFireStore(
                                      editCategoryController.categoryImg.value
                                          .toString(),
                                      widget.categoriesModel.categoryId);
                              EasyLoading.dismiss();
                            },
                            child: const CircleAvatar(
                              backgroundColor: AppConstant.appSecendoryColor,
                              child: Icon(
                                Icons.close,
                                color: AppConstant.apptextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: 10.0),
                        Container(
                          height: 65,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            cursorColor: AppConstant.appMainColor,
                            textInputAction: TextInputAction.next,
                            controller: imagecontroller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              hintText: "Image url",
                              hintStyle: TextStyle(fontSize: 12.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (imagecontroller.text.isNotEmpty) {
                              // imageurl.add(imagecontroller.text.trim());
                              imageurl.value = imagecontroller.text;

                              // imagecontroller.clear(); // Clear after adding
                            } else {
                              Get.snackbar(
                                  "Error", "Please enter a valid image URL.");
                            }
                          },
                          icon: Icon(Icons.add),
                        ),
                        Obx(
                          () {
                            return imageurl.isNotEmpty
                                ? Container(
                                    height: Get.height * 0.3,
                                    width: Get.width * 0.5,
                                    child: Image.network(
                                      imageurl.value,
                                      fit: BoxFit.cover,
                                    ))
                                : Text(imageurl.value);
                          },
                        ),
                      ],
                    ),
            );
          }),
          const SizedBox(height: 10.0),
          Container(
            height: 65,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              cursorColor: AppConstant.appMainColor,
              textInputAction: TextInputAction.next,
              controller: categoryNameController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                hintText: "category name",
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
              EasyLoading.show();
              if (editCategoryController.categoryImg.value != '') {
                CategoriesModel categoriesModel = CategoriesModel(
                  categoryId: widget.categoriesModel.categoryId,
                  categoryName: categoryNameController.text.trim(),
                  categoryImg: widget.categoriesModel.categoryImg,
                );

                await FirebaseFirestore.instance
                    .collection('categories')
                    .doc(categoriesModel.categoryId)
                    .update(categoriesModel.toMap());
              } else {
                CategoriesModel categoriesModel = CategoriesModel(
                    categoryId: widget.categoriesModel.categoryId,
                    categoryName: categoryNameController.text.trim(),
                    categoryImg: imagecontroller.text);
                await FirebaseFirestore.instance
                    .collection('categories')
                    .doc(categoriesModel.categoryId)
                    .set(categoriesModel.toMap());
              }

              EasyLoading.dismiss();
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
  }
}
