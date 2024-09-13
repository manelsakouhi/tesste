// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:teste/Admin/controller/create_event_controller.dart';
// import 'package:teste/Admin/controller/data_controller.dart';
// import 'package:teste/Admin/controller/edit_event_controller.dart';
// import 'custom_button_create_event.dart';
// import 'custom_button_edit_event.dart';
// import 'custom_choose_image.dart';
// import 'custom_dropdown_list.dart';
// import 'custom_icon_with_title.dart';
// import 'custom_selected_images.dart';
// import 'custom_text_form_list.dart';

// class EditEventView extends StatelessWidget {
//   EditEventView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Get.put(EditEventControllerImp());
//     // Get the event ID from the arguments
//     final String eventId = Get.arguments;

//     // Initialize controllers
//     final CreateEventControllerImp controller = Get.put(CreateEventControllerImp());

//     // Set the event ID
//     controller.eventId.value = eventId;

//     // Load event data when the controller is initialized
//     controller.loadEventData(eventId);

//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: GetBuilder<CreateEventControllerImp>(
//         builder: (controller) => Container(
//           margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
//           child: Form(
//             key: controller.formKey,
//             child: ListView(
//               children: [
//                 const CustomIconWithTitle(title: "Edit Event"),
//                 SizedBox(height: size.height * 0.02),
//                 const CustomDropDownList(),
//                 SizedBox(height: size.height * 0.03),
//                 CustomChooseImage(size: size),
//                 controller.media.isEmpty ? Container() : SizedBox(height: 20),
//                 controller.media.isEmpty ? Container() : CustomSelectedImeges(size: size),
//                 const SizedBox(height: 20),
//                 const CustomTextFormList(),
//                 const CustomButtonUpdateEvent(),
//                 SizedBox(height: size.height * 0.03),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
