import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/cart/data/source/cart_api_service.dart';
import 'package:ecomerce/features/cart/domain/entity/cart_entity.dart';
import 'package:ecomerce/features/cart/domain/repository/cart_repo.dart';

class CartRepoImpl extends CartRepo {
  final CartApiService _cartApiService;
  CartRepoImpl(this._cartApiService);
  @override
  Future<Either<String, CartEntity>> getCart() async {
    try {
      final result = await _cartApiService.getCart();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
