import 'package:flutter/material.dart';

class WallpaperScreen extends StatelessWidget {
  final String source;
  const WallpaperScreen({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Wallpaper Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(source),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Back Button
          Positioned(
            top: 40, // Adjust this value depending on the status bar height
            left: 10,
            child: FloatingActionButton(
              heroTag: 'backButtonTag',
              mini: true,
              backgroundColor: Colors.black.withOpacity(0.6),
              onPressed: () {
                Navigator.pop(context); // Navigates back when pressed
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      // Floating Action Button with Paint Icon at the bottom
      floatingActionButton: FloatingActionButton(
        heroTag: 'paintButtonTag', // Assign a unique tag for the main button
        onPressed: () {
          // Add the functionality you want for this button
        },
        backgroundColor: Colors.black.withOpacity(0.7),
        child: const Icon(
          Icons.brush,
          color: Colors.white,
        ),
      ),
    );
  }
}
