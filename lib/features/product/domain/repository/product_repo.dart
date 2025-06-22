import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/error/failure.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      String categorySlug);
}
