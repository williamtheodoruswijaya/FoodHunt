class MenuItemModel {
  final int itemId;
  final String name;
  final String? description;
  final String price;

  MenuItemModel({
    required this.itemId,
    required this.name,
    this.description,
    required this.price,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      itemId: json["itemId"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
    );
  }
}
