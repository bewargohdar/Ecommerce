import 'package:ecomerce/common/helper/navigator/app_navigator.dart';
import 'package:ecomerce/core/config/assets/app_vectors.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/auth/presentation/page/signin_page.dart';
import 'package:ecomerce/features/home/presentation/page/home.dart';
import 'package:ecomerce/features/splash/bloc/splash_bloc.dart';
import 'package:ecomerce/features/splash/bloc/splash_event.dart';
import 'package:ecomerce/features/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(AppStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is Authenticated) {
            AppNavigator.pushReplacement(context, const HomePage());
          }
          if (state is UnAuthenticated) {
            AppNavigator.pushReplacement(context, SigninPage());
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primary,
          body: Center(
            child: SvgPicture.asset(
              AppVectors.appLogo,
            ),
          ),
        ),
      ),
    );
  }
}
