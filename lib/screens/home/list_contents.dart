import 'package:e_commerce_app/components/single_product.dart';
import 'package:e_commerce_app/repos/model/product_model.dart';
import 'package:e_commerce_app/repos/provider/categories_provider.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:e_commerce_app/screens/home/featured_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/single_category.dart';
import '../categories/categories_view_all.dart';

class ListContents extends StatefulWidget {
  final ProductProvider productProvider;
  const ListContents({
    Key? key,
    required this.productProvider,
  }) : super(key: key);

  @override
  State<ListContents> createState() => _ListContentsState();
}

class _ListContentsState extends State<ListContents> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<ProductModel> productSeachList =
        widget.productProvider.search(searchQuery);

    CategoriesProvider categoriesProvider = Provider.of(context);
    categoriesProvider.getCategoriesData();
    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 230, 220, 220),
                  blurRadius: 30,
                  offset: Offset(
                    0,
                    10,
                  )),
            ]),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  hintText: "Search Your Product",
                  prefixIcon: Image.asset("assets/search.png"),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1))),
            ),
          ),
          if (searchQuery != "" && searchQuery.isNotEmpty) ...{
            productSeachList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: const Center(
                      child: Text(
                        "No Data",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : GridView.builder(
                    itemCount: productSeachList.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.63),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SingleProduct(productModel: productSeachList[index]),
                        ],
                      );
                    },
                  )
          } else ...{
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const CategoriesViewAll()));
                          },
                          child: const Text(
                            "View all",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: categoriesProvider.categorysList
                        .map<Widget>((e) => SingleCategory(categoriesModel: e))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Featured",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FeaturedPage(
                                      productProvider: widget.productProvider,
                                      name: "Featured",
                                    )));
                          },
                          child: const Text(
                            "View all",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.productProvider.featuredProductList
                            .map<Widget>((productModel) =>
                                SingleProduct(productModel: productModel))
                            .toList()),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Best Sell",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FeaturedPage(
                                      productProvider: widget.productProvider,
                                      name: "best",
                                    )));
                          },
                          child: const Text(
                            "View all",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: widget.productProvider.bestSellProductList
                            .map<Widget>((productModel) =>
                                SingleProduct(productModel: productModel))
                            .toList()),
                  ),
                ),
              ],
            ),
          }
        ],
      ),
    );
  }
}
