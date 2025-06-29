import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/error/failure.dart';

import 'package:ecomerce/features/product/domain/entity/product_detail_entity.dart';
import 'package:ecomerce/features/product/domain/repository/product_repo.dart';

class GetSingleProduct {
  final ProductRepository productRepository;

  GetSingleProduct(this.productRepository);

  Future<Either<Failure, ProductDetailEntity>> call(int params) async {
    return await productRepository.getProductDetail(params);
  }
}
