import 'package:get/get.dart';
import 'package:teste/Admin/utils/app_color.dart';


defultNotification({required String title, required String body}) {
  Get.snackbar(
    title,
    body,
    // backgroundColor: AppColors.fithColor,
    colorText: AppColors.primaryColor,
  );
}
