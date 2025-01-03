import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LengthController extends GetxController {
  RxInt totalProducts = 0.obs;
  RxInt totalusers = 0.obs;
  RxInt totalcategory = 0.obs;
  RxInt totalOrders = 0.obs;

  @override
  void onInit() {
    super.onInit();
    FirebaseFirestore.instance
        .collection('users')
        .where('isAdmin', isEqualTo: false)
        .snapshots()
        .listen(
      (snapshot) {
        totalusers.value = snapshot.size;
      },
    );
    FirebaseFirestore.instance.collection('products').snapshots().listen(
      (snapshot) {
        totalProducts.value = snapshot.size;
      },
    );
    FirebaseFirestore.instance.collection('categories').snapshots().listen(
      (snapshot) {
        totalcategory.value = snapshot.size;
      },
    );
    getTotalConfirmedOrders();
  }

  Future<Object> getTotalConfirmedOrders() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    // int totalOrders = 0;

    try {
      // Step 1: Get all documents in the 'orders' collection
      QuerySnapshot ordersSnapshot = await firestore.collection('orders').get();

      for (QueryDocumentSnapshot orderDoc in ordersSnapshot.docs) {
        // Step 2: Get the 'confirmOrders' subcollection for each order
        CollectionReference confirmOrdersRef =
            orderDoc.reference.collection('confirmOrders');

        // Step 3: Fetch all documents in the 'confirmOrders' subcollection
        QuerySnapshot confirmOrdersSnapshot = await confirmOrdersRef.get();

        // Step 4: Add the count of documents to the total
        totalOrders += confirmOrdersSnapshot.docs.length;
      }

      return totalOrders;
    } catch (e) {
      print("Error fetching orders: $e");
      return 0;
    }
  }
}
