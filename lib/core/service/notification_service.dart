import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// It is recommended to declare this handler as a top-level function outside of any class.
// This is CRITICAL for handling messages when the app is in the background or terminated.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, like Firestore,
  // make sure you call `initializeApp` before using them.
  await Firebase.initializeApp();
  // Handle background message: ${message.messageId}
  // Message data: ${message.data}
  // Message notification: ${message.notification?.title}
}

class NotificationService {
  // Singleton pattern
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // Dependencies
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // State
  bool _isInitialized = false;
  String? _fcmToken;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<void> init() async {
    if (_isInitialized) return;

    await _requestPermissions();

    _fcmToken = await _firebaseMessaging.getToken();
    _firebaseMessaging.onTokenRefresh.listen((token) {
      _fcmToken = token;
      // FCM Token refreshed: $token
      // Here you would send the new token to your server
    });

    // 3. Set up Handlers
    _setupMessageHandlers();

    // --- Local Notifications Setup ---
    await _initializeLocalNotifications();

    _isInitialized = true;
    // NotificationService initialized.
  }

  /// Requests notification permissions.
  Future<void> _requestPermissions() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  /// Sets up handlers for incoming FCM messages in different app states.
  void _setupMessageHandlers() {
    // 1. Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showLocalNotification(
          id: message.hashCode,
          title: message.notification!.title ?? 'New Message',
          body: message.notification!.body ?? '',
          payload: message.data['route'], // Example: pass a route
        );
      }
    });

    // 2. Background/Terminated messages (when user taps the notification)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Notification TAPPED (from background/terminated)
      _handleNotificationTap(message.data);
    });

    // 3. Handle initial message if app was opened from a terminated state
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        // App opened from TERMINATED state via notification
        _handleNotificationTap(message.data);
      }
    });

    // 4. Set the background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Initializes the flutter_local_notifications plugin.
  Future<void> _initializeLocalNotifications() async {
    // Android Initialization
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS Initialization
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Local notification TAPPED
        if (response.payload != null && response.payload!.isNotEmpty) {
          _handleNotificationTap({'route': response.payload});
        }
      },
    );

    // Create a channel for Android (required for Android 8.0+)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
      playSound: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Centralized handler for notification taps.
  void _handleNotificationTap(Map<String, dynamic> data) {
    // Handling tap with data: $data
    final String? route = data['route'];
    if (route != null) {
      // Navigating to route: $route
      // Use the global navigator key to navigate without a build context.
      navigatorKey.currentState?.pushNamed(route);
    }
  }

  /// Displays a local notification.
  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    // Showing local notification: $id, Title: $title
    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
    await _localNotifications.show(id, title, body, details, payload: payload);
  }

  /// Returns the current FCM token.
  String? getFCMToken() => _fcmToken;

  /// Test method to verify local notifications work.
  Future<void> showTestNotification() async {
    // Showing test notification...
    await showLocalNotification(
      id: 999,
      title: 'Test Notification',
      body: 'This is a test notification to verify the system works.',
      payload: '/test',
    );
  }

  Future<AccessCredentials> _getAccessToken() async {
    final serviceAccountPath = dotenv.env['PATH_TO_SECRET'];

    String serviceAccountJson =
        await rootBundle.loadString(serviceAccountPath!);

    final serviceAccount =
        ServiceAccountCredentials.fromJson(serviceAccountJson);

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = await clientViaServiceAccount(serviceAccount, scopes);
    return client.credentials;
  }

  Future<bool> sendPushNotification({
    required String deviceToken,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    if (deviceToken.isEmpty) return false;

    final credentials = await _getAccessToken();
    final accessToken = credentials.accessToken.data;
    final projectId = dotenv.env['PROJECT_ID'];

    final url =
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

    final message = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': data ?? {},
      },
    };

    try {
      final dio = Dio();
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully.');
        return true;
      } else {
        print('Failed to send notification: ${response.data}');
        return false;
      }
    } catch (e) {
      print('Error sending notification: $e');
      return false;
    }
  }
}
