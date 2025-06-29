part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductsByCategoryEvent extends ProductEvent {
  final String categorySlug;

  const FetchProductsByCategoryEvent(this.categorySlug);

  @override
  List<Object> get props => [categorySlug];
}

class GetProductDetailEvent extends ProductEvent {
  final int id;

  const GetProductDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
