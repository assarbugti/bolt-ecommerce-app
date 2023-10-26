import 'package:e_commerce_app/components/cart_item.dart';
import 'package:e_commerce_app/components/custom_button.dart';
import 'package:e_commerce_app/repos/model/cart_model.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:e_commerce_app/screens/address/address_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: CustomButton(
            buttonText: const Text("Continue"),
            onpressed: () {
              if (productProvider.cartItemSaveList.isEmpty) {
                Fluttertoast.showToast(msg: "No Cart Item");
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddressPage()));
              }
            }),
      ),
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
          
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Cart",
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(height: 10),
            productProvider.cartItemSaveList.isEmpty
                ? const Center(
                    child: Text("no item"),
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: productProvider.cartItemSaveList.length,
                        itemBuilder: (context, index) {
                          CartModel cartModel =
                              productProvider.cartItemSaveList[index];
                          return CartItem(
                            cartModel: cartModel,
                            index: index,
                          isCheckOut: false,
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
