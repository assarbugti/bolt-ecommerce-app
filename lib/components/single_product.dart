import 'package:e_commerce_app/screens/details/details_page.dart';
import 'package:e_commerce_app/repos/model/product_model.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final ProductModel productModel;

  const SingleProduct({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsPage(productModel: productModel)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                image: productModel.productImages[0],
                fit: BoxFit.cover,
                height: 200,
                width: 148,
                placeholder:  "assets/Image.png"
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "\$ ${productModel.productPrice}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20 / 4),
              child: Text(
                productModel.productName,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
