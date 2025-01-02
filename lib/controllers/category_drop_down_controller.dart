import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryDropDownController extends GetxController {
  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
  RxString? selectedCategoryId = ''.obs;
  RxString? selectedCategoryName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategory();
  }

  Future<void> fetchCategory() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      List<Map<String, dynamic>> categoriesList = [];
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach(
        (DocumentSnapshot<Map<String, dynamic>> document) {
          categoriesList.add(
            {
              'categoryId': document.id,
              'categoryName': document['CategoryName'],
              'categoryImg': document['categoryImg']
            },
          );
        },
      );

      categories.value = categoriesList;
    } catch (e) {
      print("error : $e");
    }
  }

// set selected catgory

  void setSelectedCategoty(String? categoryId) {
    selectedCategoryId = categoryId?.obs;
    print("selected category id $selectedCategoryId");
    update();
  }

// fectch category name

  Future<String?> getCategortyName(String? categoryId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('categories').doc().get();

      if (snapshot.exists) {
        return snapshot.data()?['CategoryName'];
      } else {
        return null;
      }
    } catch (e) {
      print("error : $e");
    }
    return null;
  }

  // set selected catgoryname

  void setCategotyName(String? categoryName) {
    selectedCategoryName = categoryName?.obs;
    print("selected category id $selectedCategoryName");
    update();
  }
}
