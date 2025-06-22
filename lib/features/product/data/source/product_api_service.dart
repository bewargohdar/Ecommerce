import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecomerce/core/constant/const.dart';
import 'package:ecomerce/features/product/data/models/product_model.dart';

abstract class ProductApiService {
  Future<Either<String, List<ProductModel>>> getProductsByCategory(
      String categorySlug);
}

class ProductApiServiceImpl implements ProductApiService {
  final Dio _dio;

  ProductApiServiceImpl(this._dio);

  @override
  Future<Either<String, List<ProductModel>>> getProductsByCategory(
      String categorySlug) async {
    try {
      final response =
          await _dio.get('$baseUrl/products/category/$categorySlug');
      print(response.data);
      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data.containsKey('products')) {
          final productsData = data['products'] as List<dynamic>;

          return Right(productsData
              .map((product) =>
                  ProductModel.fromJson(product as Map<String, dynamic>))
              .toList());
        } else {
          return const Left('Unexpected API response format');
        }
      } else {
        return Left(
            'Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Network error: ${e.toString()}');
    }
  }
}
