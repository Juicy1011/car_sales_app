import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:voitureRoyale/configs/mycolors.dart';
import 'package:voitureRoyale/controllers/DisplayController.dart';
import 'package:voitureRoyale/views/widgets/mybutton.dart';
import 'package:voitureRoyale/views/widgets/textfield.dart';
import 'package:voitureRoyale/views/screens/RegistrationPage.dart';
import 'package:get/get.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DisplayController displayController = DisplayController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/background3.jpg"),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 20, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo1.png",
                height: 100,
              ),
              Text(
                'Login',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              myTextField(
                hintText: "Enter username",
                controller: userNameController,
                fillColor: Colors.white,
                textColor: Colors.white,
                hintTextColor: Colors.white,
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              myTextField(
                hintText: "Enter email",
                controller: emailController,
                fillColor: Colors.white,
                textColor: Colors.white,
                hintTextColor: Colors.white,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              myTextField(
                hintText: "Enter password",
                controller: passwordController,
                fillColor: Colors.white,
                textColor: Colors.white,
                hintTextColor: Colors.white,
                obscureText: !_isPasswordVisible,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              myButton(() {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Successfully logged in!'),
                    backgroundColor: SecondaryColor,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }, label: "Login", color: SecondaryColor),
              SizedBox(height: 30),
              myButton(() {
                Get.toNamed("/Registration");
              }, label: "SignUp", color: Colors.deepOrange),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: mainColor,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        print("password recovered");
                      }),
                ],
              ),
              Obx(() => Text(
                    displayController
                        .errorMessage.value, // Access the value property
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
