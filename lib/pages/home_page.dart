import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_flutter_app/screens/wallpaper_screen.dart';
import 'package:wallpaper_flutter_app/utils/pexel_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PexelsAPI _pexelsAPI = PexelsAPI();
  List<String> _trendingWallpapers = [];
  List<String> _featuredWallpapers = [];
  bool _loading = false;

  // Define categories
  final List<String> categories = [
    'Popular',
    'Nature',
    'Animals',
    'Abstract',
    'Technology',
    'Space',
    'Fashion',
  ];

  @override
  void initState() {
    super.initState();
    _loadFeaturedAndTrendingWallpapers();
  }

  // Load featured and trending wallpapers
  Future<void> _loadFeaturedAndTrendingWallpapers() async {
    if (!mounted) {
      return;
    }
    setState(() {
      _loading = true;
    });
    try {
      _featuredWallpapers = await _pexelsAPI.fetchRandomWallpapers();
      _trendingWallpapers = await _pexelsAPI.fetchWallpapers('popular');
    } catch (e) {
      print('Error fetching wallpapers: $e');
    }
    setState(() {
      _loading = false;
    });
  }

  // Fetch wallpapers for selected category
  void _fetchCategoryWallpapers(String category) async {
    if (!mounted) {
      return;
    }
    setState(() {
      _loading = true;
    });
    _trendingWallpapers = await _pexelsAPI.fetchWallpapers(category);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_loading)
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Carousel for Featured Wallpapers
                Padding(
                  padding: const EdgeInsets.all(9),
                  child: CarouselSlider(
                    items: _featuredWallpapers.map((imageUrl) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WallpaperScreen(source: imageUrl),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                    ),
                  ),
                ),

                // Categories Section
                Padding(
                  padding: const EdgeInsets.all(9),
                  child: Text(
                    'You may like these',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () =>
                            _fetchCategoryWallpapers(categories[index]),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(
                                50), // Makes the pill shape
                          ),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                MasonryGridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  padding: const EdgeInsets.all(13.0),
                  itemCount: _trendingWallpapers.length,
                  shrinkWrap:
                      true, // Makes MasonryGridView fit within SingleChildScrollView
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable inner scrolling
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WallpaperScreen(
                                source: _trendingWallpapers[index]),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          _trendingWallpapers[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
