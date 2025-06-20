import 'package:ecomerce/features/search/domain/entity/filter_type.dart';
import 'package:ecomerce/features/search/presentation/widget/filter_chip_button.dart';
import 'package:ecomerce/features/search/presentation/widget/filter_counter_button.dart';
import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  final Set<FilterType> _selectedFilters = {FilterType.price, FilterType.men};
  final int _activeFilterCount = 2;

  void _toggleFilter(FilterType filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterCounterButton(
              count: _activeFilterCount,
              onTap: () {},
              isSelected: true,
            ),
            ...FilterType.values.map(
              (filter) => FilterChipButton(
                label: filter.label,
                isSelected: _selectedFilters.contains(filter),
                onTap: () => _toggleFilter(filter),
                hasDropdown: filter.hasDropdown,
              ),
            )
          ],
        ),
      ),
    );
  }
}
