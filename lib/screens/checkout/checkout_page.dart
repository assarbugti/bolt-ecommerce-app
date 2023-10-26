import 'package:e_commerce_app/components/cart_item.dart';
import 'package:e_commerce_app/components/custom_button.dart';
import 'package:e_commerce_app/repos/model/cart_model.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:e_commerce_app/screens/confirmation/confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  final double discount;
  final double totalPrice;
  final double total;
  final String addressId;
  const CheckOutPage(
      {Key? key,
      required this.discount,
      required this.total,
      required this.addressId,
      required this.totalPrice})
      : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: CustomButton(
          buttonText: const Text("Buy"),
          onpressed: () async{
            productProvider.addToOrder(widget.totalPrice);
            setState(() {
                   productProvider.cartItemSaveList.clear();
            productProvider.cartBadge = 0; 
            });
      
          await  Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ConfirmationPage(),
              ),
            );
          },
        ),
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
                "Check Out",
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
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
                      isCheckOut: true,
                    );
                  }),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: const Text(
                        "Subtotal",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.grey),
                      ),
                      trailing: Text("\$ ${widget.totalPrice.toString()}"),
                    ),
                    const ListTile(
                      title: Text(
                        "Discount",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.grey),
                      ),
                      trailing: Text("% 5"),
                    ),
                    const ListTile(
                      title: Text(
                        "Shipping",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.grey),
                      ),
                      trailing: Text("\$ 100"),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text(
                        "Total",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      trailing: Text("\$ ${widget.total.toString()}"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
