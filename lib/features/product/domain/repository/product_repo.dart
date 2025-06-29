import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/error/failure.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:ecomerce/features/product/domain/entity/product_detail_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      String categorySlug);
  Future<Either<Failure, ProductDetailEntity>> getProductDetail(int id);
}
