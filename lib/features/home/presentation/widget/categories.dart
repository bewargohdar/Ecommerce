import 'package:ecomerce/common/helper/category_image_helper.dart';
import 'package:ecomerce/features/category/domain/entity/category.dart';
import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/features/product/presentation/page/products_page.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final List<CategoryEntity> categories;
  const Categories({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemCount: categories.length > 5 ? 5 : categories.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final category = categories[index];

          return GestureDetector(
            onTap: () {
              AppNavigator.push(
                  context,
                  ProductsPage(
                    categoryName: category.name,
                  ));
            },
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300),
                    image: DecorationImage(
                      image: NetworkImage(category.imageUrl),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        // Handle image loading error silently
                      },
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 60,
                  child: Text(
                    category.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 15),
      ),
    );
  }
}
