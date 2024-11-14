import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_flutter_app/pages/category_page.dart';
import 'package:wallpaper_flutter_app/pages/home_page.dart';
import 'package:wallpaper_flutter_app/pages/settings_page.dart';
import 'package:wallpaper_flutter_app/themeHandler/theme_provider.dart';
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
    const HomePage(),
    const CategoryPage(),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.accentColor.withOpacity(0.1),
        centerTitle: true,
        title: Text(
          "PIXEL PICKS",
          style: TextStyle(
              color: themeProvider.accentColor, fontWeight: FontWeight.bold),
        ),
        actions: actionCheck(_selectedIndex),
      ),
      body: Container(
        color: themeProvider.accentColor.withOpacity(0.1),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        color: themeProvider.accentColor.withOpacity(0.1),
        child: BottomNavyBar(
          backgroundColor: Colors.transparent,
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
                ),
              ),
              activeColor: themeProvider.accentColor,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.category),
              title: const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Category',
                ),
              ),
              activeColor: themeProvider.accentColor,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.settings),
              title: const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Settings',
                ),
              ),
              activeColor: themeProvider.accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
