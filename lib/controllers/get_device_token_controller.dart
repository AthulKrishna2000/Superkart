// import 'package:ecom/utils/app_constant.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';

// class GetDeviceTokenController extends GetxController {
//   String? deviceToken;
//   @override
//   void onInit() {
//     super.onInit();
//     getDeviceToken();
//   }

//   Future<void> getDeviceToken() async {
//     try {
//       String? token = await FirebaseMessaging.instance.getToken();
//       if (token != null) {
//         deviceToken = token;
//         print("token : $deviceToken");
//         update();
//       } else {}
//     } catch (e) {
//       Get.snackbar('Error', '$e',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppConstant.appSecendoryColor,
//           colorText: AppConstant.apptextColor);
//     }
//   }
// }
