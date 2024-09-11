import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/approutes.dart';
import '../services/services.dart';

class MyMiddleWare extends GetMiddleware {
  int? get prioroty => 1;
  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
   if (myServices.sharedPreferences.getString("step") == "4") {
      return const RouteSettings(name: AppRoute.admin);
    }
    if (myServices.sharedPreferences.getString("step") == "3") {
      return const RouteSettings(name: AppRoute.visiteur);
    }
    if (myServices.sharedPreferences.getString("step") == "2") {
      return const RouteSettings(name: AppRoute.visiteurProf);
    }
    if (myServices.sharedPreferences.getString("step") == "1") {
      return const RouteSettings(name: AppRoute.login);
    }

    return null;
  }
}
