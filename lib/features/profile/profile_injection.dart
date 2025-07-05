import 'package:ecomerce/features/profile/data/data_source/profile_api_service.dart';
import 'package:ecomerce/features/profile/data/repository/profile_repository_impl.dart';
import 'package:ecomerce/features/profile/domain/repository/profile_repo.dart';
import 'package:ecomerce/features/profile/domain/usecase/get_single_user.dart';
import 'package:ecomerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecomerce/service_locator.dart';

void setUpProfileDependencies() {
  sl.registerLazySingleton<ProfileApiService>(
    () => ProfileApiService(sl()),
  );

  sl.registerLazySingleton<ProfileRepo>(() => ProfileRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetSingleUser(sl()));

  sl.registerLazySingleton<ProfileBloc>(() => ProfileBloc(getSingleUser: sl()));
}
