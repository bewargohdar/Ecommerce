import 'package:ecomerce/features/search/presentation/widget/filter_chip_button.dart';
import 'package:ecomerce/features/search/presentation/widget/filter_counter_button.dart';
import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({Key? key}) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  final Set<String> _selectedFilters = {'Price', 'Men'};
  final int _activeFilterCount = 2;

  void _toggleFilter(String filterName) {
    setState(() {
      if (_selectedFilters.contains(filterName)) {
        _selectedFilters.remove(filterName);
      } else {
        _selectedFilters.add(filterName);
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
            FilterChipButton(
              label: 'On Sale',
              isSelected: _selectedFilters.contains('On Sale'),
              onTap: () => _toggleFilter('On Sale'),
            ),
            FilterChipButton(
              label: 'Price',
              hasDropdown: true,
              isSelected: _selectedFilters.contains('Price'),
              onTap: () => _toggleFilter('Price'),
            ),
            FilterChipButton(
              label: 'Sort by',
              hasDropdown: true,
              isSelected: _selectedFilters.contains('Sort by'),
              onTap: () => _toggleFilter('Sort by'),
            ),
            FilterChipButton(
              label: 'Men',
              hasDropdown: true,
              isSelected: _selectedFilters.contains('Men'),
              onTap: () => _toggleFilter('Men'),
            ),
          ],
        ),
      ),
    );
  }
}
