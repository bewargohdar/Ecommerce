import 'package:bloc/bloc.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:ecomerce/features/product/domain/entity/product_detail_entity.dart';
import 'package:ecomerce/features/product/domain/usecase/get_product_by_category.dart';
import 'package:ecomerce/features/product/domain/usecase/get_single_product.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsByCategory _getProductsByCategory;
  final GetSingleProduct _getSingleProduct;

  ProductBloc(this._getProductsByCategory, this._getSingleProduct)
      : super(const ProductState()) {
    on<FetchProductsByCategoryEvent>(_onFetchProductsByCategory);
    on<GetProductDetailEvent>(_onGetProductDetail);
  }

  Future<void> _onFetchProductsByCategory(
    FetchProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getProductsByCategory(event.categorySlug);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (products) => emit(state.copyWith(isLoading: false, products: products)),
    );
  }

  Future<void> _onGetProductDetail(
    GetProductDetailEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getSingleProduct(event.id);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (product) =>
          emit(state.copyWith(isLoading: false, productDetail: product)),
    );
  }
}
