

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/create_event_controller.dart';
import '../controller/edit_event_controller_test.dart';
import '../widgets_create_events/custom_dropdown_list.dart';
import '../widgets_create_events/custom_icon_with_title.dart';
import '../widgets_create_events/custom_text_form_list.dart';
import 'widgets/custom_button_edit_event.dart';
import 'widgets/custom_choose_image.dart';
import 'widgets/custom_dropdown_list.dart';
import 'widgets/custom_selected_images.dart';
import 'widgets/custom_text_form_list.dart';
import 'widgets/description_andInvite_section.dart';
import 'widgets/edit_description.dart';

class EditEventView extends StatelessWidget {
  const EditEventView({super.key});

  @override
  Widget build(BuildContext context) {
    // final String eventId = Get.arguments;

  //   // Initialize controllers
    // final CreateEventControllerImp controller = Get.put(CreateEventControllerImp());

  //   // Set the event ID
  //   controller.eventId.value = eventId;

  //   // Load event data when the controller is initialized
    // controller.loadEventData(eventId);
    Get.put(EditEventControllerImp());
   final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GetBuilder<EditEventControllerImp>(
        builder: (controller) => Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                const CustomIconWithTitle(title: "Edit Event"),
                SizedBox(height: size.height * 0.02),
                const EditCustomDropDownList(),
                SizedBox(height: size.height * 0.03),
                EditCustomChooseImage(size: size),
                controller.media.isEmpty ? Container() : SizedBox(height: 20),
                controller.media.isEmpty ? Container() : EditCustomSelectedImeges(size: size),
                const SizedBox(height: 20),
                const EditCustomTextFormList(),
                EditDescriptionAndInviteSection(size: size),
       SizedBox(
                  height: size.height * 0.03
                ),
                const CustomButtonUpdateEvent(),
                // SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),);
  }
}