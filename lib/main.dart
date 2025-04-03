import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:voitureRoyale/utils/routes.dart';
import 'package:voitureRoyale/controllers/cart_controller.dart';
import 'views/screens/MyLoginPage.dart';

void main() {
  Get.put(CartController());

  runApp(GetMaterialApp(
    title: 'Voiture Royale',
    home: MyWidget(),
    getPages: routes,
    initialRoute: "/",
    debugShowCheckedModeBanner: false,
  ));
}
