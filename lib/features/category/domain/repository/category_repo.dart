import 'package:dartz/dartz.dart';

abstract class CategoryRepo {
  Future<Either> getCategories();
}
