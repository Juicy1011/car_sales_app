import 'package:get/get.dart';

class OrdersController extends GetxController {
  // This will hold the orders data
  final RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;

  void addOrder(Map<String, dynamic> order) {
    orders.add(order);
  }
}
