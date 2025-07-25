import 'package:ecomerce/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ecomerce/features/auth/data/source/auth_firebase_service.dart';
import 'package:ecomerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecomerce/features/auth/domain/usecase/get_ages.dart';
import 'package:ecomerce/features/auth/domain/usecase/get_users.dart';
import 'package:ecomerce/features/auth/domain/usecase/is_logged_in.dart';
import 'package:ecomerce/features/auth/domain/usecase/send_password_reset.dart';
import 'package:ecomerce/features/auth/domain/usecase/signin.dart';
import 'package:ecomerce/features/auth/domain/usecase/signup.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecomerce/service_locator.dart';

void setUpAuthDependencies() {
  sl.registerLazySingleton<AuthFirebaseService>(
    () => AuthFirebaseServiceImpl(),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );

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

  sl.registerFactory<AuthBloc>(() => AuthBloc(
        getAgesUseCase: sl(),
        signinUsecase: sl(),
        signupUsecase: sl(),
        sendPasswordResetEmailUseCase: sl(),
      ));
}
