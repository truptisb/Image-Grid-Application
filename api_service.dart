import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = "API KEY HERE"; 

  Future<List<String>> fetchImages() async {
    final url = Uri.parse('https://api.unsplash.com/photos?client_id=$apiKey');

   try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        
        // Map each image data to ImageItem
        return data.map((item) => ImageItem.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load images");
      }
    } catch (e) {
      throw Exception("Failed to load images: $e");
    }
  }
}
