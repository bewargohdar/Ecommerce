import 'package:ecomerce/core/config/theme/app_theme.dart';
import 'package:ecomerce/core/service/notification_service.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecomerce/features/category/presentation/bloc/category_bloc.dart';
import 'package:ecomerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecomerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecomerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecomerce/features/search/presentation/bloc/search_bloc.dart';
import 'package:ecomerce/features/splash/bloc/splash_bloc.dart';
import 'package:ecomerce/features/splash/bloc/splash_event.dart';
import 'package:ecomerce/features/splash/page/splash.dart';
import 'package:ecomerce/firebase_options.dart';
import 'package:ecomerce/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize dependencies (GetIt)
  await initializeDependencies();

  final notificationService = NotificationService();
  // Initialize notification service
  await notificationService.init();

  await dotenv.load(fileName: ".env");

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessaging);

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
            home: const Splash()),
      );
}

Future<void> handleBackgroundMessaging(RemoteMessage message) async {
  debugPrint('Background message received: ${message.notification?.title}');
  debugPrint('Message data: ${message.data}');

  // Handle the background message data here
  // You can store it locally, update app badge, etc.
  if (message.data.isNotEmpty) {
    String type = message.data['type'] ?? 'general';
    String id = message.data['id'] ?? '';
    debugPrint('Background message type: $type, id: $id');
  }
}
