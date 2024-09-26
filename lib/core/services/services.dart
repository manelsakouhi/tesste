import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../firebase_options.dart';
import 'notification_services.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;//package

  Future<MyServices> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    sharedPreferences = await SharedPreferences.getInstance();
     NotificationService();
    return this;
  }
}

intialServices() async {
  await Get.putAsync(() => MyServices().init());
}
