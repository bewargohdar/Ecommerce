import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../../../features/product/domain/entity/product.dart';

class ProductCart extends StatelessWidget {
  final ProductEntity? product;
  const ProductCart({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(product?.thumbnail ??
                      'https://i.dummyjson.com/data/products/1/thumbnail.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.title ?? 'Mohair Blouse',
                  style: const TextStyle(
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w300),
                ),
                Row(
                  children: [
                    Text(
                      '\$${product?.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '\$${((product?.price ?? 0) * (1 + (product?.discountPercentage ?? 0) / 100)).toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
