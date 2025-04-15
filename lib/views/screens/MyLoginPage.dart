import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voitureRoyale/configs/mycolors.dart';
import 'package:voitureRoyale/controllers/DisplayController.dart';
import 'package:voitureRoyale/views/widgets/mybutton.dart';
import 'package:voitureRoyale/views/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Shared storage for username (using GetStorage for persistent storage)
var store = GetStorage();

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // Controllers to capture input from the text fields
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DisplayController displayController =
      DisplayController(); // Display controller for error messages
  bool _isPasswordVisible = false; // Flag to toggle password visibility

  @override
  Widget build(BuildContext context) {
    String username = store.read("username") ?? "";
    userNameController.text = username;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background82.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  // Logo
                  Image.asset(
                    "assets/images/logo3.png",
                    height: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Username Field
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
                  // Email Field
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
                  // Password Field
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        myButton(() async {
                          //trim potential white space and BOM characters
                          String username = userNameController.text.trim();
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();

                          // Basic validation to ensure all fields are filled
                          if (username.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill all fields.'),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            return;
                          }

                          try {
                            print(
                                "http://localhost/car_sales/login.php?username=$username&password=$password&email=$email");
                            // Set the URL for your login endpoint (change localhost to actual server when deployed)
                            var url = Uri.parse(
                                "http://localhost/car_sales/login.php?username=$username&password=$password&email=$email");

                            // Send the HTTP request to the server
                            var response = await http
                                .get(url, headers: <String, String>{
                              "Content-type": "application/json; charset=UTF-8"
                            });
                            print("Server response: ${response.body}");

                            if (response.statusCode == 200) {
                              // Trim the response to avoid any unexpected whitespace or characters
                              var data = response.body.trim();

                              // Parse the response JSON with error handling
                              var jsonResponse;
                              try {
                                jsonResponse = jsonDecode(data);
                              } catch (e) {
                                displayController.errorMessage.value =
                                    "Error parsing JSON response: ${e.toString()}";
                                return;
                              }

                              if (jsonResponse['success'] == 1) {
                                // If login is successful, save the username and navigate to the home screen
                                await store.write("user_id",
                                    jsonResponse['user_id']); // Store user_id
                                store.write("username", username);
                                Get.toNamed("/homescreen");

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Successfully logged in!'),
                                    backgroundColor: SecondaryColor,
                                    duration: Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                // If login fails (user not found), show error message
                                displayController.errorMessage.value =
                                    "Login failed. Please check your credentials.";
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Invalid credentials. Please try again.'),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            } else {
                              // Handle any unexpected errors (non-200 status code)
                              displayController.errorMessage.value =
                                  "Error: ${response.statusCode}";
                            }
                          } catch (e) {
                            // Handle error in case of network or server issues
                            displayController.errorMessage.value =
                                "Error: ${e.toString()}";
                          }
                        },
                            label: "Login",
                            color: const Color.fromARGB(255, 35, 4, 49)),
                        SizedBox(height: 20),
                        myButton(() {
                          Get.toNamed("/Registration");
                        },
                            label: "SignUp",
                            color: const Color.fromARGB(255, 63, 18, 5)),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: mainColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        print("password recovery flow initiated");
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // Display error message from the controller
                  Obx(() => Text(
                        displayController.errorMessage.value,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers when widget is disposed to prevent memory leaks
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
