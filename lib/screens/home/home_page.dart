import 'package:e_commerce_app/screens/auth/first_page.dart';
import 'package:e_commerce_app/screens/cart/cart_page.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:e_commerce_app/screens/favorite/favorite_page.dart';
import 'package:e_commerce_app/screens/home/list_contents.dart';
import 'package:e_commerce_app/screens/order/my_order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductProvider? productProvider;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void logOut() {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.signOut().then(
            (value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const FirstPage(),
              ),
            ),
          );
    }
  }
@override
  void initState() {
  ProductProvider provider= Provider.of(context,listen: false);
     provider.getFeaturedProducts();
    provider.getBestSellProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
  

    return Scaffold(
      drawer: Drawer(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Home",
                    style: TextStyle(color: Colors.black38, fontSize: 18)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );
                },
                child: const Text("MyCart",
                    style: TextStyle(color: Colors.black38, fontSize: 18)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FavoritePage(),
                    ),
                  );
                },
                child: const Text("Favorite",
                    style: TextStyle(color: Colors.black38, fontSize: 18)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyOrder(),
                    ),
                  );
                },
                child: const Text("My Orders",
                    style: TextStyle(color: Colors.black38, fontSize: 18)),
              ),
              const Divider(),
              TextButton(
                onPressed: () async {
                  logOut();
                },
                child: const Text("Log out",
                    style: TextStyle(color: Colors.red, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Image.asset("assets/Menu Bar.png"),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black54,
                  ),
                  onPressed: () async {
                    setState(() {
                      productProvider!.cartBadge = 0;
                    });

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CartPage()));
                  }),
              // ignore: prefer_is_empty
              productProvider!.cartBadge != 0
                  ? Positioned(
                      right: 11,
                      top: 11,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          productProvider!.cartBadge.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ],
      ),
      key: _scaffoldKey,
      body: ListContents(
        productProvider: productProvider!,
      ),
    );
  }
}
