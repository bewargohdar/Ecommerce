import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/auth/data/models/user.dart';
import 'package:ecomerce/features/category/domain/repository/category_repo.dart';
import 'package:ecomerce/service_locator.dart';

class CategoryRepoImpl extends CategoryRepo {
  @override
  Future<Either> getCategories() async {
    var categories = await sl<CategoryRepo>().getCategories();

    return categories.fold((error) => Left(error),
        (data) => Right(UserModel.fromMap(data).toEntity()));
  }
}
