import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecomerce/core/constant/const.dart';
import 'package:ecomerce/features/category/data/model/category_model.dart';

abstract class CategoryApiService {
  Future<Either> getCategories();
}

class CategoryApiServiceImpl implements CategoryApiService {
  final dio = Dio();

  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final response = await dio.get('$baseUrl/products/categories');

      if (response.statusCode == 200) {
        final data = response.data;

        List<dynamic> categoriesData;

        // Check if data is directly a list or wrapped in an object
        if (data is List) {
          categoriesData = data;
        } else if (data is Map<String, dynamic> &&
            data.containsKey('categories')) {
          categoriesData = data['categories'] as List;
        } else {
          // Handle other possible response structures
          return const Left('Unexpected API response format');
        }

        return Right(categoriesData
            .map((category) =>
                CategoryModel.fromJson(category as Map<String, dynamic>))
            .toList());
      } else {
        return Left(
            'Failed to load categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Network error: ${e.toString()}');
    }
  }
}
