import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannersController extends GetxController {
  RxList<String> bannersUrls = RxList<String>([]);

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
    fecthBannerUrls();
  }

  Future<void> fecthBannerUrls() async {
    try {
      QuerySnapshot bannersSnapshots =
          await FirebaseFirestore.instance.collection('banners').get();
      if (bannersSnapshots.docs.isNotEmpty) {
        bannersUrls.value = bannersSnapshots.docs
            .map((doc) => doc['imageUrl'] as String)
            .toList();
      }
    } catch (e) {
      // ignore: avoid_print
      print("error : $e");
    }
  }
}
