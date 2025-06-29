import 'package:dio/dio.dart';
import 'package:ecomerce/core/constant/const.dart';
import 'package:ecomerce/features/cart/data/model/cart_model.dart';
import 'package:retrofit/retrofit.dart';
part 'cart_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CartApiService {
  factory CartApiService(Dio dio) = _CartApiService;

  @GET('/carts/1')
  Future<CartModel> getCart();
}
