import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:teste/core/functions/defult_notification.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initializeLocalNotifications();
    _requestPermission();
    _configureFirebaseListeners();
    // Register the background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Initialize local notifications
  void _initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    _localNotificationsPlugin.initialize(initializationSettings);
  }

  // Request permission for notifications
  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission de notification accordée.');
    } else {
      print('Permission de notification refusée.');
    }
  }

  // Configure Firebase listeners for incoming messages
  void _configureFirebaseListeners() {
    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("=========== Notification ============");
      print(message.notification?.title);
      print(message.notification?.body);
      
      // Show local notification
      defultNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
      );

      _refreshPageNotification(message.data);
    });
  }

  // This function must be a top-level function.
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    
    // Show local notification
    await defultNotification(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
    );

    // You can handle additional data here
    // For example, redirect the user based on message data
  }

  // Refresh page or redirect user based on notification data
  void _refreshPageNotification(Map<String, dynamic> data) {
    print("============== Page ID: ${data['pageid']}");
    print("============== Page Name: ${data['pagename']}");
    print("============== Page Data: ${data['pagedata']}");
    print("============== Current Route: ${Get.currentRoute}");

    if (Get.currentRoute == "/homeLayoutView" && data['pagename'] == "refreshorderpending") {
      // Logic for refreshing orders
    }
    if (Get.currentRoute == "/notificationsView" && data['pagenotification'] == "notification") {
      // Logic for refreshing notifications
    }
    if (Get.currentRoute == "/ordersStatus" && data['pagename'] == "refreshOrdersStatus") {
      if (data['pagedata'] == "4") {
        // Logic for specific order status
      } else {
        // Logic to fetch the order status again
      }
    }
}
}