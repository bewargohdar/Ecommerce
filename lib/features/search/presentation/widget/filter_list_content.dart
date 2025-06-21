import 'package:ecomerce/features/search/presentation/widget/filter_list_item.dart';
import 'package:flutter/material.dart';

typedef ValueCallback<T> = void Function(T value);

class FilterListContent<T> extends StatelessWidget {
  final List<FilterOption<T>> options;
  final T? selectedValue;
  final ValueCallback<T> onSelect;

  const FilterListContent({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: options.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final option = options[index];
        return FilterListItem(
          label: option.label,
          isSelected: selectedValue == option.value,
          onTap: () {
            onSelect(option.value);
            Navigator.pop(context, option.value);
          },
          leading: option.leading,
        );
      },
    );
  }
}

class FilterOption<T> {
  final String label;
  final T value;
  final Widget? leading;

  const FilterOption({
    required this.label,
    required this.value,
    this.leading,
  });
}
