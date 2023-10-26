import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:e_commerce_app/components/custom_button.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:e_commerce_app/screens/checkout/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final String addressId;
  const PaymentPage({Key? key,required this.addressId}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  ProductProvider? productProvider;
  double discount = 5;
  double? totalPrice;
  double? total;
  totalDiscount() {
    totalPrice = productProvider!.totalPrice();
    double discountValue = (totalPrice! * discount) / 100;
    total = totalPrice! - discountValue;
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);

    totalDiscount();
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: double.infinity,
              height: 49,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                                        primary: Colors.transparent,

                    side: const BorderSide(color: Colors.blue)),
                child: const Text(
                  "Add Card",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              buttonText: const Text("Checkout"),
              onpressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  CheckOutPage(
                      discount: discount,
                      total: total!,
                      totalPrice: totalPrice!,
                      addressId:widget.addressId,
                    ),
                  ),
                );
              },
            ),
          ],
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  "Payment",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CreditCard(
                cardNumber: "5450 7879 4864 7854",
                cardExpiry: "10/25",
                cardHolderName: "Card Holder",
                cvv: "456",
                bankName: "Axis Bank",
                cardType: CardType
                    .maestro, // Optional if you want to override Card Type
                showBackSide: false,
                frontBackground: CardBackgrounds.custom(0xff004ba0),
                backBackground: CardBackgrounds.white,
                // showShadow: true,
                textExpDate: 'Exp. Date',
                textName: 'Name',
                textExpiry: 'MM/YY',
              ),
              Padding(
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
                      trailing: Text("\$${totalPrice.toString()}"),
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
                      trailing: Text("\$$total"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
