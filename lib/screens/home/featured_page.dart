import 'package:e_commerce_app/components/single_product.dart';
import 'package:flutter/material.dart';

import '../../repos/provider/product_provider.dart';

class FeaturedPage extends StatefulWidget {
  final String name;
    final  ProductProvider productProvider;

  const FeaturedPage({Key? key,required this.productProvider,required this.name}) : super(key: key);

  @override
  State<FeaturedPage> createState() => _FeaturedPageState();
}

class _FeaturedPageState extends State<FeaturedPage> {
  @override
  Widget build(BuildContext context) {
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
        children:  [
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Text(
             widget.name=="Featured"? "Featured":"Best Sell",
              style: const TextStyle(fontSize: 25),
            ),
          ),
          const SizedBox(height: 20,),
          GridView.builder(
            itemCount: widget.productProvider.featuredProductList.length,
            shrinkWrap: true,
            
             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2,
                childAspectRatio: 0.63
             ),
            itemBuilder: (BuildContext context, int index) {
             return SingleProduct(productModel: widget.productProvider.featuredProductList[index]);
            },
          ),
        ],
      ),
    );
  }
}
