part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchCategoriesLoaded extends SearchState {
  final List<CategoryEntity> categories;

  const SearchCategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class SearchProductsLoaded extends SearchState {
  final GeneralSearchResponseEntity products;

  const SearchProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
