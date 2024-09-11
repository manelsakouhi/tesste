import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/onbording_screen.dart';


import '../../../localization/changelocal.dart';
import '../widgets/custombuttonlang.dart';

class Language extends GetView<LocalController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "1".tr,
                // style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButtonLang(
                text: 'EN',
                onPressed: () {
                  controller.changeLang("en");
                  // Get.offNamed(AppRoute.onBoarding);
                  Get.offAll(const OnBoardingScreen());
                },
              ),
            const SizedBox(
              height: 10,
            ),
              CustomButtonLang(
                text: 'JP',
                onPressed: () {
                  controller.changeLang("jp");
                   Get.offAll(const OnBoardingScreen());
                },
              ),
            ]),
      ),
    );
  }
}
