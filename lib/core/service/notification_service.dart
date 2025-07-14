import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool _isInitialized = false;
  String? _fcmToken;

  // Notification channel constants
  static const String _channelId = 'ecommerce_channel';
  static const String _channelName = 'E-commerce Notifications';
  static const String _channelDescription = 'Notifications for E-commerce app';

  bool get isInitialized => _isInitialized;
  String? get fcmToken => _fcmToken;

  // Initialize notification service
  Future<void> initNotification() async {
    if (_isInitialized) return;

    // Initialize timezone
    tz.initializeTimeZones();

    // Android initialization settings
    const initSettingAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const initSettingIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Combined initialization settings
    const initSetting = InitializationSettings(
      android: initSettingAndroid,
      iOS: initSettingIos,
    );

    // Initialize the plugin
    await _notificationPlugin.initialize(
      initSetting,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );

    // Initialize Firebase messaging
    await _initializeFirebaseMessaging();

    _isInitialized = true;
  }

  // Initialize Firebase messaging
  Future<void> _initializeFirebaseMessaging() async {
    // Request permission for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');

    // Get FCM token
    _fcmToken = await _firebaseMessaging.getToken();
    debugPrint('FCM Token: $_fcmToken');

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      debugPrint('FCM Token refreshed: $newToken');
      // Send new token to your server here
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap when app is in background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Handle initial message if app was terminated
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }
  }

  // Handle foreground messages
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('Received foreground message: ${message.messageId}');
    
    // Show local notification when app is in foreground
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await showNotification(
        id: notification.hashCode,
        title: notification.title ?? 'New Notification',
        body: notification.body ?? '',
        payload: _createPayloadFromMessage(message),
      );
    }
  }

  // Handle message when app is opened from notification
  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('Message opened app: ${message.messageId}');
    String payload = _createPayloadFromMessage(message);
    _handleNotificationTap(payload);
  }

  // Create payload string from RemoteMessage
  String _createPayloadFromMessage(RemoteMessage message) {
    Map<String, dynamic> data = message.data;
    String type = data['type'] ?? 'general';
    String id = data['id'] ?? '';
    return '$type:$id';
  }

  // Notification detail setup
  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        showWhen: false,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  // Handle notification response
  void _onNotificationResponse(NotificationResponse notificationResponse) {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('Notification payload: $payload');
      // Handle navigation based on payload
      _handleNotificationTap(payload);
    }
  }

  // Handle notification tap
  void _handleNotificationTap(String? payload) {
    if (payload == null) return;

    debugPrint('Handling notification with payload: $payload');
    
    // Parse payload format: "type:id" or "type:parameter"
    List<String> parts = payload.split(':');
    if (parts.length < 2) return;
    
    String type = parts[0];
    String parameter = parts[1];
    
    switch (type) {
      case 'order':
        _navigateToOrderDetails(parameter);
        break;
      case 'product':
        _navigateToProductDetails(parameter);
        break;
      case 'cart':
        _navigateToCart();
        break;
      case 'promo':
        _navigateToPromotions(parameter);
        break;
      case 'shipping':
        _navigateToOrderTracking(parameter);
        break;
      case 'delivered':
        _navigateToOrderDetails(parameter);
        break;
      case 'wishlist':
        _navigateToWishlist();
        break;
      case 'stock':
        _navigateToProductDetails(parameter);
        break;
      default:
        _navigateToHome();
        break;
    }
  }

  // Navigation methods - implement based on your app's navigation structure
  void _navigateToOrderDetails(String orderId) {
    debugPrint('Navigate to order details: $orderId');
    // TODO: Implement navigation to order details page
    // Example: Get.toNamed('/order-details', arguments: orderId);
  }

  void _navigateToProductDetails(String productId) {
    debugPrint('Navigate to product details: $productId');
    // TODO: Implement navigation to product details page
    // Example: Get.toNamed('/product-details', arguments: productId);
  }

  void _navigateToCart() {
    debugPrint('Navigate to cart');
    // TODO: Implement navigation to cart page
    // Example: Get.toNamed('/cart');
  }

  void _navigateToPromotions(String promoCode) {
    debugPrint('Navigate to promotions: $promoCode');
    // TODO: Implement navigation to promotions page
    // Example: Get.toNamed('/promotions', arguments: promoCode);
  }

  void _navigateToOrderTracking(String orderId) {
    debugPrint('Navigate to order tracking: $orderId');
    // TODO: Implement navigation to order tracking page
    // Example: Get.toNamed('/order-tracking', arguments: orderId);
  }

  void _navigateToWishlist() {
    debugPrint('Navigate to wishlist');
    // TODO: Implement navigation to wishlist page
    // Example: Get.toNamed('/wishlist');
  }

  void _navigateToHome() {
    debugPrint('Navigate to home');
    // TODO: Implement navigation to home page
    // Example: Get.toNamed('/home');
  }

  // Show a simple notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_isInitialized) {
      debugPrint('NotificationService not initialized');
      return;
    }

    await _notificationPlugin.show(
      id,
      title,
      body,
      _notificationDetails(),
      payload: payload,
    );
  }

  // Show notification with custom sound
  Future<void> showNotificationWithSound({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? soundFileName,
  }) async {
    if (!_isInitialized) {
      debugPrint('NotificationService not initialized');
      return;
    }

    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      sound: soundFileName != null
          ? RawResourceAndroidNotificationSound(soundFileName)
          : null,
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: soundFileName,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationPlugin.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  // Schedule a notification
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    if (!_isInitialized) {
      debugPrint('NotificationService not initialized');
      return;
    }

    await _notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      _notificationDetails(),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _notificationPlugin.cancel(id);
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notificationPlugin.cancelAll();
  }

  // Check for pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notificationPlugin.pendingNotificationRequests();
  }

  // Request permissions (especially for iOS)
  Future<bool?> requestPermissions() async {
    if (_isInitialized) {
      return await _notificationPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
    return false;
  }

  // E-commerce specific notification methods

  // Show order confirmation notification
  Future<void> showOrderConfirmation({
    required String orderId,
    required double amount,
  }) async {
    await showNotification(
      id: orderId.hashCode,
      title: '🎉 Order Confirmed!',
      body:
          'Your order #$orderId for \$${amount.toStringAsFixed(2)} has been confirmed.',
      payload: 'order:$orderId',
    );
  }

  // Show shipping notification
  Future<void> showShippingUpdate({
    required String orderId,
    required String status,
  }) async {
    await showNotification(
      id: orderId.hashCode + 1,
      title: '📦 Shipping Update',
      body: 'Your order #$orderId is $status.',
      payload: 'shipping:$orderId',
    );
  }

  // Show delivery notification
  Future<void> showDeliveryNotification({
    required String orderId,
  }) async {
    await showNotification(
      id: orderId.hashCode + 2,
      title: '🚚 Order Delivered!',
      body: 'Your order #$orderId has been delivered successfully.',
      payload: 'delivered:$orderId',
    );
  }

  // Show promotional notification
  Future<void> showPromotionalNotification({
    required String title,
    required String message,
    String? promoCode,
  }) async {
    await showNotification(
      id: DateTime.now().millisecondsSinceEpoch,
      title: '🎁 $title',
      body: message,
      payload: promoCode != null ? 'promo:$promoCode' : 'promo:general',
    );
  }

  // Show cart abandonment reminder
  Future<void> showCartReminderNotification({
    required int itemCount,
  }) async {
    await showNotification(
      id: 999999, // Fixed ID for cart reminders
      title: '🛒 Items waiting in your cart',
      body:
          'You have $itemCount item${itemCount > 1 ? 's' : ''} waiting. Complete your purchase now!',
      payload: 'cart:reminder',
    );
  }

  // Show wishlist item on sale notification
  Future<void> showWishlistSaleNotification({
    required String productName,
    required double originalPrice,
    required double salePrice,
  }) async {
    final discount =
        ((originalPrice - salePrice) / originalPrice * 100).round();
    await showNotification(
      id: productName.hashCode,
      title: '💝 Wishlist Item on Sale!',
      body:
          '$productName is now $discount% off! Was \$${originalPrice.toStringAsFixed(2)}, now \$${salePrice.toStringAsFixed(2)}',
      payload: 'wishlist:sale:$productName',
    );
  }

  // Show low stock notification
  Future<void> showLowStockNotification({
    required String productName,
    required int remainingStock,
  }) async {
    await showNotification(
      id: productName.hashCode + 100,
      title: '⚠️ Low Stock Alert',
      body: 'Only $remainingStock left of $productName. Order now!',
      payload: 'stock:low:$productName',
    );
  }

  // Firebase messaging topic subscription methods
  
  // Subscribe to notification topics
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic $topic: $e');
    }
  }

  // Unsubscribe from notification topics
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint('Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('Error unsubscribing from topic $topic: $e');
    }
  }

  // Subscribe to all e-commerce related topics
  Future<void> subscribeToEcommerceTopics() async {
    await subscribeToTopic('all_users');
    await subscribeToTopic('promotions');
    await subscribeToTopic('new_products');
    await subscribeToTopic('price_alerts');
  }

  // Unsubscribe from all topics
  Future<void> unsubscribeFromAllTopics() async {
    await unsubscribeFromTopic('all_users');
    await unsubscribeFromTopic('promotions');
    await unsubscribeFromTopic('new_products');
    await unsubscribeFromTopic('price_alerts');
  }

  // Subscribe to user-specific topics
  Future<void> subscribeToUserTopics(String userId) async {
    await subscribeToTopic('user_$userId');
    await subscribeToTopic('orders_$userId');
  }

  // Unsubscribe from user-specific topics
  Future<void> unsubscribeFromUserTopics(String userId) async {
    await unsubscribeFromTopic('user_$userId');
    await unsubscribeFromTopic('orders_$userId');
  }

  // Get current FCM token for sending to server
  Future<String?> getCurrentToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      _fcmToken = token;
      return token;
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }

  // Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    NotificationSettings settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
