import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';
import 'products_provider.dart';

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {'product': product.toJson(), 'quantity': quantity};
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );
  }
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super(const []) {
    Future.microtask(loadFromPrefs);
  }

  static const _cartKey = 'cart_items';

  void addProduct(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      state = [...state, CartItem(product: product, quantity: 1)];
    } else {
      state = [
        for (final item in state)
          if (item.product.id == product.id)
            item.copyWith(quantity: item.quantity + 1)
          else
            item,
      ];
    }
    saveToPrefs();
  }

  void removeProduct(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
    saveToPrefs();
  }

  void incrementQuantity(String productId) {
    state = [
      for (final item in state)
        if (item.product.id == productId)
          item.copyWith(quantity: item.quantity + 1)
        else
          item,
    ];
    saveToPrefs();
  }

  void decrementQuantity(String productId) {
    state = [
      for (final item in state)
        if (item.product.id == productId && item.quantity > 1)
          item.copyWith(quantity: item.quantity - 1)
        else if (item.product.id != productId)
          item,
    ];
    saveToPrefs();
  }

  void clear() {
    state = const [];
    saveToPrefs();
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final rawCart = prefs.getString(_cartKey);
    if (rawCart == null || rawCart.isEmpty) {
      return;
    }
    final decoded = jsonDecode(rawCart) as List<dynamic>;
    state = decoded
        .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(state.map((item) => item.toJson()).toList());
    await prefs.setString(_cartKey, encoded);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold<double>(
    0,
    (total, item) => total + item.product.price * item.quantity,
  );
});

final cartCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold<int>(0, (total, item) => total + item.quantity);
});

final filteredProductsProvider = StateProvider<String>((ref) => 'All');

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredProductsListProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(productsProvider);
  final selectedCategory = ref.watch(filteredProductsProvider);
  final searchQuery = ref.watch(searchQueryProvider).trim().toLowerCase();

  return products.where((product) {
    final matchesCategory =
        selectedCategory == 'All' || product.category == selectedCategory;
    final matchesSearch =
        searchQuery.isEmpty ||
        product.name.toLowerCase().contains(searchQuery) ||
        product.category.toLowerCase().contains(searchQuery);
    return matchesCategory && matchesSearch;
  }).toList();
});
