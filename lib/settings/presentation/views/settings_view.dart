import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/core/shared/defult_button.dart';

import '../../controller/settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsControllerImp());

    return Scaffold(
      appBar: AppBar(
        title:  Text("27".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<SettingsControllerImp>(
          builder: (controller) => ListView(
            children: [
              // Language Dropdown
              Row(
                children: [
                   Text('28'.tr),
                  const SizedBox(width: 20),
                  Obx(() {
                    return DropdownButton<Locale>(
                      
                      value: controller.selectedLocale.value,
                      onChanged: (Locale? newLocale) {
                        if (newLocale != null) {
                          controller.changeLang(newLocale.languageCode);
                        }
                      },
                      items:  [
                        DropdownMenuItem(
                          value: const Locale('en', 'US'),
                          child: Text('29'.tr),
                        ),
                       
                        DropdownMenuItem(
                          value: const Locale('jp', 'JP'),
                          child: Text('30'.tr),
                        ),
                        // Add more languages here
                      ],
                    );
                  }),
                ],
              ),
              const SizedBox(height: 20),
              CustomDefultButton(
                text: "31".tr,
                onPressed: () {
                  controller.deleteAccount();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
