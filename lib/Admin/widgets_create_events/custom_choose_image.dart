import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/create_event_controller.dart';
import '../utils/app_color.dart';
import 'my_widgets.dart';

class CustomChooseImage extends GetView<CreateEventControllerImp> {
  const CustomChooseImage({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * 0.6,
      width: size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.border.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8)),
      child: DottedBorder(
        color: AppColors.border,
        strokeWidth: 1.5,
        dashPattern:const [6, 6],
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(
                width: 76,
                height: 59,
                child: Image.asset('assets/images/photo.png'),
              ),
              myText(
                text: 'Click and upload image/video',
                style: TextStyle(
                  color: AppColors.blue,
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              elevatedButton(
                  onpress: () async {
                   controller. mediaDialog(context);
                  },
                  text: 'Upload')
            ],
          ),
        ),
      ),
    );
  }
}
