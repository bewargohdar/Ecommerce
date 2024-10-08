// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB5miJY8IdeXNntHSGQgy-kphJnDxI1A4I',
    appId: '1:704204378722:web:5cb6cdcd496d12c859373b',
    messagingSenderId: '704204378722',
    projectId: 'ecommerce-c67c0',
    authDomain: 'ecommerce-c67c0.firebaseapp.com',
    storageBucket: 'ecommerce-c67c0.appspot.com',
    measurementId: 'G-5RM061DY4F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6RYsIXio6fZVeI2T_bHC0jut1Jcip6wY',
    appId: '1:704204378722:android:ba2af7ea17870abb59373b',
    messagingSenderId: '704204378722',
    projectId: 'ecommerce-c67c0',
    storageBucket: 'ecommerce-c67c0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDftGqUXO_v4iLhrWXFW2P494DJOZlj7iQ',
    appId: '1:704204378722:ios:15c4aab205e2198b59373b',
    messagingSenderId: '704204378722',
    projectId: 'ecommerce-c67c0',
    storageBucket: 'ecommerce-c67c0.appspot.com',
    iosBundleId: 'com.example.ecomerce',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDftGqUXO_v4iLhrWXFW2P494DJOZlj7iQ',
    appId: '1:704204378722:ios:15c4aab205e2198b59373b',
    messagingSenderId: '704204378722',
    projectId: 'ecommerce-c67c0',
    storageBucket: 'ecommerce-c67c0.appspot.com',
    iosBundleId: 'com.example.ecomerce',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB5miJY8IdeXNntHSGQgy-kphJnDxI1A4I',
    appId: '1:704204378722:web:7f56e1f4f8b3b02a59373b',
    messagingSenderId: '704204378722',
    projectId: 'ecommerce-c67c0',
    authDomain: 'ecommerce-c67c0.firebaseapp.com',
    storageBucket: 'ecommerce-c67c0.appspot.com',
    measurementId: 'G-S8J8933CN1',
  );
}
