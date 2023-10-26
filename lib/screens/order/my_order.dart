import 'package:e_commerce_app/components/cart_item.dart';
import 'package:e_commerce_app/repos/model/cart_model.dart';
import 'package:e_commerce_app/repos/model/order_model.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black54,
            )),
        actions: [
          Image.asset("assets/search.png"),
          
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              "Order",
              style: TextStyle(fontSize: 25),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: productProvider.orderList.length,
            itemBuilder: (context, index) {
              OrderModel orderModel = productProvider.orderList[index];
           CartModel cartModel =   CartModel(
                cartColor: orderModel.orderColor,
                cartImage: orderModel.orderImage,
                cartName: orderModel.orderName,
                cartPrice: orderModel.orderPrice.toInt(),
                cartSize: orderModel.orderSize,
                cartId: orderModel.orderId,
                cartQuantity: orderModel.orderQuantity,
              );
              return CartItem(
                cartModel: cartModel,
                index: index,
                isCheckOut: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
