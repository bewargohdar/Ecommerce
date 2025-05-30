import 'package:dio/dio.dart';
import 'package:ecomerce/features/category/data/repository/category_repo_impl.dart';
import 'package:ecomerce/features/category/data/source/category_api_service.dart';
import 'package:ecomerce/features/category/domain/repository/category_repo.dart';
import 'package:ecomerce/features/category/domain/usecase/get_categories.dart';
import 'package:ecomerce/features/category/presentation/bloc/category_bloc.dart';
import 'package:ecomerce/service_locator.dart';

void setUpCategoryDependencies() {
  sl.registerLazySingleton<CategoryApiService>(
    () => CategoryApiServiceImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<CategoryRepo>(
    () => CategoryRepoImpl(sl<CategoryApiService>()),
  );

  sl.registerLazySingleton<GetCategories>(
    () => GetCategories(sl<CategoryRepo>()),
  );

  sl.registerFactory<CategoryBloc>(
    () => CategoryBloc(sl<GetCategories>()),
  );
}
