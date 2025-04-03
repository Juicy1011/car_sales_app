import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voitureRoyale/configs/mycolors.dart';
import 'package:voitureRoyale/views/widgets/mybutton.dart';
import 'package:voitureRoyale/views/widgets/textfield.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background4.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
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
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
                    // Password Field with Eye Toggle
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
                    SizedBox(height: 20),
                    // Confirm Password Field with Eye Toggle
                    myTextField(
                      hintText: "Confirm password",
                      controller: confirmPasswordController,
                      fillColor: Colors.white,
                      textColor: Colors.white,
                      hintTextColor: Colors.white,
                      obscureText: !_isConfirmPasswordVisible,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    myButton(() {
                      // Input Validation
                      if (userNameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty) {
                        // Show error message if any field is empty
                        Get.snackbar(
                          "Error",
                          "All fields are required!",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else if (!emailController.text.contains('@')) {
                        // Show error message if email is invalid
                        Get.snackbar(
                          "Error",
                          "Please enter a valid email address!",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        // Show error message if passwords don't match
                        Get.snackbar(
                          "Error",
                          "Passwords do not match!",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        // Proceed with signup logic
                        print("Creating new account");
                        Get.snackbar(
                          "Success",
                          "Account created successfully!",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        // Navigate to login page or home page
                      }
                    }, label: "Create Account", color: SecondaryColor),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ",
                            style: TextStyle(color: Colors.white)),
                        GestureDetector(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: mainColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () {
                            Get.toNamed("/");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
