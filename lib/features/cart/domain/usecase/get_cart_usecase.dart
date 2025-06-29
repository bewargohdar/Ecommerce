import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/cart/domain/entity/cart_entity.dart';
import 'package:ecomerce/features/cart/domain/repository/cart_repo.dart';

class GetCartUsecase extends Usecase<Either<String, CartEntity>, NoParams> {
  final CartRepo _cartRepo;

  GetCartUsecase(this._cartRepo);
  @override
  Future<Either<String, CartEntity>> call(NoParams params) {
    return _cartRepo.getCart();
  }
}
