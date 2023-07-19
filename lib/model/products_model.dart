class ProductModel {
  final int id;
  final double price;
  final String title;
  final List<String> imageUrl;

  ProductModel({
    required this.id,
    required this.price,
    required this.title,
    required this.imageUrl,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      price: json['price'].toDouble(),
      title: json['title'],
      imageUrl: List<String>.from(json['images']),
    );
  }
}
