import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';

abstract class ProductRepository {
  Future<Either<String, List<ProductEntity>>> getProductsByCategory(
      String categorySlug);
}
