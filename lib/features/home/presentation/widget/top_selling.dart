import 'package:ecomerce/common/widget/product/product_cart.dart';
import 'package:flutter/material.dart';

class TopSelling extends StatelessWidget {
  const TopSelling({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                width: 20,
              ),
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return const ProductCart();
          }),
    );
  }
}
