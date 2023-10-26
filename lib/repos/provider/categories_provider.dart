import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/repos/model/categories_model.dart';
import 'package:e_commerce_app/repos/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class CategoriesProvider with ChangeNotifier {
  final FirebaseFirestore dB = FirebaseFirestore.instance;
  List<CategoriesModel> categorysList = [];
  List<ProductModel> productByCategoryList = [];

  Future getCategoriesData() async {
    List<CategoriesModel> newList = [];
    CategoriesModel categoriesModel;

    QuerySnapshot data = await dB.collection("Categories").get();
    for (QueryDocumentSnapshot element in data.docs) {
      if (element.exists) {
        categoriesModel = CategoriesModel.fromJson(element.data());
        newList.add(categoriesModel);
        notifyListeners();
      }
    }
    categorysList = newList;
    notifyListeners();
    return categorysList;
  }

  Future getProductByCatagory(String categoryName) async {
    ProductModel productModel;
    List<ProductModel> newList = [];
    QuerySnapshot data = await dB.collection("Products").get();
    for (var element in data.docs) {
      if (element.exists) {
        if (categoryName == element.get("productCategory")) {
          productModel = ProductModel.fromJson(element.data());
          newList.add(productModel);
          notifyListeners();
        }
      }
    }
    productByCategoryList = newList;
    notifyListeners();
    return productByCategoryList;
  }
}
