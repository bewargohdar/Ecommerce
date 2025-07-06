import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  // Notification channel constants
  static const String _channelId = 'ecommerce_channel';
  static const String _channelName = 'E-commerce Notifications';
  static const String _channelDescription = 'Notifications for E-commerce app';

  bool get isInitialized => _isInitialized;
  // Initialize notification service
  Future<void> initNotification() async {
    if (_isInitialized) return;

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

    _isInitialized = true;
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

    // Parse payload and navigate accordingly
    // You can implement navigation logic here based on your app's requirements
    debugPrint('Handling notification with payload: $payload');
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
}
