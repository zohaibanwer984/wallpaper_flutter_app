import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_flutter_app/screens/home_screen.dart';
import 'package:wallpaper_flutter_app/themeHandler/theme_data_style.dart';
import 'package:wallpaper_flutter_app/themeHandler/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context)
          .themeDataStyle, // Light/Default mode styles
      darkTheme: ThemeDataStyle.dark, // Dark mode styles
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}