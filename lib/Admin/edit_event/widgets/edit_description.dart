
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../controller/edit_event_controller_test.dart';
// import '../../utils/app_color.dart';
// import '../../widgets_create_events/my_widgets.dart';



// class EditDescriptionAndInviteSection extends GetView<EditEventControllerImp> {
//   const EditDescriptionAndInviteSection({
//     super.key,
//     required this.size,
//   });

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             myText(
//               text: 'Description/Instruction',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Container(
//           height: 149,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(width: 1, color: AppColors.genderTextColor),
//           ),
//           child: TextFormField(
//             controller: controller.descriptionController, // Bind the controller
//             maxLines: 5,
//             validator: (input) {
//               if (input!.isEmpty) {
//                 Get.snackbar('Oops', "Description is required.",
//                     colorText: Colors.white,
//                     backgroundColor: Colors.blue);
//                 return '';
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding:
//                   const EdgeInsets.only(top: 25, left: 15, right: 15),
//               hintStyle: TextStyle(
//                 color: AppColors.genderTextColor,
//               ),
//               hintText:
//                   'Write a summary and any details your invitee should know about the event...',
//             ),
//           ),
//         ),
//         SizedBox(
//           height: size.height * 0.02,
//         ),
//         Container(
//           alignment: Alignment.topLeft,
//           child: myText(
//             text: 'Who can invite?',
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: size.height * 0.005,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               width: 150,
//               height: 40,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(width: 1, color: AppColors.genderTextColor),
//               ),
//               child: DropdownButton<String>(
//                 isExpanded: true,
//                 underline: Container(),
//                 icon: Image.asset('assets/images/photo.png'),
//                 elevation: 16,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.black,
//                 ),
//                 value: controller.accessModifier,
//                 onChanged: (String? newValue) {
//                   controller.accessModifier = newValue!;
//                   controller.update(); // Update the UI
//                 },
//                 items: controller.close_list
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xffA6A6A6),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
