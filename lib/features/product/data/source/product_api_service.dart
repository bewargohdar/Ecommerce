import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecomerce/core/constant/const.dart';
import 'package:ecomerce/features/product/data/models/product_model.dart';
import 'package:retrofit/retrofit.dart';

@RestApi(baseUrl: baseUrl)
abstract class ProductApiService {
  @GET('/products/category/{categorySlug}')
  Future<Either<String, List<ProductModel>>> getProductsByCategory(
      @Path('categorySlug') String categorySlug);

  @GET('/products')
  Future<Either<String, List<ProductModel>>> getAllProducts();
}

class ProductApiServiceImpl implements ProductApiService {
  final Dio _dio;

  ProductApiServiceImpl(this._dio);

  @override
  Future<Either<String, List<ProductModel>>> getProductsByCategory(
      String categorySlug) async {
    try {
      final response = await _dio.get('/products/category/$categorySlug');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final products =
            data.map((item) => ProductModel.fromJson(item)).toList();
        return Right(products);
      } else {
        return const Left('Failed to load products');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getAllProducts() async {
    try {
      final response = await _dio.get('/products');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'];
        final products =
            data.map((item) => ProductModel.fromJson(item)).toList();
        return Right(products);
      } else {
        return const Left('Failed to load products');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
