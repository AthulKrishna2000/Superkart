import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/screens/auth-ui/signin_screen.dart';

import 'package:ecom/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: unused_field
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // for password visibility
  var isPasswordVisible = false.obs;

  // ignore: body_might_complete_normally_nullable
  Future<void> forgetPasswordMethod(
    String userEmail,
  ) async {
    try {
      EasyLoading.show(status: 'please wait');
      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
          'Requset Sent Sucessfully', 'password rest link sent to $userEmail',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecendoryColor,
          colorText: AppConstant.apptextColor);
      Get.offAll(() => const SigninScreen());
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecendoryColor,
          colorText: AppConstant.apptextColor);
    }
    // catch (e) {
    //   Get.snackbar('Error', '$e',
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: AppConstant.appSecendoryColor,
    //       colorText: AppConstant.apptextColor);
    // }
  }
}
