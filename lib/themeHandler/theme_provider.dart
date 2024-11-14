import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_data_style.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeDataStyle;
  Color _accentColor = Colors.blue; // Default accent color

  ThemeData get themeDataStyle => _themeDataStyle;
  Color get accentColor => _accentColor;

  ThemeProvider() : _themeDataStyle = ThemeDataStyle.getLightTheme(Colors.blue) {
    _loadThemePreferences(); // Load theme and accent color when the app starts
  }

  // Load the theme and accent color preferences from SharedPreferences
  void _loadThemePreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // Load theme preference
    bool isDarkMode = pref.getBool('theme') ?? false;

    // Load accent color preference
    int accentColorValue = pref.getInt('accentColor') ?? Colors.blue.value;
    _accentColor = Color(accentColorValue);

    _themeDataStyle = isDarkMode
        ? ThemeDataStyle.getDarkTheme(_accentColor)
        : ThemeDataStyle.getLightTheme(_accentColor);

    notifyListeners();
  }

  // Toggle theme and save preference
  void toggleTheme(bool isDarkMode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    _themeDataStyle = isDarkMode
        ? ThemeDataStyle.getDarkTheme(_accentColor)
        : ThemeDataStyle.getLightTheme(_accentColor);
    await pref.setBool('theme', isDarkMode); // Save theme preference

    notifyListeners();
  }

  // Update accent color and save preference
  void setAccentColor(Color color) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    _accentColor = color;
    await pref.setInt('accentColor', color.value); // Save accent color preference

    _themeDataStyle = _themeDataStyle.brightness == Brightness.dark
        ? ThemeDataStyle.getDarkTheme(_accentColor)
        : ThemeDataStyle.getLightTheme(_accentColor);

    notifyListeners();
  }
}
