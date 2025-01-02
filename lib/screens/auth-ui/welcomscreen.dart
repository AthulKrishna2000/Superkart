import 'package:ecom/screens/auth-ui/signin_screen.dart';
import 'package:ecom/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Welcomscreen extends StatelessWidget {
  const Welcomscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        centerTitle: true,
        elevation: 0,
        title: const Text('Welcome to ecomm'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: Get.height * 0.4,
            width: Get.width,
            color: AppConstant.appMainColor,
            child: LottieBuilder.network(
                'https://lottie.host/c6cb51c5-f011-4451-9fdf-7ac9905012f1/qTYAp4do8b.json'),
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          const Text(
            "Happy Shopping",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Get.height * 0.07,
          ),
          Container(
            height: Get.height / 12,
            width: Get.width / 1.2,
            decoration: const BoxDecoration(
                color: AppConstant.appSecendoryColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton.icon(
              icon: Image.network(
                  'https://img.freepik.com/premium-vector/logo-google_798572-207.jpg?semt=ais_hybridhttps://img.freepik.com/premium-vector/logo-google_798572-207.jpg?semt=ais_hybrid'),
              onPressed: () {},
              label: const Text(
                'Sign in with google',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.08,
          ),
          Container(
            height: Get.height / 12,
            width: Get.width / 1.2,
            decoration: const BoxDecoration(
              color: AppConstant.appSecendoryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: TextButton.icon(
              icon: const Icon(
                Icons.email,
                color: Colors.white,
              ),
              onPressed: () {
                Get.to(() => const SigninScreen());
              },
              label: const Text(
                'Sign in with Email',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
