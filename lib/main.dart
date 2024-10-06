import 'package:ecomerce/core/config/theme/app_theme.dart';
import 'package:ecomerce/features/splash/bloc/splash_bloc.dart';
import 'package:ecomerce/features/splash/bloc/splash_state.dart';
import 'package:ecomerce/features/splash/page/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Assuming SplashBloc and AppStarted are defined elsewhere in your project

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) {
        final splashBloc = SplashBloc();
        splashBloc.add(AppStarted());
        return splashBloc;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: const Splash(),
      ),
    );
  }
}