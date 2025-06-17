import 'package:ecomerce/common/widget/appbar/app_bar.dart';
import 'package:ecomerce/core/config/assets/app_vectors.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/category/presentation/widget/category_list_card.dart';
import 'package:ecomerce/features/product/presentation/widget/product_card.dart';
import 'package:ecomerce/features/search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
    // Fetch initial categories when the page loads
    context.read<SearchBloc>().add(FetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    // Define the border styles once to reuse them
    final OutlineInputBorder roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0), // Rounded radius
      borderSide: const BorderSide(
        color: AppColors.secondBackground, // Border color when not focused
      ),
    );

    final OutlineInputBorder focusedRoundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0), // Rounded radius
      borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.5), // Border color when focused
    );

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
              child: const Icon(Icons.arrow_back_ios_new,
                  size: 15, color: Colors.white),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  filled: true,
                  fillColor: AppColors.secondBackground,
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.white70),
                  // Use the defined borders
                  border: roundedBorder,
                  enabledBorder: roundedBorder,
                  focusedBorder: focusedRoundedBorder,
                  prefixIcon: SvgPicture.asset(
                    AppVectors.search,
                    fit: BoxFit.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      _searchController.clear();
                      // Return to the initial state showing categories
                      context.read<SearchBloc>().add(FetchCategories());
                    },
                  ),
                ),
                onChanged: (query) {
                  // Optional: Add debouncing here if you want live search
                },
                onSubmitted: (query) {
                  // Trigger search when the user submits
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
