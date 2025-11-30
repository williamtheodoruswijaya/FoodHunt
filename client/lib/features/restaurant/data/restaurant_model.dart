class RestaurantModel {
  final int restaurantId;
  final String name;
  final String description;
  final String address;
  final String? imageUrl;
  final int? price;
  final double? latitude;
  final double? longitude;
  final double? averageRating;

  RestaurantModel({
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.address,
    this.imageUrl,
    this.price,
    this.latitude,
    this.longitude,
    this.averageRating,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      restaurantId: json['restaurantId'],
      name: json['name'],
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      imageUrl: json['imageUrl'],
      price: json['priceRange'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      averageRating: (json['averageRating'] as num?)?.toDouble(),
    );
  }
}
