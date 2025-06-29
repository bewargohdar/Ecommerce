import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecomerce/core/constant/const.dart';
import 'package:ecomerce/features/product/data/models/product_detail.dart';
import 'package:ecomerce/features/product/data/models/product_model.dart';

abstract class ProductApiService {
  Future<Either<String, List<ProductModel>>> getProductsByCategory(
      String categorySlug);
  Future<Either<String, ProductDetailModel>> getProductDetail(int id);
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

  @override
  Future<Either<String, ProductDetailModel>> getProductDetail(int id) async {
    try {
      final response = await _dio.get('$baseUrl/products/$id');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        return Right(ProductDetailModel.fromJson(data));
      } else {
        return Left(
            'Server Error: Received status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(
          'Server Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
        );
      } else {
        return const Left('Network Error: Please check your connection.');
      }
    } catch (e) {
      return Left('An unexpected error occurred: ${e.toString()}');
    }
  }
}
