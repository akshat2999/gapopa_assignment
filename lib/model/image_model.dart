class ImageData {
  final int id;
  final String imageUrl;
  final int likes;
  final int views;

  ImageData({
    required this.id,
    required this.imageUrl,
    required this.likes,
    required this.views,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      imageUrl: json['webformatURL'],
      likes: json['likes'],
      views: json['views'],
    );
  }
}
