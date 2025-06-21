import 'package:ecomerce/features/auth/domain/usecase/is_logged_in.dart';
import 'package:ecomerce/features/splash/bloc/splash_bloc.dart';
import 'package:ecomerce/service_locator.dart';

void setUpSplashDependencies() {
  sl.registerFactory<SplashBloc>(
    () => SplashBloc(isLoggedInUseCase: sl<IsLoggedInUseCase>()),
  );
}
