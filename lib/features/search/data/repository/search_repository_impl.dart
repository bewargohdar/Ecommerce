import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/search/data/source/search_api_service.dart';
import 'package:ecomerce/features/search/domain/entity/search_response.dart';
import 'package:ecomerce/features/search/domain/repository/search_repo.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchApiService _searchApiService;

  SearchRepositoryImpl(this._searchApiService);

  @override
  Future<Either<String, GeneralSearchResponseEntity>> searchProducts(
      String query) async {
    try {
      final result = await _searchApiService.searchProductsByName(query);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
