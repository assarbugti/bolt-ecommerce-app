import 'package:e_commerce_app/screens/auth/first_page.dart';
import 'package:e_commerce_app/screens/auth/login_page.dart';
import 'package:e_commerce_app/screens/auth/sign_up_page.dart';
import 'package:e_commerce_app/screens/home/home_page.dart';
import 'package:flutter/material.dart';

// variable for our route names
const String firstPage = 'firstPage';
const String loginPage = 'login';
const String homePage = 'home';
const String signupPage = 'signup';

// controller function with switch statement to control page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case firstPage:
      return MaterialPageRoute(builder: (context) => const FirstPage());

    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());

    case signupPage:
      return MaterialPageRoute(builder: (context) => const SignupPage());
    default:
      throw ('this route name does not exist');
  }
}
