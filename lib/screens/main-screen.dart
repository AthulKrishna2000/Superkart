import 'package:ecom/screens/auth-ui/welcomscreen.dart';
import 'package:ecom/screens/user-panel/All_flash_sale_products_screen.dart';
import 'package:ecom/screens/user-panel/all_categories_screen.dart';
import 'package:ecom/screens/user-panel/all_product_screen.dart';
import 'package:ecom/screens/user-panel/cart_scrreen.dart';
import 'package:ecom/utils/app_constant.dart';
import 'package:ecom/widgets/all_product_widget.dart';
import 'package:ecom/widgets/banner_widget.dart';
import 'package:ecom/widgets/category_widger.dart';
import 'package:ecom/widgets/costum_draw_widgets.dart';
import 'package:ecom/widgets/flash_sale_widget.dart';
import 'package:ecom/widgets/heding_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.apptextColor),
        backgroundColor: AppConstant.appMainColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppConstant.appSecendoryColor,
            statusBarIconBrightness: Brightness.light),
        title: Text(
          AppConstant.appMainName,
          style: const TextStyle(color: AppConstant.apptextColor),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => CartScrreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      drawer: const DrawWidgets(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 90.0,
            ),

            //banners
            const BannerWidget(),
            HedingWidget(
              headingTitle: 'Categories',
              headingSubTitle: 'According to your budget',
              onTap: () => Get.to(() => AllCategoriesScreen()),
              buttonText: "See More >",
            ),
            CategoryWidger(),
            HedingWidget(
              headingTitle: 'Flash sale',
              headingSubTitle: 'According to your budget',
              onTap: () {
                Get.to(() => AllFlashSaleProductsScreen());
              },
              buttonText: "See More >",
            ),
            FlashSaleWidget(),
            HedingWidget(
              headingTitle: 'All products',
              headingSubTitle: 'According to your budget',
              onTap: () {
                Get.to(() => AllProductScreen());
              },
              buttonText: "See More >",
            ),
            AllProductWidget()
          ],
        ),
      ),
    );
  }
}
