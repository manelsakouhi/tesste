import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:teste/main.dart';



Future<void> defultNotification({
  required String title,
  required String body,
}) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id', 'your_channel_name',
    channelDescription: 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // ID de notification
    title, // Titre
    body,  // Corps de la notification
    platformChannelSpecifics,
  );
}

