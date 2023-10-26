import 'package:e_commerce_app/components/custom_button.dart';
import 'package:e_commerce_app/repos/model/address_model.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../payment/payment_page.dart';
import 'create_address_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // ignore: prefer_typing_uninitialized_variables
  int value = 0;
  String? addressId;
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    
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
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CreateAddressPage()));
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.blue)),
                child: const Text(
                  "Add AddressPage",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            productProvider.addressList.isEmpty
                ? Container()
                : CustomButton(
                    buttonText: const Text("Continue To Payment"),
                    onpressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PaymentPage(addressId: addressId!)));
                    }),
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
        actions: const [
          
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              "AddressPage",
              style: TextStyle(fontSize: 25),
            ),
          ),
          productProvider.addressList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    AddressModel addressPage =
                        productProvider.addressList[index];
                    addressId = productProvider.addressList[index].addressId;

                    return RadioListTile<int>(
                      value: index,
                      groupValue: value,
                      onChanged: (ind) {
                        setState(() {
                          addressId =
                              productProvider.addressList[index].addressId;
                          value = ind!;
                        });
                      },
                      title: Text(
                          "${addressPage.addressLane}\nCity: ${addressPage.addressCity}"),
                    );
                  },
                  itemCount: productProvider.addressList.length,
                )
              : const Center(child: Text("No Address"))
        ],
      ),
    );
  }
}
