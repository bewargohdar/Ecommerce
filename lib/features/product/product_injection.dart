import 'package:dio/dio.dart';
import 'package:ecomerce/features/product/data/repository/product_repository_impl.dart';
import 'package:ecomerce/features/product/data/source/product_api_service.dart';
import 'package:ecomerce/features/product/domain/repository/product_repo.dart';
import 'package:ecomerce/features/product/domain/usecase/get_product_by_category.dart';
import 'package:ecomerce/features/product/domain/usecase/get_single_product.dart';
import 'package:ecomerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecomerce/service_locator.dart';

void setUpProductDependencies() {
  sl.registerLazySingleton<ProductApiService>(
    () => ProductApiServiceImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl<ProductApiService>()),
  );

  sl.registerLazySingleton<GetProductsByCategory>(
    () => GetProductsByCategory(sl<ProductRepository>()),
  );

  sl.registerLazySingleton<GetSingleProduct>(
    () => GetSingleProduct(sl<ProductRepository>()),
  );

  sl.registerFactory<ProductBloc>(
    () => ProductBloc(
      sl<GetProductsByCategory>(),
      sl<GetSingleProduct>(),
    ),
  );
}
