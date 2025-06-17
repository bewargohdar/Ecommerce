import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';

abstract class SearchRepository {
  Future<Either<String, List<ProductEntity>>> searchProducts(String query);
}
