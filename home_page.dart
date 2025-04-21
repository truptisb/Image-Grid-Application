import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service.dart';
import 'package:flutter_application_1/image.dart';
 import 'screen.dart';    // Detail screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ImageItem>> _imageItems;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _imageItems = _apiService.fetchImages();
  }

  void _reloadImages() {
    setState(() {
      _imageItems = _apiService.fetchImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: const Text(
          "G R I D L Y",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _reloadImages,
            tooltip: 'Reload',
            icon: const Icon(Icons.refresh_rounded, color: Colors.black87),
          )
        ],
      ),
      body: FutureBuilder<List<ImageItem>>(
        future: _imageItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading images"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No images available"));
          }

          final imageItems = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              itemCount: imageItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final item = imageItems[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          imageUrl: item.imageUrl,
                          title: item.title,
                          description: item.description,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: item.imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: item.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey.shade300),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
