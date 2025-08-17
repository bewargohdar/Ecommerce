import 'package:flutter/material.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      title: 'Welcome to our store!',
      body: 'Check out our latest deals and offers.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: false,
      type: 'welcome',
    ),
    NotificationItem(
      id: '2',
      title: 'Your order has been shipped',
      body: 'Your order #12345 is on its way to you.',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: false,
      type: 'order',
    ),
    NotificationItem(
      id: '3',
      title: 'New products available',
      body: 'Check out our new arrivals in electronics.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      type: 'product',
    ),
    NotificationItem(
      id: '4',
      title: 'Flash Sale Alert!',
      body: '50% off on selected items. Limited time offer.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: false,
      type: 'sale',
    ),
    NotificationItem(
      id: '5',
      title: 'Password changed successfully',
      body: 'Your password has been updated successfully.',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
      type: 'security',
    ),
  ];

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () {
                setState(() {
                  for (var notification in notifications) {
                    notification.isRead = true;
                  }
                });
              },
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We\'ll notify you when something arrives!',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                // Simulate refresh
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  // You can add new notifications here
                });
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return _buildNotificationCard(notification);
                },
              ),
            ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: notification.isRead
          ? AppColors.secondBackground
          : AppColors.secondBackground.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: notification.isRead
            ? BorderSide.none
            : const BorderSide(color: AppColors.primary, width: 0.5),
      ),
      child: InkWell(
        onTap: () {
          if (!notification.isRead) {
            setState(() {
              notification.isRead = true;
            });
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNotificationIcon(notification.type),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: notification.isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      timeago.format(notification.timestamp),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(String type) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case 'order':
        iconData = Icons.shopping_bag;
        iconColor = Colors.green;
        break;
      case 'sale':
        iconData = Icons.local_offer;
        iconColor = Colors.orange;
        break;
      case 'product':
        iconData = Icons.inventory_2;
        iconColor = Colors.blue;
        break;
      case 'security':
        iconData = Icons.security;
        iconColor = Colors.red;
        break;
      case 'welcome':
        iconData = Icons.waving_hand;
        iconColor = Colors.yellow;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = AppColors.primary;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 20,
      ),
    );
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  bool isRead;
  final String type;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.isRead,
    required this.type,
  });
}
