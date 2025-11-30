
import 'package:flutter/widgets.dart';

class FoodItem extends StatelessWidget {
  final String imageUrl;
  const FoodItem({
    super.key,
    required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}