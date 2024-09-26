import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/Admin/controller/data_controller.dart';

import '../controller/create_event_controller.dart';
import 'custom_button_create_event.dart';
import 'custom_choose_image.dart';
import 'custom_dropdown_list.dart';
import 'custom_icon_with_title.dart';
import 'custom_selected_images.dart';
import 'custom_text_form_list.dart';

class CreateEventView extends StatelessWidget {
  const CreateEventView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DataController());
    final size = MediaQuery.sizeOf(context);
    Get.put(CreateEventControllerImp());
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<CreateEventControllerImp>(
        builder: (controller) => Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                const CustomIconWithTitle(title: "Create an Event"),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const CustomDropDownList(),
                SizedBox(
                  height: size.height * 0.03,
                ),
                CustomChooseImage(size: size),
                controller.media.isEmpty
                    ? Container()
                    : const SizedBox(
                        height: 20,
                      ),
                controller.media.isEmpty
                    ? Container()
                    : CustomSelectedImeges(size: size),
                const SizedBox(
                  height: 20,
                ),
                const CustomTextFormList(),
                const CustomButtonCreateEvent(),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
