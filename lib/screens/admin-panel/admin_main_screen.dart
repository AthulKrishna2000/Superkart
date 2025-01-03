import 'package:ecom/controllers/length_controller.dart';
import 'package:ecom/widgets/Admin_drawer_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LengthController lengthController = Get.put(LengthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
      ),
      drawer: AdminDrawerWidget(),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "total numbers of users : ${lengthController.totalusers}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "total numbers of products : ${lengthController.totalProducts}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "total numbers of orders : ${lengthController.totalOrders}"),
            ),
          ],
        ),
      ),
    );
  }
}
