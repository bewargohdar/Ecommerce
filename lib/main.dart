import 'package:ecomerce/core/config/theme/app_theme.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/domain/usecase/is_logged_in.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecomerce/features/auth/presentation/page/signin_page.dart';
import 'package:ecomerce/features/category/presentation/bloc/category_bloc.dart';
import 'package:ecomerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecomerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecomerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecomerce/features/search/presentation/bloc/search_bloc.dart';
import 'package:ecomerce/features/splash/bloc/splash_bloc.dart';
import 'package:ecomerce/features/splash/bloc/splash_event.dart';
import 'package:ecomerce/features/splash/page/splash.dart';
import 'package:ecomerce/features/tabs/presentation/page/tabs_page.dart';
import 'package:ecomerce/firebase_options.dart';
import 'package:ecomerce/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecomerce/features/cart/presentation/bloc/cart_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase and dependencies in parallel for faster startup
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    initializeDependencies(),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<AuthBloc>()),
          BlocProvider(
              create: (context) => sl<SplashBloc>()..add(AppStarted())),
          BlocProvider(create: (context) => sl<HomeBloc>()),
          BlocProvider(create: (context) => sl<CategoryBloc>()),
          BlocProvider(create: (context) => sl<ProductBloc>()),
          BlocProvider(create: (context) => sl<SearchBloc>()),
          BlocProvider(create: (context) => sl<CartBloc>()),
          BlocProvider(
              create: (context) =>
                  sl<ProfileBloc>()..add(const LoadUserProfileEvent(userId: 1)))
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ecomerce',
            theme: AppTheme.appTheme,
            home: const AppRouter()),
      );
}

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  bool _isInitialized = false;
  Widget? _homeWidget;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      final isLoggedInUseCase = sl<IsLoggedInUseCase>();
      final isLoggedIn = await isLoggedInUseCase.call(NoParams());

      setState(() {
        _homeWidget = isLoggedIn ? const TabsPage() : SigninPage();
        _isInitialized = true;
      });
    } catch (e) {
      setState(() {
        _homeWidget = SigninPage();
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Splash();
    }

    return _homeWidget!;
  }
}
