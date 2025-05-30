import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/category/data/helper/category_image_helper.dart';
import 'package:ecomerce/features/category/domain/entity/category.dart';
import 'package:ecomerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecomerce/features/product/presentation/page/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          onTap: () {
            // Dispatch event to fetch products for this category
            context
                .read<ProductBloc>()
                .add(FetchProductsByCategoryEvent(category.name));

            // Navigate to products page
            AppNavigator.push(
              context,
              ProductsPage(categoryName: category.name),
            );
          },
        ),
      ),
    );
  }
}
