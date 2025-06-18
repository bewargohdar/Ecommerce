import 'package:bloc/bloc.dart';
import 'package:ecomerce/features/category/domain/entity/category.dart';
import 'package:ecomerce/features/category/domain/usecase/get_categories.dart';
import 'package:ecomerce/features/search/domain/entity/search_response.dart';
import 'package:ecomerce/features/search/domain/usecase/search_products.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetCategories _getCategoriesUseCase;
  final SearchProductsUseCase _searchProductsUseCase;

  SearchBloc(this._getCategoriesUseCase, this._searchProductsUseCase)
      : super(SearchInitial()) {
    on<FetchCategories>(_onFetchCategories);
    on<SearchProducts>(_onSearchProducts);
  }

  void _onFetchCategories(
      FetchCategories event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final result = await _getCategoriesUseCase.call();
    result.fold(
      (failure) => emit(SearchError(failure.toString())),
      (categories) => emit(SearchCategoriesLoaded(categories)),
    );
  }

  void _onSearchProducts(
      SearchProducts event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final result = await _searchProductsUseCase.call(params: event.query);
    result.fold(
      (failure) => emit(SearchError(failure.toString())),
      (products) => emit(SearchProductsLoaded(products)),
    );
  }
}
