import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/category/domain/entity/category.dart';
import 'package:ecomerce/features/category/domain/repository/category_repo.dart';

class GetCategories
    extends Usecase<Either<String, List<CategoryEntity>>, void> {
  final CategoryRepo categoryRepo;

  GetCategories(this.categoryRepo);

  @override
  Future<Either<String, List<CategoryEntity>>> call({void params}) {
    return categoryRepo.getCategories();
  }
}
