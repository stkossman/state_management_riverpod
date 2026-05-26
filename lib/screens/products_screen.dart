import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../theme/app_theme.dart';
import 'cart_screen.dart';
import 'widgets/product_card.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final filteredProducts = ref.watch(filteredProductsListProvider);
    final selectedCategory = ref.watch(filteredProductsProvider);
    final cartCount = ref.watch(cartCountProvider);
    final categories = [
      'All',
      ...products.map((product) => product.category).toSet(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOP'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const CartScreen()),
                );
              },
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 30),
                  if (cartCount > 0)
                    Positioned(
                      right: -10,
                      top: -8,
                      child: Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Courier New',
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: TextField(
              style: const TextStyle(
                fontFamily: 'Courier New',
                fontWeight: FontWeight.w800,
              ),
              decoration: InputDecoration(
                hintText: 'SEARCH PRODUCTS',
                hintStyle: const TextStyle(
                  fontFamily: 'Courier New',
                  fontWeight: FontWeight.w800,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                ),
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),
          SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final category = categories[index];
                final selected = selectedCategory == category;
                return FilterChip(
                  showCheckmark: false,
                  selected: selected,
                  label: Text(category.toUpperCase()),
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Courier New',
                  ),
                  backgroundColor: Colors.white,
                  selectedColor: Colors.black,
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  onSelected: (_) {
                    ref.read(filteredProductsProvider.notifier).state =
                        category;
                  },
                );
              },
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      'NO PRODUCTS FOUND',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Courier New',
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 20, 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 18,
                          childAspectRatio: 0.68,
                        ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: filteredProducts[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(4, 4), blurRadius: 0),
          ],
        ),
        child: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: AppTheme.orange,
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: Colors.black, width: 2.5),
          ),
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute<void>(builder: (_) => const CartScreen()));
          },
          icon: const Icon(Icons.shopping_bag_outlined),
          label: const Text(
            'CART',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: 'Courier New',
            ),
          ),
        ),
      ),
    );
  }
}
