import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/search/domain/entity/search_response.dart';

abstract class SearchRepository {
  Future<Either<String, GeneralSearchResponseEntity>> searchProducts(
      String query);
}
