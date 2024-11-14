import 'package:flutter/material.dart';
import 'package:wallpaper_flutter_app/utils/pexel_api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_flutter_app/screens/wallpaper_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;

  const CategoryScreen({super.key, required this.categoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PexelsAPI _pexelsAPI = PexelsAPI();
  List<String> _wallpapers = [];
  String? _backgroundImage;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCategoryData();
  }

  Future<void> _loadCategoryData() async {
    setState(() {
      _loading = true;
    });

    // Fetch background image for the category
    _backgroundImage = await _pexelsAPI.fetchSingleImage(widget.categoryName);

    // Fetch wallpapers for the selected category
    _wallpapers = await _pexelsAPI.fetchWallpapers(widget.categoryName);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_loading)
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Background Image
                if (_backgroundImage != null)
                  Positioned.fill(
                    child: Image.network(
                      _backgroundImage!,
                      fit: BoxFit.cover,
                    ),
                  ),

                // Dark overlay for readability
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),

                // Content with category title and grid of wallpapers
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button and category title
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text(
                              widget.categoryName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Wallpaper grid
                        Expanded(
                          child: MasonryGridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            itemCount: _wallpapers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => WallpaperScreen(
                                          source: _wallpapers[index]),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    _wallpapers[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
