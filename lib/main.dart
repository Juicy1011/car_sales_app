import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voitureRoyale/controllers/orders_controller.dart';
import 'package:voitureRoyale/utils/routes.dart';
import 'package:voitureRoyale/controllers/cart_controller.dart';
import 'views/screens/MyLoginPage.dart';
import 'views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  Get.put(CartController());
  Get.put(OrdersController()); // Add the OrdersController

  runApp(GetMaterialApp(
    title: 'Voiture Royale',
    //home: SplashScreen(),
    getPages: routes,
    initialRoute: "/splash",
    debugShowCheckedModeBanner: false,
  ));
}
