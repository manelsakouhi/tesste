
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/create_event_controller.dart';
import '../utils/app_color.dart';
import 'my_widgets.dart';

class DescriptionAndInviteSection extends GetView<CreateEventControllerImp> {
  const DescriptionAndInviteSection({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            myText(
              text: 'Description/Instruction',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 149,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColors.genderTextColor),
          ),
          child: TextFormField(
            controller: controller.descriptionController, // Bind the controller
            maxLines: 5,
            validator: (input) {
              if (input!.isEmpty) {
                Get.snackbar('Oops', "Description is required.",
                    colorText: Colors.white,
                    backgroundColor: Colors.blue);
                return '';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.only(top: 25, left: 15, right: 15),
              hintStyle: TextStyle(
                color: AppColors.genderTextColor,
              ),
              hintText:
                  'Write a summary and any details your invitee should know about the event...',
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
       
        SizedBox(
          height: size.height * 0.005,
        ),
 
      ],
    );
  }
}
