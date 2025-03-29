import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:login/utils/routes.dart';
import 'views/screens/MyLoginPage.dart';

void main() {
  runApp(GetMaterialApp(
    home: MyWidget(),
    getPages: routes,
    initialRoute: "/homescreen",
    debugShowCheckedModeBanner: false,
  ));
}
