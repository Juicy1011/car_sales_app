import 'package:get/get.dart';

class CartController extends GetxController {
  final RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;

  void addToCart(Map<String, dynamic> car, String type, {int duration = 1}) {
    final double leaseRate = (car['lease_rate'] ?? 0.0).toDouble();
    final double price = (car['price'] ?? 0.0).toDouble();

    final item = {
      'id': car['id'],
      'name': car['name'],
      'image': car['image'],
      'type': type,
      'price': price,
      'lease_rate': leaseRate,
      'duration': duration,
      'total_price': type == 'lease' ? (leaseRate * duration) : price,
    };
    cartItems.add(item);
  }

  void removeFromCart(int id) {
    cartItems.removeWhere((item) => item['id'] == id);
  }

  void updateLeaseDuration(int itemId, int newDuration) {
    final index = cartItems.indexWhere((item) => item['id'] == itemId);
    if (index != -1) {
      final item = Map<String, dynamic>.from(cartItems[index]);
      item['duration'] = newDuration;
      // Update the total price for this lease item
      if (item['type'] == 'lease') {
        final double leaseRate = (item['lease_rate'] ?? 0.0).toDouble();
        item['total_price'] = leaseRate * newDuration;
      }
      cartItems[index] = item;
      cartItems.refresh();
    }
  }

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) {
      if (item['type'] == 'buy') {
        return sum + (item['price'] ?? 0.0).toDouble();
      } else {
        final double leaseRate = (item['lease_rate'] ?? 0.0).toDouble();
        final int duration = item['duration'] ?? 1;
        return sum + (leaseRate * duration);
      }
    });
  }

  void clearCart() {
    cartItems.clear();
  }
}
