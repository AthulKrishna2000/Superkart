import 'package:uuid/uuid.dart';

class GenerateIds {
  
  String generateProductId() {
    String formatedProductId;
    String uuid = const Uuid().v4();

    //customize id
    formatedProductId = "ecom-${uuid.substring(0, 5)}";

    //return
    return formatedProductId;
  }

  String generateCategoryId() {
    String formatedCategoryId;
    String uuid = const Uuid().v4();

    //customize id
    formatedCategoryId = "ecom-${uuid.substring(0, 5)}";

    //return
    return formatedCategoryId;
  }
}
