import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/configs/mycolors.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cars = [
      {
        'name': 'Rolls Royce Phantom',
        'brand': 'Rolls Royce',
        'model': '2024',
        'price': 455000.00,
        'lease_rate': 250.00,
        'description': 'Luxury flagship sedan with ultimate comfort and elegance',
        'image': 'images/car1.jpg'
      },
      {
        'name': 'Bentley Continental GT',
        'brand': 'Bentley',
        'model': '2024',
        'price': 225000.00,
        'lease_rate': 150.00,
        'description': 'Grand touring coupe with exceptional performance',
        'image': 'images/car2.jpg'
      },
      {
        'name': 'Lamborghini Huracan',
        'brand': 'Lamborghini',
        'model': '2024',
        'price': 325000.00,
        'lease_rate': 200.00,
        'description': 'Supercar with breathtaking performance and design',
        'image': 'images/car3.jpg'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Luxury Cars'),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.asset(
                    cars[index]['image']!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cars[index]['name']!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${cars[index]['brand']} ${cars[index]['model']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        cars[index]['description']!,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${cars[index]['price'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor,
                                ),
                              ),
                              const Text('Purchase Price'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${cars[index]['lease_rate'].toStringAsFixed(2)}/hr',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor,
                                ),
                              ),
                              const Text('Lease Rate'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle buy action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text('Buy Now'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle lease action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: SecondaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text('Lease Now'),
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
}
