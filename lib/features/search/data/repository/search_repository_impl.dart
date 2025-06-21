import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/search/data/source/search_api_service.dart';
import 'package:ecomerce/features/search/domain/entity/search_filter.dart';
import 'package:ecomerce/features/search/domain/entity/search_response.dart';
import 'package:ecomerce/features/search/domain/repository/search_repo.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchApiService _searchApiService;

  SearchRepositoryImpl(this._searchApiService);

  @override
  Future<Either<String, GeneralSearchResponseEntity>> searchProducts(
      SearchFilter filter) async {
    try {
      final result = await _searchApiService.searchProductsByName(
        filter.query ?? '',
        isOnSale: filter.isOnSale,
        gender: filter.gender?.toString().split('.').last,
        sortBy: filter.sortBy?.toString().split('.').last,
        minPrice: filter.minPrice,
        maxPrice: filter.maxPrice,
        category: filter.category,
        brand: filter.brand,
        minRating: filter.minRating,
      );
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
