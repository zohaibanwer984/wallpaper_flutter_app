import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  final String imageSource;
  final VoidCallback onTap;
  final double? imageSize; // Keep it as nullable

  const ClickableCard({
    super.key,
    required this.imageSource,
    required this.onTap,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    // Image widget based on imageSize, defaulting to a large width if imageSize is not provided.
    final imageWidget = Image.network(
      imageSource,
      fit: BoxFit.cover,
      width: imageSize ?? 1000, // Default to 1000 width if imageSize is null
      height: imageSize, // Only apply height if imageSize is provided
    );

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: imageWidget,
      ),
    );
  }
}
