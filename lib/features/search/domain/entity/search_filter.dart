import 'package:ecomerce/features/search/domain/entity/filter_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class SearchFilter extends Equatable {
  final bool? isOnSale;
  final String? query;
  final Gender? gender;
  final SortBy? sortBy;
  final int? minPrice;
  final int? maxPrice;
  final String? category;
  final String? brand;
  final double? minRating;

  const SearchFilter({
    this.isOnSale,
    this.query,
    this.gender,
    this.sortBy,
    this.minPrice,
    this.maxPrice,
    this.category,
    this.brand,
    this.minRating,
  });

  @override
  List<Object?> get props => [
        isOnSale,
        query,
        gender,
        sortBy,
        minPrice,
        maxPrice,
        category,
        brand,
        minRating,
      ];

  SearchFilter copyWith({
    ValueGetter<bool?>? isOnSale,
    ValueGetter<String?>? query,
    ValueGetter<Gender?>? gender,
    ValueGetter<SortBy?>? sortBy,
    ValueGetter<int?>? minPrice,
    ValueGetter<int?>? maxPrice,
    ValueGetter<String?>? category,
    ValueGetter<String?>? brand,
    ValueGetter<double?>? minRating,
  }) {
    return SearchFilter(
      isOnSale: isOnSale != null ? isOnSale() : this.isOnSale,
      query: query != null ? query() : this.query,
      gender: gender != null ? gender() : this.gender,
      sortBy: sortBy != null ? sortBy() : this.sortBy,
      minPrice: minPrice != null ? minPrice() : this.minPrice,
      maxPrice: maxPrice != null ? maxPrice() : this.maxPrice,
      category: category != null ? category() : this.category,
      brand: brand != null ? brand() : this.brand,
      minRating: minRating != null ? minRating() : this.minRating,
    );
  }
}
