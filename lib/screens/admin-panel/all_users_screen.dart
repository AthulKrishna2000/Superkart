import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controllers/get_all_user_length_controller.dart';
import 'package:ecom/models/categories_model.dart';
import 'package:ecom/models/user_moidel.dart';
import 'package:ecom/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final GetAllUserLengthController getAllUserLengthController =
      Get.put(GetAllUserLengthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Obx(() {
          return Text(
              'users(${getAllUserLengthController.userCollectionLength.toString()})');
        }),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .orderBy('createdOn', descending: true)
            // .where('isAdmin', isEqualTo: false)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No user found!'),
            );
          }
          if (snapshot.data != null) {
            // ignore: sized_box_for_whitespace
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                UserModel userModel = UserModel(
                    uId: data['uId'],
                    username: data['username'],
                    email: data['email'],
                    phone: data['phone'],
                    userImg: data['userImg'],
                    userDeviceToken: data['userDeviceToken'],
                    country: data['country'],
                    userAddress: data['userAddress'],
                    street: data['street'],
                    isAdmin: data['isAdmin'],
                    isActive: data['isActive'],
                    createdOn: data['createdOn']);
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appSecendoryColor,
                      child: Text(userModel.username[0]),
                    ),
                    title: Row(
                      children: [
                        Text(userModel.username),
                        userModel.isAdmin == true
                            ? Text(
                                '    : Admin',
                                style: TextStyle(color: Colors.red),
                              )
                            : Text(
                                "     : User",
                                style: TextStyle(color: Colors.green),
                              )
                      ],
                    ),
                    subtitle: Text(userModel.email),
                    trailing: Icon(Icons.edit),
                  ),
                );
              },
            );
            
          }
          return Text("error1");
        },
      ),
    );
  }
}
