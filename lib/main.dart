// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:e_commerce_app/repos/provider/auth_provider.dart';
import 'package:e_commerce_app/repos/provider/categories_provider.dart';
import 'package:e_commerce_app/repos/provider/product_provider.dart';
import 'package:e_commerce_app/screens/auth/first_page.dart';
import 'package:e_commerce_app/screens/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/routes.dart' as route;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBYHyE4qkIJC0l8lS1MsL2T7-Cthvvn3Kc",
          appId: "1:770514120587:ios:b0b9476f0dcb997a4ec98e",
          messagingSenderId: "770514120587",
          projectId: "ecommerce-app-6cf43"),
    );
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoriesProvider(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: route.controller,
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const FirstPage();
            } else {
              return const HomePage();
            }
          },
        ),
      ),
    );
  }
}
