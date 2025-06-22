import 'package:ecomerce/features/auth/domain/usecase/get_users.dart';
import 'package:ecomerce/features/category/domain/usecase/get_categories.dart';
import 'package:ecomerce/features/home/data/repository/home_repository_impl.dart';
import 'package:ecomerce/features/home/data/source/home_api_service.dart';
import 'package:ecomerce/features/home/domain/repository/home_repository.dart';
import 'package:ecomerce/features/home/domain/usecase/get_home_data.dart';
import 'package:ecomerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecomerce/service_locator.dart';
import 'package:dio/dio.dart';

void setUpHomeDependencies() {
  sl.registerFactory<HomeApiService>(() => HomeApiService(sl<Dio>()));
  sl.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(homeApiService: sl<HomeApiService>()));
  sl.registerFactory<GetHomeData>(
      () => GetHomeData(repository: sl<HomeRepository>()));
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
        getHomeData: sl<GetHomeData>(),
        getCategories: sl<GetCategories>(),
        getUsers: sl<GetUsers>()),
  );
}
