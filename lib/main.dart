import 'package:ecomerce/core/config/theme/app_theme.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecomerce/features/splash/bloc/splash_bloc.dart';
import 'package:ecomerce/features/splash/bloc/splash_state.dart';
import 'package:ecomerce/features/splash/page/splash.dart';
import 'package:ecomerce/firebase_options.dart';
import 'package:ecomerce/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Assuming SplashBloc and AppStarted are defined elsewhere in your project

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc()),
          BlocProvider(create: (context) => SplashBloc()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ecomerce',
            theme: AppTheme.appTheme,
            home: BlocProvider(
              create: (context) => SplashBloc()..add(AppStarted()),
              child: Splash(),
            )),
      );
}
