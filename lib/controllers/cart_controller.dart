import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var totalPrice = 0.0.obs;

  void addToCart(Map<String, dynamic> car, String type, {int? duration}) {
    // Check if car already exists in cart
    var existingItem = cartItems.firstWhere(
      (item) => item['id'] == car['id'] && item['type'] == type,
      orElse: () => {},
    );

    if (existingItem.isEmpty) {
      // Add new item to cart
      cartItems.add({
        'id': car['id'],
        'name': car['name'],
        'type': type,
        'price': car[type == 'buy' ? 'price' : 'lease_rate'],
        'image': car['image'],
        if (type == 'lease' && duration != null) 'duration': duration,
      });
      calculateTotal();
    } else {
      // Update existing item
      if (type == 'lease' && duration != null) {
        existingItem['duration'] = duration;
        calculateTotal();
      }
    }
  }

  void removeFromCart(int id) {
    cartItems.removeWhere((item) => item['id'] == id);
    calculateTotal();
  }

  void updateLeaseDuration(int id, int duration) {
    var item = cartItems.firstWhere((item) => item['id'] == id);
    if (item.isNotEmpty) {
      item['duration'] = duration;
      calculateTotal();
    }
  }

  void calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      if (item['type'] == 'buy') {
        total += item['price'];
      } else {
        total += item['price'] * item['duration'];
      }
    }
    totalPrice.value = total;
  }

  void clearCart() {
    cartItems.clear();
    totalPrice.value = 0;
  }
} 