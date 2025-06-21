import 'package:bloc/bloc.dart';
import 'package:ecomerce/features/category/domain/entity/category.dart';
import 'package:ecomerce/features/category/domain/usecase/get_categories.dart';
import 'package:ecomerce/features/search/domain/entity/search_filter.dart';
import 'package:ecomerce/features/search/domain/entity/search_response.dart';
import 'package:ecomerce/features/search/domain/usecase/search_products.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductsUseCase _searchProductsUseCase;
  final GetCategories _getCategoriesUseCase;

  SearchBloc(this._searchProductsUseCase, this._getCategoriesUseCase)
      : super(const SearchState()) {
    on<FetchCategories>(_onFetchCategories);
    on<SearchTermChanged>(_onSearchTermChanged);
    on<FilterChanged>(_onFilterChanged);
    on<SearchSubmitted>(_onSearchSubmitted);
  }

  void _onFetchCategories(
      FetchCategories event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: SearchStatus.loading));
    final result = await _getCategoriesUseCase.call();
    result.fold(
      (failure) => emit(state.copyWith(
          status: SearchStatus.error, errorMessage: failure.toString())),
      (categories) => emit(state.copyWith(
          status: SearchStatus.categoriesLoaded, categories: categories)),
    );
  }

  void _onSearchTermChanged(
      SearchTermChanged event, Emitter<SearchState> emit) {
    emit(state.copyWith(
        filter: state.filter.copyWith(query: () => event.term),
        status: SearchStatus.initial));
  }

  void _onFilterChanged(FilterChanged event, Emitter<SearchState> emit) {
    emit(state.copyWith(filter: event.filter, status: SearchStatus.initial));
    add(SearchSubmitted());
  }

  void _onSearchSubmitted(
      SearchSubmitted event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: SearchStatus.loading));
    final result = await _searchProductsUseCase.call(params: state.filter);
    result.fold(
      (failure) => emit(state.copyWith(
          status: SearchStatus.error, errorMessage: failure.toString())),
      (products) =>
          emit(state.copyWith(status: SearchStatus.loaded, products: products)),
    );
  }
}
