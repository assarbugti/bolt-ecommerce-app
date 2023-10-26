import 'package:e_commerce_app/components/single_product.dart';
import 'package:e_commerce_app/repos/model/favorite_model.dart';
import 'package:e_commerce_app/repos/model/product_model.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Favourite",
              style: TextStyle(fontSize: 25),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: productProvider.favoriteItemSaveList.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.63),
              itemBuilder: (BuildContext context, int index) {
                FavoriteModel favoriteModel =
                    productProvider.favoriteItemSaveList[index];
                ProductModel productModel = ProductModel(
                    productCategory: "",
                    productColors: [favoriteModel.favoriteColor],
                    productDescription: favoriteModel.productDescription,
                    productId: favoriteModel.favoriteId,
                    productImages: favoriteModel.favoriteImage,
                    productName: favoriteModel.favoriteName,
                    productPrice: favoriteModel.favoritePrice,
                    productRate: favoriteModel.favoriteRate,
                    productSizes: favoriteModel.favoriteSize);
                return SingleProduct(productModel: productModel);
              },
            ),
          ),
        ],
      ),
    );
  }
}
