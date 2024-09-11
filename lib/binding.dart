import 'package:get/get.dart';

import 'Admin/controller/data_controller.dart';



class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataController() , fenix: true);

   
  }
}
