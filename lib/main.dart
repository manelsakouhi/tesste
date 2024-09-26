
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/core/functions/fcmconfig.dart';
import 'binding.dart';
import 'core/services/services.dart';
import 'localization/changelocal.dart';
import 'localization/translation.dart';
import 'routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Instance pour les notifications locales
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await intialServices();
  //  // Configurer Firebase Messaging
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // // Demander la permission pour les notifications
  // await requestPermissionNotifacation();
  // // Configurer les notifications locales
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');
  // const InitializationSettings initializationSettings =
  //     InitializationSettings(android: initializationSettingsAndroid);

  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(const MyApp());
}
// Handler pour les messages reçus en arrière-plan
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class  MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return  GetMaterialApp(
    translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      
      theme: controller.AppTheme,
      initialBinding: MyBinding(),
      locale: controller.language,
      // initialBinding: MyBinding(),
      // home: UpdateProfil(),
      getPages: routes,
    );
  }
}

