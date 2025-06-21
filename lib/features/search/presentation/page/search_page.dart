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
        onClearSearch: () {
          _searchController.clear();
          context.read<SearchBloc>().add(FetchCategories());
        },
        onSubmitted: (query) {
          context.read<SearchBloc>().add(SearchTermChanged(query));
          context.read<SearchBloc>().add(SearchSubmitted());
        },
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.status == SearchStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state.status == SearchStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () =>
                        context.read<SearchBloc>().add(SearchSubmitted()),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          if (state.status == SearchStatus.categoriesLoaded) {
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final category = state.categories![index];
                      return CategoryListCard(category: category);
                    },
                  ),
                ),
              ],
            );
          }

          if (state.status == SearchStatus.loaded) {
            if (state.products!.products!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppVectors.notFound,
                    height: 200,
                    width: 200,
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
                ],
              );
            }
            return Column(
              children: [
                const SizedBox(height: 8),
                FilterBar(),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: state.products!.products!.length,
                    itemBuilder: (context, index) {
                      final product = state.products!.products![index];
                      return ProductCard(product: product);
                    },
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text(
              'Start typing to search for products.',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
