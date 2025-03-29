import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:login/utils/routes.dart';
import 'package:login/controllers/cart_controller.dart';
import 'views/screens/MyLoginPage.dart';

void main() {
  // Initialize CartController
  Get.put(CartController());
  
  runApp(GetMaterialApp(
    home: MyWidget(),
    getPages: routes,
    initialRoute: "/homescreen",
    debugShowCheckedModeBanner: false,
  ));
}
