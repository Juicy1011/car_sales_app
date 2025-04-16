// lib/models/car_model.dart

class Car {
  final String id;
  final String name;
  final String brand;
  final String imageUrl;
  final String description;
  final double pricePerHour;
  final int seats;
  final String fuelType;
  final String transmission;

  Car({
    required this.id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.description,
    required this.pricePerHour,
    required this.seats,
    required this.fuelType,
    required this.transmission,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      pricePerHour:
          double.tryParse(json['price_per_hour']?.toString() ?? '') ?? 0.0,
      seats: int.tryParse(json['seats']?.toString() ?? '') ?? 0,
      fuelType: json['fuel_type']?.toString() ?? '',
      transmission: json['transmission']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'image_url': imageUrl,
      'description': description,
      'price_per_hour': pricePerHour.toString(),
      'seats': seats.toString(),
      'fuel_type': fuelType,
      'transmission': transmission,
    };
  }

  /// For adding to cart — if you need a specific format
  Map<String, dynamic> toMapForCart() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'image_url': imageUrl,
      'price_per_hour': pricePerHour,
    };
  }
}
