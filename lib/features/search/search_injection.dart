import 'package:ecomerce/features/search/data/source/search_api_service.dart';
import 'package:ecomerce/features/search/data/repository/search_repository_impl.dart';
import 'package:ecomerce/features/search/domain/repository/search_repo.dart';
import 'package:ecomerce/features/search/domain/usecase/search_products.dart';
import 'package:ecomerce/features/search/presentation/bloc/search_bloc.dart';
import 'package:ecomerce/service_locator.dart';

void setUpSearchDependencies() {
  // Api services
  sl.registerLazySingleton<SearchApiService>(
    () => SearchApiService(sl()),
  );

  // Repository
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(sl()));

  // Usecases
  sl.registerLazySingleton(() => SearchProductsUseCase(sl()));

  // BLoC
  sl.registerFactory(() => SearchBloc(sl(), sl()));
}
