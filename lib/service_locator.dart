import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:ecomerce/features/auth/auth_injection.dart';
import 'package:ecomerce/features/category/category_injection.dart';
import 'package:ecomerce/features/product/product_injection.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio dependency
  sl.registerLazySingleton<Dio>(() => Dio());

  // Feature dependencies
  setUpAuthDependencies();
  setUpCategoryDependencies();
  setUpProductDependencies();
}
