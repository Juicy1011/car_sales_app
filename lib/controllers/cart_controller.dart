// controllers/cart_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:voitureRoyale/configs/config.dart';

import 'orders_controller.dart'; // Import the OrdersController

class CartController extends GetxController {
  final RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;

  // Removed orderDetails - OrdersController handles orders now

  // ... (addToCart, removeFromCart, updateLeaseDuration, totalPrice remain the same) ...

  void addToCart(Map<String, dynamic> car, String type, {int duration = 1}) {
    final double leaseRate = (car['lease_rate'] ?? 0.0).toDouble();
    final double price = (car['price'] ?? 0.0).toDouble();

    final item = {
      'id': car['id'], // This is the car_id
      'name': car['name'],
      'image': car['image'],
      'type': type, // 'buy' or 'lease' -> maps to 'category' in DB
      'price': price, // Original car price (useful for 'buy')
      'lease_rate': leaseRate, // Lease rate per period
      'duration': duration, // Lease duration
      'total_price':
          type == 'lease' ? (leaseRate * duration) : price, // Calculated total
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
      if (item['type'] == 'lease') {
        final double leaseRate = (item['lease_rate'] ?? 0.0).toDouble();
        item['total_price'] = leaseRate * newDuration;
      }
      cartItems[index] = item;
      cartItems
          .refresh(); // Use refresh() for RxList updates if needed elsewhere
    }
  }

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) {
      // Use total_price directly as calculated in addToCart/updateLeaseDuration
      return sum + (item['total_price'] ?? 0.0).toDouble();
    });
  }

  void clearCart() {
    cartItems.clear();
  }

  Future<void> checkout() async {
    final OrdersController ordersController = Get.find<OrdersController>();
    const String userId = "7"; // Make sure this is the correct user ID

    if (cartItems.isEmpty) {
      Get.snackbar('Info', 'Your cart is empty.');
      return;
    }

    bool allSucceeded = true;
    List<Map<String, dynamic>> itemsToKeep = List.from(cartItems);

    for (var item in cartItems) {
      try {
        final url = Uri.parse(
            'http://localhost/car_sales/create_order.php'); // Use localhost only if running emulator configured for it, otherwise use your PC's IP

        // --- Prepare the body data as a Map<String, String> ---
        Map<String, String> bodyData = {
          'user_id': userId,
          'car_id': item['id'].toString(),
          'category': item['type'],
          'total_price': item['total_price'].toString(),
        };
        // Conditionally add lease_duration
        if (item['type'] == 'lease') {
          bodyData['lease_duration'] = item['duration'].toString();
        }
        // You could add 'status': 'pending' here if needed, but PHP defaults it

        print("--- Sending POST Request ---");
        print("URL: $url");
        print("Body (Form Data): $bodyData");

        // *** Make the POST request WITHOUT jsonEncode and WITHOUT JSON headers ***
        // The http package will automatically set the Content-Type to
        // 'application/x-www-form-urlencoded' when body is a Map<String, String>
        final response = await http.post(
          url,
          // NO headers specifying application/json needed here
          // NO jsonEncode needed here
          body: bodyData, // Send the map directly
        );

        print("--- Received Response ---");
        print("Status Code: ${response.statusCode}");
        // Wrap body in markers to see if it's empty or malformed
        print("Raw Body: >>>${response.body}<<<");

        // --- Check the Response ---
        // Your PHP script sends 201 on success, check for that OR 200 if you changed it
        if (response.statusCode == 201 || response.statusCode == 200) {
          // Adjusted check
          // Check for empty body before decoding
          if (response.body.trim().isEmpty) {
            print(
                "Error: Received empty response body despite success status code.");
            Get.snackbar('Error',
                'Server returned an empty success response for ${item['name']}.');
            allSucceeded = false;
            break;
          }
          try {
            final Map<String, dynamic> data = json.decode(response.body);
            // Check specifically for the keys PHP sends on success/error
            if (data.containsKey('error')) {
              allSucceeded = false;
              print(
                  'PHP Error for ${item['name']}: ${data['error']} - Details: ${data['details']}');
              Get.snackbar('Error',
                  'Could not create order for ${item['name']}: ${data['error']}');
              break;
            } else if (data.containsKey('success') && data['success'] == true) {
              // Successfully created this item's order
              itemsToKeep.remove(item);
              print(
                  'PHP Success: Order created for ${item['name']} (ID: ${data['order_id']})');
            } else {
              // Unexpected JSON format from PHP
              allSucceeded = false;
              print('Unexpected JSON format from PHP: ${response.body}');
              Get.snackbar(
                  'Error', 'Received unexpected response for ${item['name']}.');
              break;
            }
          } catch (jsonError) {
            print(
                "JSON Decode Error: $jsonError. Body was: >>>${response.body}<<<");
            Get.snackbar('Error',
                'Failed to parse server response for ${item['name']}.');
            allSucceeded = false;
            break;
          }
        } else {
          // Handle HTTP errors (4xx, 5xx)
          allSucceeded = false;
          print(
              'HTTP Error creating order for ${item['name']}: ${response.statusCode}');
          // Try to decode error if PHP sent one, otherwise show generic message
          String errorMsg =
              'Server error placing order for ${item['name']} (${response.statusCode}).';
          try {
            final Map<String, dynamic> data = json.decode(response.body);
            if (data.containsKey('error')) {
              errorMsg =
                  'Server error for ${item['name']}: ${data['error']} (${response.statusCode})';
            }
          } catch (_) {/* Ignore decode error if body isn't JSON */}
          Get.snackbar('Error', errorMsg);
          break;
        }
      } catch (e) {
        // Handle network or other exceptions
        allSucceeded = false;
        print('Exception creating order for ${item['name']}: $e');
        Get.snackbar('Error',
            'Network error placing order for ${item['name']}. Check connection/URL.');
        break;
      }
    }

    if (Get.isDialogOpen ?? false) Get.back(); // Close loading indicator

    if (allSucceeded) {
      clearCart();
      Get.snackbar(
          'Success', 'Checkout complete! Your orders have been placed.');
      await ordersController.fetchOrders(); // Use await if fetchOrders is async
    } else {
      cartItems.assignAll(itemsToKeep);
      Get.snackbar('Checkout Failed',
          'Some items could not be ordered. Please try again.');
    }
  }
}
