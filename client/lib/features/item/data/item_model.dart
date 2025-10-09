class MenuItem {
  final int id;
  final int restaurantId;
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      // sesuain sama response backend nanti kalo udah ada
      id: json['id'] ?? 0,
      restaurantId: json['restaurantId'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toString() ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
