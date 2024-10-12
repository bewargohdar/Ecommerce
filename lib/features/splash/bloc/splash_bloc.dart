import 'package:ecomerce/features/auth/domain/usecase/is_logged_in.dart';
import 'package:ecomerce/features/splash/bloc/splash_event.dart';
import 'package:ecomerce/features/splash/bloc/splash_state.dart';
import 'package:ecomerce/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(DisplaySplash()) {
    on<AppStarted>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));
      final isLogged = await sl<IsLoggedInUseCase>().call(null);
      print(isLogged);
      if (isLogged) {
        emit(Authenticated());
      } else {
        emit(UnAuthenticated());
      }
    });
  }
}
