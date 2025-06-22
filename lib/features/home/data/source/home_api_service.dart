import 'package:dio/dio.dart';
import 'package:ecomerce/core/constant/const.dart';
import 'package:ecomerce/features/search/data/models/search_response.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class HomeApiService {
  factory HomeApiService(Dio dio) = _HomeApiService;
  @GET('/products')
  Future<GeneralSearchResponseModel> getProducts();
}
