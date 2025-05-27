import 'package:ecomerce/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ecomerce/features/auth/data/source/auth_firebase_service.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/features/auth/domain/usecase/get_ages.dart';
import 'package:ecomerce/features/auth/domain/usecase/is_logged_in.dart';
import 'package:ecomerce/features/auth/domain/usecase/send_password_reset.dart';
import 'package:ecomerce/features/auth/domain/usecase/signin.dart';
import 'package:ecomerce/features/auth/domain/usecase/signup.dart';
import 'package:ecomerce/features/category/data/repository/category_repo_impl.dart';
import 'package:ecomerce/features/category/data/source/category_api_service.dart';
import 'package:ecomerce/features/category/domain/repository/category_repo.dart';
import 'package:ecomerce/features/category/domain/usecase/get_categories.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/domain/usecase/get_users.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Using lazy singletons for better performance
  // These will be created only when first accessed

  //services
  sl.registerLazySingleton<AuthFirebaseService>(
    () => AuthFirebaseServiceImpl(),
  );
  sl.registerLazySingleton<CategoryApiService>(
    () => CategoryApiServiceImpl(),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );

  // usecases - these are lazy loaded for better startup performance
  sl.registerLazySingleton<SignupUsecase>(
    () => SignupUsecase(),
  );
  sl.registerLazySingleton<GetAgesUseCase>(
    () => GetAgesUseCase(),
  );
  sl.registerLazySingleton<SigninUsecase>(
    () => SigninUsecase(),
  );
  sl.registerLazySingleton<SendPasswordResetEmailUseCase>(
    () => SendPasswordResetEmailUseCase(),
  );
  sl.registerLazySingleton<IsLoggedInUseCase>(
    () => IsLoggedInUseCase(),
  );
  sl.registerLazySingleton<GetUsers>(
    () => GetUsers(),
  );

  // categories
  sl.registerLazySingleton<CategoryRepo>(
    () => CategoryRepoImpl(sl<CategoryApiService>()),
  );
  sl.registerLazySingleton<GetCategories>(
    () => GetCategories(sl<CategoryRepo>()),
  );
}
