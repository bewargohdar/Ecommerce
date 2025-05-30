part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProductsByCategoryEvent extends ProductEvent {
  final String categorySlug;

  FetchProductsByCategoryEvent(this.categorySlug);
}
