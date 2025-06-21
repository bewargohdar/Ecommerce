enum FilterType {
  deals,
  price,
  sortBy,
  gender,
  category,
  brand,
  rating,
}

extension FilterTypeExtension on FilterType {
  String get label {
    switch (this) {
      case FilterType.deals:
        return 'Deals';
      case FilterType.price:
        return 'Price';
      case FilterType.sortBy:
        return 'Sort by';
      case FilterType.gender:
        return 'Gender';
      case FilterType.category:
        return 'Category';
      case FilterType.brand:
        return 'Brand';
      case FilterType.rating:
        return 'Rating';
    }
  }

  bool get hasDropdown {
    switch (this) {
      case FilterType.deals:
      case FilterType.price:
      case FilterType.sortBy:
      case FilterType.gender:
      case FilterType.category:
      case FilterType.brand:
      case FilterType.rating:
        return true;
    }
  }
}
