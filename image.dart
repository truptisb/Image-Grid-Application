class ImageItem {
  final String imageUrl;
  final String title;
  final String description;

  ImageItem({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  factory ImageItem.fromJson(Map<String, dynamic> json) {
    return ImageItem(
      imageUrl: json['urls']['small'],
      title: json['alt_description'] ?? 'Untitled',
      description: json['description'] ?? 'No description available',
    );
  }
}
