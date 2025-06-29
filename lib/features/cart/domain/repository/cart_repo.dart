import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/cart/domain/entity/cart_entity.dart';

abstract class CartRepo {
  Future<Either<String, CartEntity>> getCart();
}
