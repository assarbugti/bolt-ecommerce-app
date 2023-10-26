// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/repos/model/address_model.dart';
import 'package:e_commerce_app/repos/model/favorite_model.dart';
import 'package:e_commerce_app/repos/model/order_model.dart';
import 'package:e_commerce_app/repos/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/cart_model.dart';

class ProductProvider with ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController addressLane = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  int cartBadge = 0;

  List<CartModel> cartItemSaveList = [];

  List<FavoriteModel> favoriteItemSaveList = [];

  List<AddressModel> addressList = [];
  List<OrderModel> orderList = [];
  List<ProductModel> featuredProductList = [];
  List<ProductModel> bestSellProductList = [];

  final FirebaseFirestore db = FirebaseFirestore.instance;

  addToCart(CartModel cartModel) async {
    cartItemSaveList
        .removeWhere((element) => element.cartId == cartModel.cartId);
    cartItemSaveList.insert(0, cartModel);
  }

  Future deleteCart(int index) async {
    cartItemSaveList.removeAt(index);
    // cartBadge--;

    notifyListeners();
  }

  double totalPrice() {
    double total = 0.0;
    for (var element in cartItemSaveList) {
      total += element.cartPrice * element.cartQuantity;
    }
    return total;
  }

  Future addToFavorite(FavoriteModel favoriteModel) async {
    favoriteItemSaveList.removeWhere(
        (element) => element.favoriteId == favoriteModel.favoriteId);
    favoriteItemSaveList.insert(0, favoriteModel);
    return favoriteItemSaveList;
  }

  Future deleteFavorite(int index)async{
    favoriteItemSaveList.removeAt(index);
    notifyListeners();
  }

  // Future deleteFavorite(int index) async {
  //   favoriteItemSaveList.removeAt(index);
  //   notifyListeners();
  // }

  List<ProductModel> search(String query) {
    List<ProductModel> productSeach = featuredProductList.where((element) {
      return element.productName.contains(query);
    }).toList();
    return productSeach;
  }

  void addressValidator(context) async {
    if (addressLane.text.isEmpty) {
      Fluttertoast.showToast(msg: "address lane is empty");
    } else if (name.text.isEmpty) {
      Fluttertoast.showToast(msg: "name is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "city is empty");
    } else if (postalCode.text.isEmpty) {
      Fluttertoast.showToast(msg: "password is empty");
    } else if (phoneNumber.text.isEmpty) {
      Fluttertoast.showToast(msg: "password is empty");
    } else {
      AddressModel addressModel = AddressModel(
          addressCity: city.text,
          addressLane: addressLane.text,
          addressName: name.text,
          addressPhoneNumber: phoneNumber.text,
          addressId: "",
          addressPostalCode: postalCode.text);
      addressList.add(addressModel);
      notifyListeners();
      Fluttertoast.showToast(msg: "add your address please go back");
    }
  }

  addToOrder(totalPrice) {
    for (var element in cartItemSaveList) {
      OrderModel orderModel = OrderModel(
        orderColor: element.cartColor,
        orderImage: element.cartImage,
        addressId: "",
        userId: "id",
        orderName: element.cartName,
        orderPrice: totalPrice,
        orderSize: element.cartSize,
        orderId: element.cartId,
        orderQuantity: element.cartQuantity,
      );
      orderList.insert(0, orderModel);
    }
  }

  Future getFeaturedProducts() async {
    ProductModel productModel;
    List<ProductModel> newList = [];
    QuerySnapshot data = await db.collection("Products").get();
    for (var element in data.docs) {
      if (element.exists) {
        productModel = ProductModel.fromJson(element.data());
        newList.add(productModel);
        notifyListeners();
      }
    }
    featuredProductList = newList;
    notifyListeners();
    return featuredProductList;
  }

  Future getBestSellProducts() async {
    ProductModel productModel;
    List<ProductModel> newList = [];
    QuerySnapshot data = await db
        .collection("Products")
        .where("productLikes", isGreaterThan: 10)
        .orderBy("productLikes", descending: true)
        .get();
    for (var element in data.docs) {
      if (element.exists) {
        productModel = ProductModel.fromJson(element.data());
        newList.add(productModel);
        notifyListeners();
      }
    }
    bestSellProductList = newList;
    notifyListeners();
    return bestSellProductList;
  }

////// Get Categories Data In Firebase ///////////

}
