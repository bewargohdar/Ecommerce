import 'package:ecomerce/common/widget/appbar/search_app_bar.dart';
import 'package:ecomerce/core/config/assets/app_vectors.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/category/presentation/widget/category_list_card.dart';
import 'package:ecomerce/features/product/presentation/widget/product_card.dart';
import 'package:ecomerce/features/search/presentation/bloc/search_bloc.dart';
import 'package:ecomerce/features/search/presentation/widget/filter_bar.dart';
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
    context.read<SearchBloc>().add(FetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SearchAppBar(
        searchController: _searchController,
        hideBackButton: false,
        autofocus: true,
        onClearSearch: () {
          _searchController.clear();
          context.read<SearchBloc>().add(FetchCategories());
        },
        onSubmitted: (query) {
          if (query.isNotEmpty) {
            context.read<SearchBloc>().add(SearchProducts(query));
          }
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const FilterBar(),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                }

                if (state is SearchError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            size: 60, color: Colors.red[300]),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () =>
                              context.read<SearchBloc>().add(FetchCategories()),
                          child: const Text('Go Back to Categories'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is SearchProductsLoaded) {
                  if (state.products.products!.isEmpty) {
                    return _buildEmptyResultsView();
                  }
                  return _buildProductsGrid(state);
                }

                if (state is SearchCategoriesLoaded) {
                  return _buildCategoriesView(state);
                }

                // Initial state before anything is loaded
                return const Center(
                  child: Text(
                    'Start typing to search for products.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyResultsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: const [
                AppColors.primary,
                Color(0xCCE95D35)
              ], // Using hex code for opacity
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: SvgPicture.asset(
            AppVectors.notFound,
            height: 200,
            width: 200,
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "Sorry, we couldn't find any matching result for your Search.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextButton.icon(
          onPressed: () {
            _searchController.clear();
            context.read<SearchBloc>().add(FetchCategories());
          },
          icon: const Icon(Icons.refresh, color: AppColors.primary),
          label: const Text(
            'Browse Categories',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildProductsGrid(SearchProductsLoaded state) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: state.products.products!.length,
      itemBuilder: (context, index) {
        final product = state.products.products![index];
        return ProductCard(product: product);
      },
    );
  }

  Widget _buildCategoriesView(SearchCategoriesLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Shop by Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
