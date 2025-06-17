import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecomerce/features/category/data/model/category_model.dart';
import 'package:ecomerce/features/category/data/source/category_api_service.dart';
import 'package:ecomerce/features/category/domain/repository/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final CategoryApiService _categoryApiService;
  CategoryRepoImpl(this._categoryApiService);
  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final categoryModels = await _categoryApiService.getCategories();
      return Right(categoryModels);
    } on DioException catch (e) {
      return Left(e.message ?? 'An unknown error occurred');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
