import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voitureRoyale/configs/mycolors.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample order data - replace with API data later
    final List<Map<String, dynamic>> orders = [
      {
        'id': 'ORD001',
        'car': 'Rolls Royce Phantom',
        'type': 'buy',
        'price': 455000.00,
        'date': '2024-03-28',
        'status': 'completed',
      },
      {
        'id': 'ORD002',
        'car': 'Bentley Continental GT',
        'type': 'lease',
        'price': 150.00,
        'duration': '2 hours',
        'date': '2024-03-27',
        'status': 'pending',
      },
      {
        'id': 'ORD003',
        'car': 'Lamborghini Huracan',
        'type': 'buy',
        'price': 325000.00,
        'date': '2024-03-26',
        'status': 'canceled',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              title: Text(
                order['car'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID: ${order['id']}'),
                  Text('Date: ${order['date']}'),
                  _buildStatusChip(order['status']),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOrderDetailRow('Type', order['type'].toUpperCase()),
                      _buildOrderDetailRow(
                        'Price',
                        '\$${order['price'].toStringAsFixed(2)}',
                      ),
                      if (order['type'] == 'lease')
                        _buildOrderDetailRow('Duration', order['duration']),
                      const SizedBox(height: 16),
                      if (order['status'] == 'pending')
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle cancel action
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
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status.toLowerCase()) {
      case 'completed':
        chipColor = Colors.green;
        break;
      case 'pending':
        chipColor = Colors.orange;
        break;
      case 'canceled':
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
