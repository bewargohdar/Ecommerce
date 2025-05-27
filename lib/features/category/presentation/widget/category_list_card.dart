import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/category/data/helper/category_image_helper.dart';
import 'package:ecomerce/features/category/domain/entity/category.dart';
import 'package:flutter/material.dart';

class CategoryListCard extends StatelessWidget {
  const CategoryListCard({
    super.key,
    required this.category,
  });

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: AppColors.secondBackground,
      child: SizedBox(
        height: 75,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          title: Text(
            category.name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(category.imageUrl),
            onBackgroundImageError: (exception, stackTrace) {
              // Handle image loading error
            },
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
