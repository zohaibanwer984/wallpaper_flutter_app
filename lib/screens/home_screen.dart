import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_flutter_app/pages/category_page.dart';
import 'package:wallpaper_flutter_app/pages/home_page.dart';
import 'package:wallpaper_flutter_app/pages/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    CategoryPage(),
    const SettingPage(),
  ];
  List<Widget> actionCheck(int index) {
    List<Widget> actions = [];
    setState(() {
      if (index == 0) {
        actions.add(
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        );
      }
    });
    return actions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("WALLPAPER APP"),
        actions: actionCheck(_selectedIndex),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        selectedIndex: _selectedIndex,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.apps),
            title: const Text('Home'),
            activeColor: Colors.deepPurpleAccent,
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.category),
              title: const Text('Category'),
              activeColor: Colors.deepPurpleAccent),
          BottomNavyBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Settings'),
              activeColor: Colors.deepPurpleAccent),
        ],
      ),
    );
  }
}
