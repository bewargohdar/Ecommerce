import 'package:dio/dio.dart';
import 'package:ecomerce/core/constant/const.dart';
import 'package:ecomerce/features/category/data/model/category_model.dart';
import 'package:retrofit/retrofit.dart';
part 'category_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CategoryApiService {
  factory CategoryApiService(Dio dio) = _CategoryApiService;

  @GET('/products/categories')
  Future<List<CategoryModel>> getCategories();
}
