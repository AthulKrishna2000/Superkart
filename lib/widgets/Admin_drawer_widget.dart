import 'package:ecom/screens/admin-panel/Admin_all_category_screen.dart';
import 'package:ecom/screens/admin-panel/Admin_all_product_screen.dart';
import 'package:ecom/screens/admin-panel/admin_all_orders_screen.dart';
import 'package:ecom/screens/admin-panel/all_users_screen.dart';
import 'package:ecom/screens/auth-ui/welcomscreen.dart';
import 'package:ecom/screens/user-panel/all_categories_screen.dart';
import 'package:ecom/screens/user-panel/all_order_screen.dart';
import 'package:ecom/screens/user-panel/all_product_screen.dart';
import 'package:ecom/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDrawerWidget extends StatefulWidget {
  const AdminDrawerWidget({super.key});

  @override
  State<AdminDrawerWidget> createState() => _AdminDrawerWidgetState();
}

class _AdminDrawerWidgetState extends State<AdminDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        backgroundColor: AppConstant.appMainColor,
        child: Wrap(
          runSpacing: 10,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'Athul',
                  style: TextStyle(color: AppConstant.apptextColor),
                ),
                subtitle: Text(
                  'ver 1.0.1',
                  style: TextStyle(color: AppConstant.apptextColor),
                ),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.appSecendoryColor,
                  child: Text(
                    'A',
                    style: TextStyle(color: AppConstant.apptextColor),
                  ),
                ),
              ),
            ),
            const Divider(
              indent: 10.0,
              endIndent: 10.0,
              color: Colors.grey,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'Home',
                  style: TextStyle(color: AppConstant.apptextColor),
                ),
                leading: Icon(Icons.home, color: AppConstant.apptextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.apptextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                onTap: () {
                  Get.to(() => AllUsersScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'users',
                  style: TextStyle(color: AppConstant.apptextColor),
                ),
                leading: Icon(Icons.person, color: AppConstant.apptextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.apptextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                onTap: () {
                  Get.to(() => AdminAllOrdersScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'orders',
                  style: TextStyle(color: AppConstant.apptextColor),
                ),
                leading:
                    Icon(Icons.shopping_bag, color: AppConstant.apptextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.apptextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                onTap: () {
                  Get.to(() => AdminAllProductScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'Product',
                  style: TextStyle(color: AppConstant.apptextColor),
                ),
                leading: Icon(Icons.production_quantity_limits,
                    color: AppConstant.apptextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.apptextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                onTap: () {
                  Get.to(() => AdminAllCategoryScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'categories',
                  style: TextStyle(color: AppConstant.apptextColor),
                ),
                leading: Icon(Icons.category, color: AppConstant.apptextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.apptextColor),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'Contact',
                  style: TextStyle(color: AppConstant.apptextColor),
                ),
                leading: Icon(Icons.phone, color: AppConstant.apptextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.apptextColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                onTap: () async {
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  Get.offAll(() => const Welcomscreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text(
                  'Logout',
                  style: TextStyle(color: AppConstant.apptextColor),
                ),
                leading:
                    const Icon(Icons.logout, color: AppConstant.apptextColor),
                trailing: const Icon(Icons.arrow_forward,
                    color: AppConstant.apptextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
