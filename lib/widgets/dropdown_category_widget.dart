import 'package:ecom/controllers/category_drop_down_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownCategoryWidget extends StatelessWidget {
  const DropdownCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDropDownController>(
        builder: (CategoryDropDownController) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: CategoryDropDownController.selectedCategoryId?.value,
                  items: CategoryDropDownController.categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category['categoryId'].toString(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                category['categoryImg'].toString()),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(category['categoryName'])
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? selectedvalue) {
                    CategoryDropDownController.setSelectedCategoty(
                        selectedvalue);
                  },
                  hint: Text('select a category'),
                  isExpanded: true,
                  elevation: 10,
                  underline: SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
