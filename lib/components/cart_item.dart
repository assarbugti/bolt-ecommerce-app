import 'package:e_commerce_app/repos/model/cart_model.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartItem extends StatefulWidget {
  final CartModel cartModel;
  bool? isCheckOut = false;
  final int index;
  CartItem(
      {Key? key, required this.cartModel, required this.index, this.isCheckOut})
      : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: SizedBox(
                  height: 128,
                  child: Image.network(widget.cartModel.cartImage),
                )),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(widget.cartModel.cartName),
                const SizedBox(
                  height: 10,
                ),
                Text("\$${widget.cartModel.cartPrice}"),
                const SizedBox(
                  height: 10,
                ),
                widget.isCheckOut == false
                    ? Container(
                        color: const Color(0xffF6F6F6),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.cartModel.cartQuantity--;
                                });
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(widget.cartModel.cartQuantity.toString()),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.cartModel.cartQuantity++;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      )
                    :const  Text("size : L"),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.isCheckOut == false
                      ? IconButton(
                          onPressed: () {
                            productProvider.deleteCart(widget.index);
                          },
                          icon: const Icon(Icons.close))
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
