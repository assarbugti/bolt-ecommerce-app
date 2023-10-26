import 'package:e_commerce_app/components/custom_button.dart';
import 'package:e_commerce_app/components/custom_text_field.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAddressPage extends StatefulWidget {
  const CreateAddressPage({Key? key}) : super(key: key);

  @override
  State<CreateAddressPage> createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: CustomButton(
            buttonText: const Text("Add Addres"),
            onpressed: () {
              productProvider.addressValidator(context);
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "CreateAddressPage",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView(
              shrinkWrap: true,
               physics: const BouncingScrollPhysics(
                  
                  ),
              children: [
                CustomTextField(
                    controller: productProvider.name, title: "Name"),
                CustomTextField(
                    controller: productProvider.addressLane,
                    title: "Address Lane"),
                CustomTextField(
                    controller: productProvider.city, title: "City"),
                CustomTextField(
                    controller: productProvider.postalCode,
                    title: "Postal Code"),
                CustomTextField(
                    controller: productProvider.phoneNumber,
                    title: "Phone Numbers"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
