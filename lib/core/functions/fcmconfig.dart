import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:teste/core/functions/defult_notification.dart';


// import 'package:mega_store/controller/orders/orders_pending_controller.dart';
//Cette fonction demande l'autorisation à l'utilisateur pour recevoir des notifications. 
requestPermissionNotifacation() async {
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Permission de notification accordée.');
  } else {
    print('Permission de notification refusée.');
  }
}
//Cette fonction configure l'écouteur pour les messages entrants de Firebase. 
//Lorsqu'une notification est reçue pendant que l'application est au premier plan, 
//l'écouteur FirebaseMessaging.onMessage.listen est déclenché.
fcmconfig() {
  FirebaseMessaging.instance.getToken().then((token) {
    print("FCM Token: $token");
  });
  FirebaseMessaging.onMessage.listen((message) {
    print("=========== Notifacation ============");
    print(message.notification!.title);
    print(message.notification!.body);
    // FlutterRingtonePlayer.playNotification();

    defultNotification(
      title: message.notification!.title!,
      body: message.notification!.body!,
    );
    refreshPageNotifiction(message.data);
  });
}
//Cette fonction est appelée pour actualiser ou rediriger l'utilisateur vers
// une page spécifique en fonction des données envoyées avec la notification.
void refreshPageNotifiction(Map<String, dynamic> data) {
  print("============== page id");
  print(data['pageid']);
  print("============== page name");
  print(data['pagename']);
  print("============== page Data");
  print(data['pagedata']);
  print("============== Current Route");
  print(Get.currentRoute);

  if (Get.currentRoute == "/homeLayoutView" &&
      data['pagename'] == "refreshorderpending") {
    // Logic for refreshing orders
  }
  if (Get.currentRoute == "/notificationsView" &&
      data['pagenotification'] == "notification") {
    // Logic for refreshing notifications
  }
  if (Get.currentRoute == "/ordersStatus" &&
      data['pagename'] == "refreshOrdersStatus") {
    if (data['pagedata'] == "4") {
      // Logic for order status
    } else {
      // Logic to fetch the order status again
    }
  }
}

