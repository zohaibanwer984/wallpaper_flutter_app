import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_data_style.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeDataStyle = ThemeDataStyle.light;

  ThemeData get themeDataStyle => _themeDataStyle;

  ThemeProvider() {
    _loadThemePreference(); // Load theme when the app starts
  }

  // Load the theme preference from SharedPreferences
  void _loadThemePreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isDarkMode = pref.getBool('theme') ?? false;
    if (isDarkMode) {
      _themeDataStyle = ThemeDataStyle.dark;
    } else {
      _themeDataStyle = ThemeDataStyle.light;
    }
    notifyListeners();
  }

  // Save the theme preference to SharedPreferences
  void toggleTheme(bool isDarkMode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (isDarkMode) {
      _themeDataStyle = ThemeDataStyle.dark;
      await pref.setBool('theme', true); // Save dark theme preference
    } else {
      _themeDataStyle = ThemeDataStyle.light;
      await pref.setBool('theme', false); // Save light theme preference
    }
    notifyListeners();
  }
}
