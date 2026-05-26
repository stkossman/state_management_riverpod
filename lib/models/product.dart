class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
  });

  final String id;
  final String name;
  final double price;
  final String category;
  final String image;

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? category,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'image': image,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      image: json['image'] as String,
    );
  }
}
