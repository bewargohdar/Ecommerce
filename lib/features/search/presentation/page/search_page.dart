import 'package:ecomerce/common/widget/appbar/app_bar.dart';
import 'package:ecomerce/common/widget/search.dart';

import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/category/presentation/widget/category_list_card.dart';
import 'package:ecomerce/features/product/presentation/widget/product_card.dart';
import 'package:ecomerce/features/search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(FetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: BasicAppbar(
        hideBack: true,
        backgroundColor: AppColors.background,
        leadingWidth: 60, // Control back button width
        titleSpacing: 8,
        // Use a flexible title to manage spacing and alignment
        title: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: AppColors.secondBackground,
                  borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new,
                    size: 15, color: Colors.white),
              ),
            ),
            SizedBox(
              width: 327,
              height: 50,
              child: SearchField(
                controller: _searchController,
                autofocus: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    _searchController.clear();
                    context.read<SearchBloc>().add(FetchCategories());
                  },
                ),
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    context.read<SearchBloc>().add(SearchProducts(query));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SearchError) {
            return Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.white)));
          }
          if (state is SearchProductsLoaded) {
            // Handle case where search yields no results
            if (state.products.isEmpty) {
              return const Center(
                child: Text(
                  'No products found.',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductCard(product: product);
              },
            );
          }
          if (state is SearchCategoriesLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Shop by Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    // Limiting to 5 as in the original code
                    itemCount: 5.clamp(0, state.categories.length),
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return CategoryListCard(category: category);
                    },
                  ),
                ),
              ],
            );
          }
          // Initial state before anything is loaded
          return const Center(
            child: Text(
              'Start typing to search for products.',
              style: TextStyle(color: Colors.white70),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
