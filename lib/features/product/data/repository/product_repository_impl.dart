import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecomerce/core/error/failure.dart';
import 'package:ecomerce/features/product/data/source/product_api_service.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:ecomerce/features/product/domain/entity/product_detail_entity.dart';
import 'package:ecomerce/features/product/domain/repository/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApiService _productApiService;

  ProductRepositoryImpl(this._productApiService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      String categorySlug) async {
    try {
      final httpResponse =
          await _productApiService.getProductsByCategory(categorySlug);

      // The fold method correctly handles the Either<> result from the service.
      return httpResponse.fold(
        (failure) => Left(ServerFailure(message: failure)),
        (products) => Right(products),
      );
    } on DioException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? "An unknown error occurred"));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductDetailEntity>> getProductDetail(int id) async {
    try {
      final httpResponse = await _productApiService.getProductDetail(id);
      return httpResponse.fold(
        (failure) => Left(ServerFailure(message: failure)),
        (productDetail) => Right(productDetail),
      );
    } on DioException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? "An unknown error occurred"));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
