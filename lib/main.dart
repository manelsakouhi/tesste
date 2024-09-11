
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//
import 'binding.dart';
import 'core/services/services.dart';
import 'localization/changelocal.dart';
import 'localization/translation.dart';
import 'routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await intialServices();
  runApp(const MyApp());
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

