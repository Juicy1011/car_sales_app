import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voitureRoyale/configs/mycolors.dart';
import 'package:voitureRoyale/controllers/Homescreencontroller.dart';
import 'package:voitureRoyale/views/screens/dashboard.dart';
import 'package:voitureRoyale/views/screens/orders.dart';
import 'package:voitureRoyale/views/screens/products.dart';
import 'package:voitureRoyale/views/screens/profile.dart';

Homescreencontroller homescreencontroller = Homescreencontroller();
List<Widget> myScreens = [Dashboard(), Products(), Orders(), Profile()];

class homescreen extends StatelessWidget {
  const homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      // title: Text("Home"),
      //backgroundColor: mainColor,
      //  ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.directions_car), label: "Cars"),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Orders"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
            backgroundColor: SecondaryColor,
            selectedItemColor: mainColor,
            unselectedItemColor: SecondaryColor,
            showUnselectedLabels: true,
            currentIndex: homescreencontroller.selectectedScreenIndex.value,
            onTap: (p) => homescreencontroller.updatedSelectedIndex(p),
          )),
      body: Obx(
          () => myScreens[homescreencontroller.selectectedScreenIndex.value]),
    );
  }
}
