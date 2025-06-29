import 'package:ecomerce/features/cart/data/repository/cart_repo_impl.dart';
import 'package:ecomerce/features/cart/data/source/cart_api_service.dart';
import 'package:ecomerce/features/cart/domain/repository/cart_repo.dart';
import 'package:ecomerce/features/cart/domain/usecase/get_cart_usecase.dart';
import 'package:ecomerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecomerce/service_locator.dart';

Future<void> setUpCartDependencies() async {
  sl.registerFactory(() => CartBloc(sl()));

  sl.registerLazySingleton(() => GetCartUsecase(sl()));

  sl.registerLazySingleton<CartRepo>(() => CartRepoImpl(sl()));

  sl.registerLazySingleton(() => CartApiService(sl()));
}
