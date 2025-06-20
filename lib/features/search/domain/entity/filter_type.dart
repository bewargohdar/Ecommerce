enum FilterType {
  onSale,
  price,
  sortBy,
  men,
}

extension FilterTypeExtension on FilterType {
  String get label {
    switch (this) {
      case FilterType.onSale:
        return 'On Sale';
      case FilterType.price:
        return 'Price';
      case FilterType.sortBy:
        return 'Sort by';
      case FilterType.men:
        return 'Men';
    }
  }

  bool get hasDropdown {
    switch (this) {
      case FilterType.onSale:
        return false;
      case FilterType.price:
      case FilterType.sortBy:
      case FilterType.men:
        return true;
    }
  }
}
