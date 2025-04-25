// controllers/orders_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:voitureRoyale/configs/config.dart';
// Import API URLs

class OrdersController extends GetxController {
  // Use RxList for reactive updates
  final RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;
  // Add loading and error states
  final RxBool isLoading = true.obs; // Start as loading initially
  final RxString errorMessage = ''.obs;

  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'ngrok-skip-browser-warning': 'true',
    // Add 'Content-Type' ONLY for POST/PUT requests with a body
  };

  @override
  void onInit() {
    super.onInit();
    fetchOrders(); // Fetch orders when the controller is initialized
  }

  // --- Fetch Orders ---
  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      errorMessage(''); // Clear previous errors
      // TODO: Add user filtering if needed (pass user_id as query parameter)
      // final url = Uri.parse("${ApiUrls.getOrders}?user_id=YOUR_USER_ID");
      final url = Uri.parse(
          'http://localhost/car_sales/get_orders.php'); // Fetch all for now

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Ensure data is treated as List<Map<String, dynamic>>
        orders.assignAll(
            data.map((item) => Map<String, dynamic>.from(item)).toList());
      } else {
        errorMessage('Failed to load orders: ${response.statusCode}');
        print('Error fetching orders: ${response.body}');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
      print('Exception fetching orders: $e');
    } finally {
      isLoading(false);
    }
  }

  // --- Delete Order ---
  Future<bool> deleteOrder(String orderId) async {
    try {
      // Show some loading indicator specific to deletion if needed
      final url = Uri.parse('http://localhost/car_sales/delete_orders.php');
      final response = await http.post(
        url,
        body: {'order_id': orderId}, // Send order_id in the body
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('message')) {
          // Successfully deleted on server, now remove locally or refetch
          // Option 1: Remove locally (faster UI update)
          // orders.removeWhere((order) => order['order_id'] == orderId);

          // Option 2: Refetch (ensures consistency with server)
          await fetchOrders(); // Refresh the list from the server
          return true; // Indicate success
        } else {
          // Handle potential error message from PHP
          Get.snackbar('Error', data['error'] ?? 'Failed to delete order.');
          print('Error deleting order: ${data['error']}');
          return false;
        }
      } else {
        Get.snackbar('Error', 'Failed to delete order: ${response.statusCode}');
        print(
            'Error deleting order (HTTP ${response.statusCode}): ${response.body}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print('Exception deleting order: $e');
      return false;
    }
  }

  // --- Add Order (Locally - Kept for potential direct add scenarios) ---
  // Note: This is less relevant now as orders are created via CartController checkout
  void addOrderLocally(Map<String, dynamic> order) {
    orders.add(order);
  }
}
