import 'package:e_commerce_app/components/custom_button.dart';

import 'package:e_commerce_app/screens/home/home_page.dart';
import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: CustomButton(
            buttonText: const Text("Back to Home"),
            onpressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Image.asset('assets/like.png'),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Confirmation",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "You have successfully completed your payment procedure",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
