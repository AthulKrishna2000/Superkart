import 'package:ecom/controllers/forget_password__controller.dart';

import 'package:ecom/screens/auth-ui/signup_screen.dart';

import 'package:ecom/utils/app_constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppConstant.appSecendoryColor,
            title: const Text(
              'Forget password',
              style: TextStyle(color: AppConstant.apptextColor),
            ),
          ),
          // ignore: avoid_unnecessary_containers
          body: Container(
            child: Column(
              children: [
                isKeyboardVisible
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          LottieBuilder.network(
                              'https://lottie.host/c6cb51c5-f011-4451-9fdf-7ac9905012f1/qTYAp4do8b.json')
                        ],
                      ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: userEmail,
                      cursorColor: AppConstant.appSecendoryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'Forget password?',
                    style: TextStyle(
                        color: AppConstant.appSecendoryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: Get.height / 18,
                  width: Get.width / 2,
                  decoration: const BoxDecoration(
                      color: AppConstant.appSecendoryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextButton(
                    onPressed: () async {
                      String email = userEmail.text.trim();

                      if (email.isEmpty) {
                        Get.snackbar('Error', "Please enter all details",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appSecendoryColor,
                            colorText: AppConstant.apptextColor);
                      } else {
                        String email = userEmail.text.trim();
                        forgetPasswordController.forgetPasswordMethod(email);
                      }
                    },
                    child: const Text(
                      'FORGET',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
