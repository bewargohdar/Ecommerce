part of 'search_bloc.dart';

enum SearchStatus { initial, loading, loaded, error, categoriesLoaded }

class SearchState extends Equatable {
  final SearchStatus status;
  final GeneralSearchResponseEntity? products;
  final List<CategoryEntity>? categories;
  final String? errorMessage;
  final SearchFilter filter;

  const SearchState({
    this.status = SearchStatus.initial,
    this.products,
    this.categories,
    this.errorMessage,
    this.filter = const SearchFilter(),
  });

  SearchState copyWith({
    SearchStatus? status,
    GeneralSearchResponseEntity? products,
    List<CategoryEntity>? categories,
    String? errorMessage,
    SearchFilter? filter,
  }) {
    return SearchState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props =>
      [status, products, categories, errorMessage, filter];
}
