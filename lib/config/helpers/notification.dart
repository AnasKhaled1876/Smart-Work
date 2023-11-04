import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import '../../main.dart';

class NotificationHelper {
  int _id = 0;

  Future<void> showNotification(
      {required String title, required String body}) async {
    // const AndroidInitializationSettings initializationSettingsAndroid =
    //   AndroidInitializationSettings('app_icon');
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            icon: "@mipmap/ic_launcher",
            colorized: true,
            color: secondaryColor,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(_id++, title, body, notificationDetails, payload: 'item x');
  }
}
