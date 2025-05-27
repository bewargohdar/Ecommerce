import 'package:ecomerce/core/config/assets/app_images.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class ProductCart extends StatelessWidget {
  const ProductCart({
    super.key,
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
                  image: AssetImage(AppImages.profile),
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
                  'Mohair Blouse',
                  style: const TextStyle(
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w300),
                ),
                Row(
                  children: [
                    Text(
                      '\$100',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '\$120',
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
