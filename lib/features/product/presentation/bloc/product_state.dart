part of 'product_bloc.dart';

@immutable
class ProductState extends Equatable {
  final List<ProductEntity> products;
  final ProductDetailEntity? productDetail;
  final bool isLoading;
  final String? error;

  const ProductState({
    this.products = const [],
    this.productDetail,
    this.isLoading = false,
    this.error,
  });

  ProductState copyWith({
    List<ProductEntity>? products,
    ProductDetailEntity? productDetail,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      productDetail: productDetail ?? this.productDetail,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [products, productDetail, isLoading, error];
}
