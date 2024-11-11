import 'dart:convert';
import 'package:http/http.dart' as http;

class PexelsAPI {
  final String _baseUrl = 'https://api.pexels.com/v1';
  final String _apiKey =
      '6LB9dno1G5s5ZBUtjOhvp6OdvdUkZYuYmCMBdPO8g4vnnvtT8a7kTpvt'; // Replace with your actual Pexels API key

  // Fetches a single image based on a search term (e.g., "Nature" or "Space")
  Future<String?> fetchSingleImage(String searchTerm) async {
    final url = Uri.parse('$_baseUrl/search?query=$searchTerm&per_page=1');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['photos'] != null && data['photos'].isNotEmpty) {
          return data['photos'][0]['src']['large'];
        }
      } else {
        print('Failed to load image for $searchTerm: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching image for $searchTerm: $e');
    }
    return null;
  }

  // Function to fetch wallpapers based on a search query
  Future<List<String>> fetchWallpapers(String query) async {
    final url =
        Uri.parse('$_baseUrl/search?query=$query&per_page=20');

    final response = await http.get(url, headers: {
      'Authorization': _apiKey,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> imageUrls = [];

      for (var photo in data['photos']) {
        imageUrls.add(photo['src']['medium']); // Get the medium size of images
      }

      return imageUrls;
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }

  // Function to fetch random wallpapers
  Future<List<String>> fetchRandomWallpapers() async {
    final url = Uri.parse('https://api.pexels.com/v1/curated?per_page=20');

    final response = await http.get(url, headers: {
      'Authorization': _apiKey,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> imageUrls = [];

      for (var photo in data['photos']) {
        imageUrls.add(photo['src']['medium']); // Get the medium size of images
      }

      return imageUrls;
    } else {
      throw Exception('Failed to load random wallpapers');
    }
  }
}
