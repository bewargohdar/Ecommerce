import 'package:ecomerce/features/search/domain/entity/filter_enums.dart';
import 'package:ecomerce/features/search/domain/entity/filter_type.dart';
import 'package:ecomerce/features/search/domain/entity/search_filter.dart';
import 'package:ecomerce/features/search/presentation/bloc/search_bloc.dart';
import 'package:ecomerce/features/search/presentation/widget/filter_chip_button.dart';
import 'package:ecomerce/features/search/presentation/widget/filter_counter_button.dart';
import 'package:ecomerce/features/search/presentation/widget/price_bottom_sheet.dart';
import 'package:ecomerce/features/search/presentation/widget/unified_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final selectedFilters = <FilterType>{};
        if (state.filter.isOnSale == true) {
          selectedFilters.add(FilterType.deals);
        }
        if (state.filter.gender != null) {
          selectedFilters.add(FilterType.gender);
        }
        if (state.filter.sortBy != null) {
          selectedFilters.add(FilterType.sortBy);
        }
        if (state.filter.minPrice != null || state.filter.maxPrice != null) {
          selectedFilters.add(FilterType.price);
        }
        if (state.filter.category != null) {
          selectedFilters.add(FilterType.category);
        }
        if (state.filter.brand != null) {
          selectedFilters.add(FilterType.brand);
        }
        if (state.filter.minRating != null) {
          selectedFilters.add(FilterType.rating);
        }

        return SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FilterCounterButton(
                  count: selectedFilters.length,
                  onTap: () {},
                  isSelected: true,
                ),
                const SizedBox(width: 8),
                ...FilterType.values.map(
                  (filter) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChipButton(
                      label: filter.label,
                      isSelected: selectedFilters.contains(filter),
                      onTap: () =>
                          _showFilterBottomSheet(context, filter, state),
                      hasDropdown: filter.hasDropdown,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFilterBottomSheet(
      BuildContext context, FilterType filter, SearchState state) {
    // Special case for price filter due to different return type
    if (filter == FilterType.price) {
      showModalBottomSheet<Map<String, dynamic>>(
        context: context,
        builder: (context) => PriceBottomSheet(
          initialMinPrice: state.filter.minPrice,
          initialMaxPrice: state.filter.maxPrice,
        ),
      ).then((value) {
        if (value != null) {
          final newFilter = state.filter.copyWith(
            minPrice: () => value['min'],
            maxPrice: () => value['max'],
          );
          context.read<SearchBloc>().add(FilterChanged(newFilter));
        }
      });
      return;
    }

    // For all other filter types, use the unified bottom sheet
    dynamic initialValue;
    switch (filter) {
      case FilterType.deals:
        initialValue = state.filter.isOnSale;
        break;
      case FilterType.gender:
        initialValue = state.filter.gender;
        break;
      case FilterType.sortBy:
        initialValue = state.filter.sortBy;
        break;
      case FilterType.category:
        initialValue = state.filter.category;
        break;
      case FilterType.brand:
        initialValue = state.filter.brand;
        break;
      case FilterType.rating:
        initialValue = state.filter.minRating;
        break;
      case FilterType.price:
        // Already handled above
        break;
    }

    showModalBottomSheet<dynamic>(
      context: context,
      builder: (context) => UnifiedFilterBottomSheet(
        filterType: filter,
        initialValue: initialValue,
        category: state.filter.category, // Only used for brand filter
      ),
    ).then((value) {
      if (value != null || value == null) {
        // Handle both value changes and clearing
        SearchFilter newFilter;
        switch (filter) {
          case FilterType.deals:
            newFilter = state.filter.copyWith(isOnSale: () => value);
            break;
          case FilterType.gender:
            // Handle the string to enum conversion
            if (value is String) {
              Gender? gender;
              if (value == 'men')
                gender = Gender.men;
              else if (value == 'women')
                gender = Gender.women;
              else if (value == 'kids') gender = Gender.kids;

              newFilter = state.filter.copyWith(gender: () => gender);
            } else {
              newFilter = state.filter.copyWith(gender: () => value);
            }
            break;
          case FilterType.sortBy:
            // Handle the string to enum conversion
            if (value is String) {
              SortBy? sortBy;
              if (value == 'recommended')
                sortBy = SortBy.recommended;
              else if (value == 'newest')
                sortBy = SortBy.newest;
              else if (value == 'lowestPrice')
                sortBy = SortBy.lowestPrice;
              else if (value == 'highestPrice') sortBy = SortBy.highestPrice;

              newFilter = state.filter.copyWith(sortBy: () => sortBy);
            } else {
              newFilter = state.filter.copyWith(sortBy: () => value);
            }
            break;
          case FilterType.category:
            newFilter = state.filter.copyWith(category: () => value);
            break;
          case FilterType.brand:
            newFilter = state.filter.copyWith(brand: () => value);
            break;
          case FilterType.rating:
            newFilter = state.filter.copyWith(minRating: () => value);
            break;
          case FilterType.price:
            // Already handled above
            return;
        }
        context.read<SearchBloc>().add(FilterChanged(newFilter));
      }
    });
  }
}
