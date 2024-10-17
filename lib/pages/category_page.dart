import 'package:flutter/material.dart';
import 'package:wallpaper_flutter_app/screens/catagory_screen.dart';
import 'package:wallpaper_flutter_app/widgets/catagory_card.dart';

class CategoryPage extends StatelessWidget {
  final List<String> _categoryImage = [
    'https://images.pexels.com/photos/386009/pexels-photo-386009.jpeg?auto=compress&cs=tinysrgb&w=300',
    'https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg?auto=compress&cs=tinysrgb&w=300',
    'https://images.pexels.com/photos/247599/pexels-photo-247599.jpeg?auto=compress&cs=tinysrgb&w=300',
    'https://images.pexels.com/photos/1190297/pexels-photo-1190297.jpeg?auto=compress&cs=tinysrgb&w=300',
    'https://images.pexels.com/photos/209977/pexels-photo-209977.jpeg?auto=compress&cs=tinysrgb&w=300',
    'https://images.pexels.com/photos/2156/sky-earth-space-working.jpg?auto=compress&cs=tinysrgb&w=300',
  ];

  final List<String> _categories = [
    "Travel",
    "Abstract",
    "Nature",
    "Event",
    "Sports",
    "Space"
  ];
  final List<WallpaperCategory> _categoriesList = [
    WallpaperCategory.travel,
    WallpaperCategory.abstract,
    WallpaperCategory.nature,
    WallpaperCategory.event,
    WallpaperCategory.sports,
    WallpaperCategory.space
  ];

  CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = (MediaQuery.of(context).size.width / 2.0) - 30;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Categories",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  imageUrl: _categoryImage[index],
                  categoryName: _categories[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CatagoryScreen(category: _categoriesList[index]),
                      ),
                    );
                  },
                  imageSize: size,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
