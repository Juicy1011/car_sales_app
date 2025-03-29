import 'package:get/get.dart';
import 'package:login/views/screens/MyLoginPage.dart';

import 'package:login/views/screens/RegistrationPage.dart';
import 'package:login/views/screens/homescreen.dart';
import 'package:login/views/screens/orders.dart';
import 'package:login/views/screens/products.dart';
import 'package:login/views/screens/profile.dart';
import 'package:login/views/screens/cart.dart';

List<GetPage> routes = [
  GetPage(name: "/", page: () => MyWidget()),
  GetPage(name: "/Registration", page: () => RegistrationPage()),
  GetPage(name: "/homescreen", page: () => homescreen()),
  GetPage(name: "/products", page: () => Products()),
  GetPage(name: "/orders", page: () => Orders()),
  GetPage(name: "/profile", page: () => Profile()),
  GetPage(name: "/cart", page: () => Cart()),
];
