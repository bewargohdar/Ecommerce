import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/error/failure.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:ecomerce/features/product/domain/repository/product_repo.dart';

class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(String categorySlug) {
    return repository.getProductsByCategory(categorySlug);
  }
}
