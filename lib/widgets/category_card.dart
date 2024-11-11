import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  final VoidCallback onTap;
  final double? imageSize;

  const CategoryCard({
    super.key,
    required this.imageUrl,
    required this.categoryName,
    required this.onTap,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Wrap with GestureDetector to allow tapping functionality
      child: ClipRRect(
        // ClipRRect to round the corners of the whole card
        borderRadius: BorderRadius.circular(25), // Adjust the radius here
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: imageSize ??
                  150, // Use imageSize if available, otherwise default
              height: imageSize ?? 150,
            ),
            Container(
              width: imageSize ?? 150,
              color: Colors.black
                  .withOpacity(0.6), // Transparent background for text
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
