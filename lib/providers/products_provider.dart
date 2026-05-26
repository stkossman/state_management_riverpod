import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';

final productsProvider = Provider<List<Product>>((ref) {
  return const [
    Product(
      id: 'headphones',
      name: 'Boom Headphones',
      price: 89.99,
      category: 'Electronics',
      image: '🎧',
    ),
    Product(
      id: 'keyboard',
      name: 'Clicky Keyboard',
      price: 129.99,
      category: 'Electronics',
      image: '⌨️',
    ),
    Product(
      id: 'jacket',
      name: 'Street Jacket',
      price: 74.50,
      category: 'Clothing',
      image: '🧥',
    ),
    Product(
      id: 'sneakers',
      name: 'Block Sneakers',
      price: 119.00,
      category: 'Clothing',
      image: '👟',
    ),
    Product(
      id: 'novel',
      name: 'Pixel Novel',
      price: 18.95,
      category: 'Books',
      image: '📕',
    ),
    Product(
      id: 'cookbook',
      name: 'Loud Cookbook',
      price: 26.25,
      category: 'Books',
      image: '📚',
    ),
    Product(
      id: 'mug',
      name: 'Chunky Mug',
      price: 14.99,
      category: 'Kitchen',
      image: '☕',
    ),
    Product(
      id: 'pan',
      name: 'Iron Pan',
      price: 42.00,
      category: 'Kitchen',
      image: '🍳',
    ),
  ];
});
