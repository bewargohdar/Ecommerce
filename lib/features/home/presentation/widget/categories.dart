import 'package:ecomerce/common/helper/category_image_helper.dart';
import 'package:ecomerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeDataLoaded) {
          // Show loading indicator if categories are loading
          if (state.isLoadingCategories && state.categories == null) {
            return const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          // Show error if there's a categories error
          if (state.categoriesError != null) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Error loading categories: ${state.categoriesError}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          // Show categories if available
          if (state.categories != null) {
            final categories = state.categories!;

            if (categories.isEmpty) {
              return const SizedBox(
                height: 100,
                child: Center(child: Text('No categories available')),
              );
            }

            return SizedBox(
              height: 120,
              child: ListView.separated(
                itemCount: categories.length > 5 ? 5 : categories.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Column(
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
                            color: Colors.black.withValues(alpha: 0.1),
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
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 15),
              ),
            );
          }
        }

        // Handle legacy states for backwards compatibility
        if (state is HomeLoading) {
          return const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeError) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Text(
                'Error loading categories: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (state is CategoriesLoaded) {
          final categories = state.categories;

          if (categories.isEmpty) {
            return const SizedBox(
              height: 100,
              child: Center(child: Text('No categories available')),
            );
          }

          return SizedBox(
            height: 120,
            child: ListView.separated(
              itemCount: categories.length > 5 ? 5 : categories.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final category = categories[index];
                return Column(
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
                          color: Colors.black.withValues(alpha: 0.1),
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
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 15),
            ),
          );
        }

        // Default state - show placeholder
        return const SizedBox(
          height: 100,
          child: Center(
            child: Text('Loading categories...'),
          ),
        );
      },
    );
  }
}
