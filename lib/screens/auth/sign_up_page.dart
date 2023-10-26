import 'package:e_commerce_app/components/custom_text_field.dart';
import 'package:e_commerce_app/repos/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Signup",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                  controller: authProvider.signupUserName, title: "Name"),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: authProvider.signupUserEmail, title: "Email"),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: _obscureText,
                controller: authProvider.signupUserPassword,
                decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                buttonText: authProvider.isSignupLoadding == false
                    ? const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
                onpressed: () async {
                  await authProvider.signUpValidator(context);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an acoount ?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
