import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/category/domain/repository/category_repo.dart';
import 'package:ecomerce/service_locator.dart';

class GetCategories implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<CategoryRepo>().getCategories();
  }
}
