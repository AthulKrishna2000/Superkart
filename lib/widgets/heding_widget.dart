import 'package:ecom/utils/app_constant.dart';
import 'package:flutter/material.dart';

class HedingWidget extends StatelessWidget {
  final String headingTitle;
  final String headingSubTitle;
  final VoidCallback onTap;
  final String buttonText;
  const HedingWidget({super.key, required this.headingTitle, required this.headingSubTitle, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headingTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                ),
                Text(
                  headingSubTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: Colors.grey.shade800),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: AppConstant.appSecendoryColor,
                    width: 1.5,
                  ),
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: AppConstant.appSecendoryColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
