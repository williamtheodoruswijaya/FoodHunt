import 'package:client/theme/constants.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final bool isSelected;
  final String label;
  final String imageUrl;
  final VoidCallback? onTap;

  CategoryItem({
    required this.imageUrl,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected ? primary : Colors.transparent,
                shape: BoxShape.circle,
                border: isSelected
                  ? null
                  : Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: primary.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                ]
              ),
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(color: Colors.grey.shade100);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.fastfood, color: Colors.grey);
                  },
                ),
              ),
            ),
            const SizedBox(height: 8), 
            // Label
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? primary : Colors.black87,
              ),
            )
          ],
        ),
      ),
    );
  }
}