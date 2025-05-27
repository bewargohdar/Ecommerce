import 'package:ecomerce/features/auth/domain/usecase/is_logged_in.dart';
import 'package:ecomerce/features/splash/bloc/splash_event.dart';
import 'package:ecomerce/features/splash/bloc/splash_state.dart';
import 'package:ecomerce/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(DisplaySplash()) {
    on<AppStarted>((event, emit) async {
      // Use Future.delayed instead of Timer for better async handling in tests
      await Future.delayed(const Duration(milliseconds: 2500));

      if (!isClosed) {
        try {
          final isLogged = await sl<IsLoggedInUseCase>().call();
          if (isLogged && !isClosed) {
            emit(Authenticated());
          } else if (!isClosed) {
            emit(UnAuthenticated());
          }
        } catch (e) {
          if (!isClosed) {
            emit(UnAuthenticated());
          }
        }
      }
    });
  }
}
