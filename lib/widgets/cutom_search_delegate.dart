import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_flutter_app/screens/wallpaper_screen.dart';
import 'package:wallpaper_flutter_app/utils/pexel_api.dart';

class CustomSearchDelegate extends SearchDelegate {
  final PexelsAPI _pexelsAPI = PexelsAPI();
  List<String> _searchResults = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _pexelsAPI
          .fetchWallpapers(query), // Fetch wallpapers based on search query
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error fetching wallpapers"));
        } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return const Center(child: Text("No results found"));
        }

        _searchResults = snapshot.data as List<String>;
        return MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        WallpaperScreen(source: _searchResults[index]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  _searchResults[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
        // return GridView.builder(
        //   padding: const EdgeInsets.all(8),
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 8,
        //     mainAxisSpacing: 8,
        //   ),
        //   itemCount: _searchResults.length,
        //   itemBuilder: (context, index) {
        //     return GestureDetector(
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (_) => WallpaperScreen(source: _searchResults[index]),
        //           ),
        //         );
        //       },
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(10),
        //         child: Image.network(
        //           _searchResults[index],
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     );
        //   },
        // );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Here, you could add recent searches or suggestions
    final suggestions = [
      "Nature",
      "Space",
      "Animals",
      "Abstract",
      "Mountains",
    ]
        .where((suggestion) =>
            suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context); // Show results based on selected suggestion
          },
        );
      },
    );
  }
}
