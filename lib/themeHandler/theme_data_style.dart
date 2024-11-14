import 'package:flutter/material.dart';

class ThemeDataStyle {
  // Method to get light theme with a specified color seed
  static ThemeData getLightTheme(Color colorSeed) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: colorSeed,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Method to get dark theme with a specified color seed
  static ThemeData getDarkTheme(Color colorSeed) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: colorSeed,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
