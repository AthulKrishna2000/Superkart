import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/product_model.dart';

import 'package:get/get.dart';

class EditProductController extends GetxController {
  final ProductModel productModel;
  RxList<String> images = <String>[].obs;

  EditProductController({required this.productModel});

  @override
  void onInit() {
    super.onInit();
    fetchImages();
  }

  Future<void> fetchImages() async {
    try {
      final productdata = await FirebaseFirestore.instance
          .collection('products')
          .doc(productModel.productId)
          .get();

      if (productdata.exists && productdata.data() != null) {
        images.value =
            List<String>.from(productdata.data()!['productImages'] ?? []);
      }
    } catch (e) {
      print("error : $e");
    }
  }

   Future<void> deleteImage(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productModel.productId)
          .update({
        'images': FieldValue.arrayRemove([imageUrl]),
      });

      images.remove(imageUrl); // Update the observable list
      Get.snackbar('Success', 'Image deleted successfully');
    } catch (e) {
      print('Error deleting image: $e');
      Get.snackbar('Error', 'Failed to delete image');
    }
  }
}
