import 'package:ecomerce/features/cart/domain/entity/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CartModel extends CartEntity {
  @override
  final List<ProductCartModel> products;

  const CartModel({
    required super.id,
    required this.products,
    required super.total,
    required super.discountedTotal,
    required super.userId,
    required super.totalProducts,
    required super.totalQuantity,
  }) : super(products: products);

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}

@JsonSerializable()
class ProductCartModel extends ProductCartEntity {
  const ProductCartModel({
    required super.id,
    required super.title,
    required super.price,
    required super.quantity,
    required super.total,
    required super.discountPercentage,
    required super.discountedTotal,
    required super.thumbnail,
  });

  factory ProductCartModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCartModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCartModelToJson(this);
}
