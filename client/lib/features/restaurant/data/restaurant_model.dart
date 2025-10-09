class Restaurant {
  final int id;
  final String name;
  final String description;
  final double rating;
  final String priceRange;
  final String category;
  final String locationName;
  final String imageUrl;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.priceRange,
    required this.category,
    required this.locationName,
    required this.imageUrl,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? json['restaurantId'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      rating: (json['averageRating'] ?? 0.0).toDouble(),
      priceRange: json['priceRange']?.toString() ?? '',
      category: json['category'] ?? '',
      locationName: json['address'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'rating': rating,
      'priceRange': priceRange,
      'category': category,
      'locationName': locationName,
      'imageUrl': imageUrl,
    };
  }
}
