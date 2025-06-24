import 'package:ecomerce/features/product/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';

import '../../../product/domain/entity/product.dart';

class TopSelling extends StatelessWidget {
  final List<ProductEntity> products;
  const TopSelling({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
          itemCount: products.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
            );
          }),
    );
  }
}
