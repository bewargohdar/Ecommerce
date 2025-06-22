import 'package:equatable/equatable.dart';

import '../../../product/domain/entity/product.dart';

class HomeEntity extends Equatable {
  final List<ProductEntity> topSellingProducts;
  final List<ProductEntity> newArrivals;

  const HomeEntity(
      {required this.topSellingProducts, required this.newArrivals});

  @override
  List<Object?> get props => [topSellingProducts, newArrivals];
}
