import 'package:flutter/material.dart';
import 'package:wallpaper_flutter_app/screens/category_screen.dart';
import 'package:wallpaper_flutter_app/utils/pexel_api.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final PexelsAPI _pexelsAPI = PexelsAPI();
  final List<Map<String, String>> categories = [
    {'name': 'Nature'},
    {'name': 'Animals'},
    {'name': 'Abstract'},
    {'name': 'Technology'},
    {'name': 'Space'},
    {'name': 'Fashion'},
    {'name': 'Food'},
    {'name': 'Sports'},
    {'name': 'Travel'},
    {'name': 'Music'},
    {'name': 'Architecture'},
    {'name': 'Cars'},
  ];

  Map<String, String> categoryImages = {}; // Stores images for each category
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCategoryImages();
  }

  Future<void> _loadCategoryImages() async {
    for (var category in categories) {
      try {
        final imageUrl = await _pexelsAPI.fetchSingleImage(category['name']!);
        if (imageUrl != null) {
          categoryImages[category['name']!] = imageUrl;
        }
      } catch (e) {
        print('Error loading image for ${category['name']}: $e');
      }
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5, // Controls pill shape
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final categoryName = categories[index]['name']!;
                  final imageUrl = categoryImages[categoryName];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(categoryName: categoryName),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: imageUrl != null
                            ? DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken,
                                ),
                              )
                            : null,
                        color: Colors.grey.shade200,
                      ),
                      child: Center(
                        child: Text(
                          categoryName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
