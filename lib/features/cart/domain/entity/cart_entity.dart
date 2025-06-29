import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int id;
  final List<ProductCartEntity> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  const CartEntity({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  @override
  List<Object?> get props => [
        id,
        products,
        total,
        discountedTotal,
        userId,
        totalProducts,
        totalQuantity,
      ];
}

class ProductCartEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;

  const ProductCartEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        quantity,
        total,
        discountPercentage,
        discountedTotal,
        thumbnail,
      ];
}
