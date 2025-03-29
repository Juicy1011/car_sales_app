import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/configs/mycolors.dart';
import 'package:login/controllers/cart_controller.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    final List<Map<String, dynamic>> cars = [
      {
        'id': 1,
        'name': 'Rolls Royce Phantom',
        'brand': 'Rolls Royce',
        'model': '2024',
        'price': 455000.00,
        'lease_rate': 250.00,
        'description':
            'Luxury flagship sedan with ultimate comfort and elegance',
        'image': 'assets/images/car1.jpeg'
      },
      {
        'id': 2,
        'name': 'Bentley Continental GT',
        'brand': 'Bentley',
        'model': '2024',
        'price': 225000.00,
        'lease_rate': 150.00,
        'description': 'Grand touring coupe with exceptional performance',
        'image': 'assets/images/car2.jpeg'
      },
      {
        'id': 3,
        'name': 'Lamborghini Huracan',
        'brand': 'Lamborghini',
        'model': '2024',
        'price': 325000.00,
        'lease_rate': 200.00,
        'description': 'Supercar with breathtaking performance and design',
        'image': 'assets/images/car3.jpg'
      },
      {
        'id': 4,
        'name': 'Ferrari SF90 Stradale',
        'brand': 'Ferrari',
        'model': '2024',
        'price': 625000.00,
        'lease_rate': 300.00,
        'description':
            'Hybrid supercar with revolutionary performance technology',
        'image': 'assets/images/car4.jpg'
      },
      {
        'id': 5,
        'name': 'Aston Martin DBS',
        'brand': 'Aston Martin',
        'model': '2024',
        'price': 385000.00,
        'lease_rate': 220.00,
        'description': 'Legendary grand tourer with British excellence',
        'image': 'assets/images/car5.jpeg'
      },
      {
        'id': 6,
        'name': 'McLaren 720S',
        'brand': 'McLaren',
        'model': '2024',
        'price': 299000.00,
        'lease_rate': 180.00,
        'description': 'Track-focused supercar with cutting-edge aerodynamics',
        'image': 'assets/images/car6.jpeg'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Luxury Cars'),
        backgroundColor: mainColor,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Get.toNamed('/cart'),
              ),
              Obx(() => cartController.cartItems.isNotEmpty
                  ? Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '${cartController.cartItems.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
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
                    mainAxisSize: MainAxisSize.min,
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
                                cartController.addToCart(cars[index], 'buy');
                                Get.snackbar(
                                  'Success',
                                  'Added to cart',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text('Buy Now'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                cartController.addToCart(cars[index], 'lease',
                                    duration: 1);
                                Get.snackbar(
                                  'Success',
                                  'Added to cart',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: SecondaryColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
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
