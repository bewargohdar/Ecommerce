import 'package:ecomerce/features/search/domain/entity/filter_type.dart';
import 'package:ecomerce/features/search/presentation/widget/filter_list_item.dart';
import 'package:ecomerce/features/search/presentation/widget/price_bottom_sheet.dart';
import 'package:flutter/material.dart';

class UnifiedFilterBottomSheet extends StatelessWidget {
  final FilterType filterType;
  final dynamic initialValue;
  final String? category; // Only used for brand filter

  const UnifiedFilterBottomSheet({
    Key? key,
    required this.filterType,
    this.initialValue,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Special case for price filter as it has a different UI
    if (filterType == FilterType.price) {
      return PriceBottomSheet(
        initialMinPrice: initialValue is Map ? initialValue['min'] : null,
        initialMaxPrice: initialValue is Map ? initialValue['max'] : null,
      );
    }

    // For all other filter types that use a list UI
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, null);
                },
                child:
                    const Text('Clear', style: TextStyle(color: Colors.white)),
              ),
              Text(
                filterType.label,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Flexible(
            child: _buildFilterContent(context),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFilterContent(BuildContext context) {
    switch (filterType) {
      case FilterType.category:
        final categories = [
          'beauty',
          'fragrances',
          'furniture',
          'groceries',
        ];
        return _buildListContent(
          context,
          categories
              .map((category) => _FilterOption(
                    label: category.substring(0, 1).toUpperCase() +
                        category.substring(1),
                    value: category,
                  ))
              .toList(),
        );

      case FilterType.brand:
        final Map<String, List<String>> brandsByCategory = {
          'beauty': [
            'Essence',
            'Glamour Beauty',
            'Velvet Touch',
            'Chic Cosmetics',
            'Nail Couture',
          ],
          'fragrances': [
            'Calvin Klein',
            'Chanel',
            'Dior',
            'Dolce & Gabbana',
            'Gucci',
          ],
          'furniture': [
            'Annibale Colombo',
            'Furniture Co.',
            'Knoll',
            'Bath Trends',
          ],
          'groceries': [
            'Grocery Brands',
          ],
        };

        final List<String> brandsToShow = category != null
            ? brandsByCategory[category] ?? []
            : brandsByCategory.values.expand((brands) => brands).toList();

        return _buildListContent(
          context,
          brandsToShow
              .map((brand) => _FilterOption(label: brand, value: brand))
              .toList(),
        );

      case FilterType.gender:
        return _buildListContent(
          context,
          [
            _FilterOption(label: 'Men', value: 'men'),
            _FilterOption(label: 'Women', value: 'women'),
            _FilterOption(label: 'Kids', value: 'kids'),
          ],
        );

      case FilterType.sortBy:
        return _buildListContent(
          context,
          [
            _FilterOption(label: 'Recommended', value: 'recommended'),
            _FilterOption(label: 'Newest', value: 'newest'),
            _FilterOption(
                label: 'Lowest - Highest Price', value: 'lowestPrice'),
            _FilterOption(
                label: 'Highest - Lowest Price', value: 'highestPrice'),
          ],
        );

      case FilterType.rating:
        final ratingValues = [4.0, 3.0, 2.0, 1.0];
        return _buildListContent(
          context,
          ratingValues
              .map((rating) => _FilterOption(
                    label: '${rating.toInt()}+ Stars',
                    value: rating,
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        rating.toInt(),
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        );

      case FilterType.deals:
        return _buildListContent(
          context,
          [
            _FilterOption(label: 'On Sale', value: true),
            _FilterOption(label: 'Free Shipping Eligible', value: false),
          ],
        );

      default:
        return const Center(
            child: Text('Filter not implemented',
                style: TextStyle(color: Colors.white)));
    }
  }

  Widget _buildListContent(BuildContext context, List<_FilterOption> options) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: options.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final option = options[index];
        return FilterListItem(
          label: option.label,
          isSelected: _isSelected(option.value),
          onTap: () {
            Navigator.pop(context, option.value);
          },
          leading: option.leading,
        );
      },
    );
  }

  bool _isSelected(dynamic value) {
    if (initialValue == null) return false;

    // Handle different filter types differently
    switch (filterType) {
      case FilterType.gender:
        return initialValue.toString().split('.').last == value;
      case FilterType.sortBy:
        return initialValue.toString().split('.').last == value;
      default:
        return initialValue == value;
    }
  }
}

class _FilterOption {
  final String label;
  final dynamic value;
  final Widget? leading;

  const _FilterOption({
    required this.label,
    required this.value,
    this.leading,
  });
}
