import 'package:get/get.dart';
import 'package:voitureRoyale/views/screens/MyLoginPage.dart';

import 'package:voitureRoyale/views/screens/RegistrationPage.dart';
import 'package:voitureRoyale/views/screens/homescreen.dart';
import 'package:voitureRoyale/views/screens/orders.dart';
import 'package:voitureRoyale/views/screens/products.dart';
import 'package:voitureRoyale/views/screens/profile.dart';
import 'package:voitureRoyale/views/screens/cart.dart';
import 'package:voitureRoyale/views/screens/splash_screen.dart';

List<GetPage> routes = [
  GetPage(name: "/splash", page: () => SplashScreen()),
  GetPage(name: "/", page: () => MyWidget()),
  GetPage(name: "/Registration", page: () => RegistrationPage()),
  GetPage(name: "/homescreen", page: () => homescreen()),
  GetPage(name: "/products", page: () => Products()),
  GetPage(name: "/orders", page: () => Orders()),
  GetPage(name: "/profile", page: () => Profile()),
  GetPage(name: "/cart", page: () => Cart()),
];
