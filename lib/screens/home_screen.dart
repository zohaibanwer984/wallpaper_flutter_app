import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_flutter_app/pages/category_page.dart';
import 'package:wallpaper_flutter_app/pages/home_page.dart';
import 'package:wallpaper_flutter_app/pages/settings_page.dart';
import 'package:wallpaper_flutter_app/utils/pexel_api.dart';
import 'package:wallpaper_flutter_app/widgets/cutom_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PexelsAPI _pexelsAPI = PexelsAPI();

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
            icon: const Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
              if (query != null && query.isNotEmpty) {
                await _pexelsAPI.fetchWallpapers(query);
              }
            },
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
            title: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
            activeColor: Colors.deepPurpleAccent,
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.category),
              title: const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Category',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              activeColor: Colors.deepPurpleAccent),
          BottomNavyBarItem(
              icon: const Icon(Icons.settings),
              title: const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              activeColor: Colors.deepPurpleAccent),
        ],
      ),
    );
  }
}
