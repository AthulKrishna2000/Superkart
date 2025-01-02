import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/order_model.dart';
import 'package:ecom/models/review_model.dart';
import 'package:ecom/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddReviewsScreen extends StatefulWidget {
  final OrderModel orderModel;
  const AddReviewsScreen({super.key, required this.orderModel});

  @override
  State<AddReviewsScreen> createState() => _AddReviewsScreenState();
}

class _AddReviewsScreenState extends State<AddReviewsScreen> {
  TextEditingController feedbackcontroller = TextEditingController();
  double productRating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Add rewiews"),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Add your rating and review'),
            SizedBox(
              height: 20.0,
            ),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                productRating = rating;
                print(productRating);
                setState(() {});
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text("Feedback"),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: feedbackcontroller,
              decoration: InputDecoration(
                label: Text("share your Feedback"),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                EasyLoading.show(status: "please wait..");
                User? user = FirebaseAuth.instance.currentUser;
                String feedback = feedbackcontroller.text.trim();
                // print(productRating);
                // print(feedback);
                ReviewModel reviewModel = ReviewModel(
                    customerName: widget.orderModel.customerName,
                    customerPhone: widget.orderModel.customerPhone,
                    customerDeviceToken: widget.orderModel.customerDeviceToken,
                    customerId: widget.orderModel.customerId,
                    feedback: feedback,
                    rating: productRating.toString(),
                    createdAt: DateTime.now());

                await FirebaseFirestore.instance
                    .collection('products')
                    .doc(widget.orderModel.productId)
                    .collection('review')
                    .doc(user!.uid)
                    .set(reviewModel.toMap());
                EasyLoading.dismiss();
              },
              child: Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
