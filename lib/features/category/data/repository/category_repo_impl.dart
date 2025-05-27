import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/category/data/source/category_api_service.dart';
import 'package:ecomerce/features/category/domain/entity/category.dart';
import 'package:ecomerce/features/category/domain/repository/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final CategoryApiService _categoryApiService;
  CategoryRepoImpl(this._categoryApiService);
  @override
  Future<Either<String, List<CategoryEntity>>> getCategories() async {
    final result = await _categoryApiService.getCategories();

    return result.fold(
      (failure) => Left(failure),
      (categoryModels) {
        // categoryModels is already List<CategoryModel>, so we just need to convert to entities
        final categoryEntities = categoryModels.map<CategoryEntity>((model) {
          return CategoryEntity(
            slug: model.slug,
            name: model.name,
            url: model.url,
          );
        }).toList();
        return Right(categoryEntities);
      },
    );
  }
}
