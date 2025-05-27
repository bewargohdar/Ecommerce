import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/category/domain/entity/category.dart';

abstract class CategoryRepo {
  Future<Either<String, List<CategoryEntity>>> getCategories();
}
