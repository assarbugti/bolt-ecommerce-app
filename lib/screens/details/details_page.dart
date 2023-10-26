import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/config/colors.dart';
import 'package:e_commerce_app/repos/model/cart_model.dart';
import 'package:e_commerce_app/repos/model/favorite_model.dart';
import 'package:e_commerce_app/repos/model/product_model.dart';
import 'package:e_commerce_app/screens/cart/cart_page.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:e_commerce_app/screens/favorite/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailsPage extends StatefulWidget {
  final ProductModel productModel;

  const DetailsPage({Key? key, required this.productModel}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int currentIndex = 0;
  bool descTextShowFlag = false;
  int isSelectColor = 0;
  int isSelectSize = 0;
  bool isColor = false;
  bool isSize = true;
  String? productSize = "S";
  int? productColor = 0;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      CartModel cartModel = CartModel(
                        cartColor: productColor!,
                        cartImage: widget.productModel.productImages[0],
                        cartName: widget.productModel.productName,
                        cartPrice: widget.productModel.productPrice,
                        cartSize: productSize!,
                        cartQuantity: 1,
                        cartId: widget.productModel.productId,
                      );
                      productProvider.addToCart(cartModel);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CartPage()));
                    },
                    style: ElevatedButton.styleFrom(),
                    child: const Text(
                      "ADD TO CART",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      FavoriteModel favoriteModel = FavoriteModel(
                        favoriteColor: productColor!,
                        favoriteImage: widget.productModel.productImages,
                        favoriteName: widget.productModel.productName,
                        favoritePrice: widget.productModel.productPrice,
                        favoriteSize: widget.productModel.productSizes,
                        favoriteQuantity: 1,
                        favoriteId: widget.productModel.productId,
                        favoriteRate: widget.productModel.productRate,
                        productDescription:
                            widget.productModel.productDescription,
                      );
                      productProvider.addToFavorite(favoriteModel);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const FavoritePage()));
                    },
                    child: const Text("Add to Favorite"),
                  ),
                ),
              )
            ],
          ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: true,
                          reverse: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          }
                          // autoPlay: false,
                          ),
                      items: widget.productModel.productImages
                          .map((item) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Image.network(
                                  item,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ))
                          .toList(),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -30),
                      child: AnimatedSmoothIndicator(
                        activeIndex: currentIndex,
                        count: widget.productModel.productImages.length,
                        effect: const WormEffect(
                          spacing: 8.0,
                          dotWidth: 10,
                          dotHeight: 10,
                          paintStyle: PaintingStyle.stroke,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.productModel.productName,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
              const Divider(),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kPrimeryColor),
                    child: Center(
                      child: Text(
                        widget.productModel.productRate.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Product Likes")
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.productModel.productDescription,
                maxLines: descTextShowFlag ? 8 : 8,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.grey),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    descTextShowFlag = !descTextShowFlag;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    descTextShowFlag
                        ? Text(
                            "Less",
                            style: TextStyle(color: kPrimeryColor),
                          )
                        : Text("More", style: TextStyle(color: kPrimeryColor))
                  ],
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isSize = true;
                          isColor = false;
                        });
                      },
                      child: Text(
                        "Select Size",
                        style: TextStyle(
                            color: isSize ? Colors.black : Colors.grey,
                            fontSize: 18),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isSize = false;
                        isColor = true;
                      });
                    },
                    child: Text(
                      "Select Color",
                      style: TextStyle(
                          color: isColor ? Colors.black : Colors.grey,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              const Divider(),
              isColor == false
                  ? SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.productModel.productSizes.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  isSelectSize = index;
                                  productSize =
                                      widget.productModel.productSizes[index];
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: isSelectSize == index
                                      ? kPrimeryColor
                                      : kSecondColor,
                                ),
                                child: Center(
                                  child: Text(
                                    widget.productModel.productSizes[index],
                                    style: TextStyle(
                                        color: isSelectSize == index
                                            ? Colors.white
                                            : Colors.black54),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.productModel.productColors.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  isSelectColor = index;
                                  productColor =
                                      widget.productModel.productColors[index];
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: isSelectColor == index
                                      ? Border.all(
                                          color: kPrimeryColor, width: 4)
                                      : Border.all(color: Colors.transparent),
                                  color: Color(
                                      widget.productModel.productColors[index]),
                                ),
                              ),
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
