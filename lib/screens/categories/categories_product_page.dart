import 'package:e_commerce_app/components/single_product.dart';
import 'package:e_commerce_app/repos/provider/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductPage extends StatefulWidget {
  final String categoryName;

  const CategoryProductPage({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {

  @override
  Widget build(BuildContext context) {
    CategoriesProvider categoriesProvider  = Provider.of(context);
    categoriesProvider .getProductByCatagory(widget.categoryName);
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
      body: categoriesProvider.productByCategoryList .isEmpty
          ? const Center(
              child: Text("NO DATA"),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    widget.categoryName,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  itemCount: categoriesProvider.productByCategoryList.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.63),
                  itemBuilder: (BuildContext context, int index) {
                    return SingleProduct(productModel: categoriesProvider.productByCategoryList[index]);
                  },
                ),
              ],
            ),
    );
  }
}
