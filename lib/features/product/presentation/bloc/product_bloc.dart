import 'package:bloc/bloc.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:ecomerce/features/product/domain/usecase/Get_product_by_category.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsByCategory _getProductsByCategory;

  ProductBloc(this._getProductsByCategory) : super(ProductInitial()) {
    on<FetchProductsByCategoryEvent>(_onFetchProductsByCategory);
  }

  Future<void> _onFetchProductsByCategory(
    FetchProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await _getProductsByCategory(event.categorySlug);

    result.fold(
      (failure) => emit(ProductError(failure)),
      (products) => emit(ProductLoaded(products)),
    );
  }
}
