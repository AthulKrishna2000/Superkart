import 'package:ecom/controllers/get_user_data_controller.dart';
import 'package:ecom/controllers/signin_controller.dart';
import 'package:ecom/screens/admin-panel/admin_main_screen.dart';
import 'package:ecom/screens/auth-ui/forget_password_screen.dart';
import 'package:ecom/screens/auth-ui/signup_screen.dart';
import 'package:ecom/screens/main-screen.dart';
import 'package:ecom/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppConstant.appSecendoryColor,
            title: const Text(
              'Sign in',
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
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(
                        () => TextFormField(
                          controller: userPassword,
                          obscureText: signInController.isPasswordVisible.value,
                          cursorColor: AppConstant.appSecendoryColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signInController.isPasswordVisible.toggle();
                              },
                              child: signInController.isPasswordVisible.value
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgetPasswordScreen());
                    },
                    child: const Text(
                      'Forget password?',
                      style: TextStyle(
                          color: AppConstant.appSecendoryColor,
                          fontWeight: FontWeight.bold),
                    ),
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
                      String password = userPassword.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar('Error', "Please enter all details",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appSecendoryColor,
                            colorText: AppConstant.apptextColor);
                      } else {
                        UserCredential? userCredential = await signInController
                            .signInMethod(email, password);
// get documents using get user controller
                        var userData = await getUserDataController
                            .getUserData(userCredential!.user!.uid);


                        if (userCredential != null) {
                          if (userCredential.user!.emailVerified) {


                            //
                            if (userData[0]['isAdmin']== true) {
                              
                               Get.snackbar('Success Admin Login', "Login  Success",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecendoryColor,
                                colorText: AppConstant.apptextColor);
                                Get.offAll(()=>const AdminMainScreen());
                            } else {
                              Get.snackbar('Success User Login', "Login  Success",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecendoryColor,
                                colorText: AppConstant.apptextColor);
                              Get.offAll(() => const Mainscreen());
                            }
                           
                            
                          } else {
                            Get.snackbar('Error',
                                "Please verifiy tour email before login",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecendoryColor,
                                colorText: AppConstant.apptextColor);
                          }
                        }
                      }
                    },
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: AppConstant.appSecendoryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAll(() => const SignupScreen()),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            color: AppConstant.appSecendoryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
