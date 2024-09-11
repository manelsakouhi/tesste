import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:teste/core/functions/defult_notification.dart';


// import 'package:mega_store/controller/orders/orders_pending_controller.dart';

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
}

fcmconfig() {
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

refreshPageNotifiction(data) {
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
    // OrdersControllerImp controller = Get.find();
    // controller.refreshOrders();
  }
  if (Get.currentRoute == "/notificationsView" &&
      data['pagenotification'] == "notification") {
    // NotificationsControllerImp controller = Get.find();
    // controller.refreshNotification();
  }
  if (Get.currentRoute == "/ordersStatus" &&
      data['pagename'] == "refreshOrdersStatus") {
    if (data['pagedata'] == "4") {
      // OrdersStatusControllerImp controller = Get.find();
      // controller.goToRattingScreen();
    } else {
      // OrdersStatusControllerImp controller = Get.find();
      // controller.getOrdersStatus();
    }
  }
}
