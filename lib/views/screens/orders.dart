// screens/orders.dart (or wherever Orders widget is)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voitureRoyale/configs/mycolors.dart';
import 'package:voitureRoyale/controllers/orders_controller.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Get.put if not already initialized elsewhere, or Get.find if already initialized
    // If initializing here, ensure it's done only once. A binding might be better.
    final OrdersController ordersController = Get.put(OrdersController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: mainColor,
        elevation: 0,
        actions: [
          // Add a refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ordersController.fetchOrders(),
          )
        ],
      ),
      body: Obx(() {
        // Use Obx to react to changes in the controller's Rx variables
        // Handle Loading State
        if (ordersController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Handle Error State
        if (ordersController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Error: ${ordersController.errorMessage.value}",
                    textAlign: TextAlign.center),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => ordersController.fetchOrders(),
                  child: const Text("Retry"),
                )
              ],
            ),
          );
        }

        // Handle Empty State
        if (ordersController.orders.isEmpty) {
          return const Center(child: Text("No orders yet"));
        }

        // Display Orders List
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: ordersController.orders.length,
          itemBuilder: (context, index) {
            // Use the keys from your get_orders.php response
            final order = ordersController.orders[index];
            final String carName = order['car_name'] ?? 'Unknown Car';
            final String orderId = order['order_id'] ?? 'N/A';
            final String date =
                order['created_at'] ?? 'Unknown Date'; // Format later if needed
            final String status = order['status'] ?? 'unknown';
            final String type =
                order['category'] ?? 'unknown'; // 'buy' or 'lease'
            final String priceString = order['total_price'] ?? '0.0';
            final double price = double.tryParse(priceString) ?? 0.0;

            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                title: Text(
                  carName, // Use car_name from PHP
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID: $orderId'), // Use order_id from PHP
                    Text('Date: $date'), // Use created_at from PHP
                    _buildStatusChip(status), // Use status from PHP
                  ],
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildOrderDetailRow(
                            'Type', type.toUpperCase()), // Use category
                        _buildOrderDetailRow(
                          'Price',
                          '\$${price.toStringAsFixed(2)}', // Use total_price
                        ),
                        // Optionally show lease duration if applicable
                        if (type.toLowerCase() == 'lease' &&
                            order.containsKey('lease_duration'))
                          _buildOrderDetailRow('Lease Duration',
                              '${order['lease_duration']} months'), // Example

                        const SizedBox(height: 16),
                        // Show cancel button only for 'pending' orders
                        if (status.toLowerCase() == 'pending')
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // Show confirmation dialog
                                    bool? confirm =
                                        await Get.dialog<bool>(AlertDialog(
                                      title: const Text('Cancel Order'),
                                      content: Text(
                                          'Are you sure you want to cancel the order for $carName?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(
                                              result:
                                                  false), // Close dialog, return false
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () => Get.back(
                                              result:
                                                  true), // Close dialog, return true
                                          child: const Text('Yes, Cancel'),
                                        ),
                                      ],
                                    ));

                                    if (confirm == true) {
                                      // Call the delete method in the controller
                                      bool deleted = await ordersController
                                          .deleteOrder(orderId);
                                      if (deleted) {
                                        Get.snackbar('Success',
                                            'Order $orderId canceled.');
                                        // List will refresh automatically due to fetchOrders() in deleteOrder
                                      }
                                      // Error snackbar is handled within deleteOrder
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text('Cancel Order'),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  // Helper widgets remain the same
  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status.toLowerCase()) {
      case 'completed':
        chipColor = Colors.green;
        break;
      case 'pending':
        chipColor = Colors.orange;
        break;
      case 'canceled': // Match your potential DB status
      case 'cancelled':
        chipColor = Colors.red;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Chip(
      label: Text(
        status.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: chipColor,
      padding: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 2), // Adjust padding
      materialTapTargetSize:
          MaterialTapTargetSize.shrinkWrap, // Reduce tap area
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
