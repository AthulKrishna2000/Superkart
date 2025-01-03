import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecom/models/user_moidel.dart';
import 'package:ecom/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // for password visibility
  var isPasswordVisible = false.obs;

  // ignore: body_might_complete_normally_nullable
  Future<UserCredential?> signUpMethod(
    String userName,
    String userEmail,
    String userPhone,
    String userCity,
    String userPassword,
    String userdDeviceToken,
  ) async {
    // final GetDeviceTokenController getDeviceTokenController =
    //     Get.put(GetDeviceTokenController());
    try {
      EasyLoading.show(status: 'please wait');
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
      // send verification email
      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
          uId: userCredential.user!.uid,
          username: userName,
          email: userEmail,
          phone: userPhone,
          userImg: '',
          // userDeviceToken: getDeviceTokenController.deviceToken.toString(),
          userDeviceToken: userdDeviceToken,
          country: '',
          userAddress: '',
          street: '',
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now(),
          city: userCity);
      // add data to firebase
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());
      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecendoryColor,
          colorText: AppConstant.apptextColor);
    }
  }
}
