
import 'package:e_commerce_app/components/custom_button.dart';
import 'package:flutter/material.dart';
import '../../config/routes.dart'as route;
class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: const [
              Text(
                "Welcome to Bolt",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Explore Us"),
            ],
          ),
          Image.asset("assets/Image.png"),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomButton(
                  buttonText:  const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                  
                  onpressed: () async{
                   await Navigator.pushNamed(context,route.loginPage);
                  },
                ),
              ),
              TextButton(
                onPressed: () async{
                 await Navigator.pushNamed(context,route.signupPage);
                },
                child: const Text(
                  "Signup",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ],
      ),
    );
  }
}
