import 'package:dio/dio.dart';
import 'package:ecomerce/core/constant/const.dart';

import 'package:ecomerce/features/search/data/models/search_response.dart';
import 'package:retrofit/retrofit.dart';

part 'search_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class SearchApiService {
  factory SearchApiService(Dio dio) = _SearchApiService;

  @GET('/products/search')
  Future<GeneralSearchResponseModel> searchProductsByName(
    @Query('q') String productName, {
    @Query('isOnSale') bool? isOnSale,
    @Query('gender') String? gender,
    @Query('sortBy') String? sortBy,
    @Query('minPrice') int? minPrice,
    @Query('maxPrice') int? maxPrice,
    @Query('category') String? category,
    @Query('brand') String? brand,
    @Query('minRating') double? minRating,
  });
}
