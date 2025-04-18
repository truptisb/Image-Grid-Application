import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = "RGR7lK4GydSoSuGzTCJIngc6GjyK77oLtBnN-pBxv2M"; // Replace with your Unsplash API key

  Future<List<String>> fetchImages() async {
    final url = Uri.parse('https://api.unsplash.com/photos?client_id=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => item['urls']['small'] as String).toList();
      } else {
        throw Exception("Failed to load images");
      }
    } catch (e) {
      throw Exception("Failed to load images: $e");
    }
  }
}
