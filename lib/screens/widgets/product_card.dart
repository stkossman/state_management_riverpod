import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartItem = cart
        .where((item) => item.product.id == product.id)
        .firstOrNull;
    final notifier = ref.read(cartProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.5),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(4, 4), blurRadius: 0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  product.image,
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                product.category.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Courier New',
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: AppTheme.orange,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                fontFamily: 'Courier New',
              ),
            ),
            const SizedBox(height: 12),
            if (cartItem == null)
              _ShadowButton(
                label: 'ADD TO CART',
                onPressed: () => notifier.addProduct(product),
              )
            else
              Row(
                children: [
                  _QuantityButton(
                    label: '-',
                    onPressed: () => notifier.decrementQuantity(product.id),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '${cartItem.quantity}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  _QuantityButton(
                    label: '+',
                    onPressed: () => notifier.incrementQuantity(product.id),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ShadowButton extends StatelessWidget {
  const _ShadowButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(3, 3), blurRadius: 0),
          ],
        ),
        child: Material(
          color: Colors.black,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Courier New',
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black, offset: Offset(3, 3), blurRadius: 0),
        ],
      ),
      child: Material(
        color: AppTheme.orange,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                fontFamily: 'Courier New',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
