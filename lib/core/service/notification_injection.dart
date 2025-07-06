import 'package:ecomerce/core/service/notification_service.dart';
import 'package:ecomerce/service_locator.dart';

void setUpNotificationDependencies() {
  // Register NotificationService as singleton
  sl.registerLazySingleton<NotificationService>(
    () => NotificationService(),
  );
}
