import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/Admin/utils/app_color.dart';



class CustomDefultButton extends StatelessWidget {
  const CustomDefultButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isShowIcon = false,
    this.isSecButton = false,
    this.isPadding = false,
    this.iscustomWidth = false,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.color,
  });
  final String text;
  final void Function() onPressed;
  final bool? isShowIcon;
  final bool? isSecButton;
  final bool? isPadding;
  final bool? iscustomWidth;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: iscustomWidth == false
          ? isPadding == false
              ? Get.width
              : Get.width - 120
          : null,
      margin: const EdgeInsets.only(top: 0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          // side: isSecButton == true
          //     ? const BorderSide(color: AppColor.primaryColor)
          //     : const BorderSide(color: AppColor.fithColor),
        ),
        padding: padding,
        onPressed: onPressed,
        color: color == null
            ? isSecButton == false
                ? AppColors.primaryColor
                : Colors.white
            : color!,
        textColor: isSecButton == false ? Colors.white : AppColors.primaryColor,
        child: isShowIcon == false
            ? Text(text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
            : Text(text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
      ),
    );
  }
}
