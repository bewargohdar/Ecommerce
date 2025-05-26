import 'package:ecomerce/features/auth/domain/usecase/is_logged_in.dart';
import 'package:ecomerce/features/splash/bloc/splash_event.dart';
import 'package:ecomerce/features/splash/bloc/splash_state.dart';
import 'package:ecomerce/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(DisplaySplash()) {
    on<AppStarted>((event, emit) async {
      // Remove the artificial delay for faster startup
      // Add minimal delay only for smooth transition
      await Future.delayed(const Duration(milliseconds: 500));

      try {
        final isLogged = await sl<IsLoggedInUseCase>().call();
        print('User logged in: $isLogged');

        if (isLogged) {
          emit(Authenticated());
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        print('Error checking authentication: $e');
        // Default to unauthenticated on error
        emit(UnAuthenticated());
      }
    });
  }
}
