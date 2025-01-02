import 'package:get/get.dart';

class IsSaleController extends GetxController {
  RxBool isSale = false.obs;

  void toggleIsSale(bool vlaue) {
    isSale.value = vlaue;
    update();
  }

  void setIsSaleOldValue(bool vlaue) {
    isSale.value = vlaue;
    update();
  }
}
