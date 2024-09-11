import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/create_event_controller.dart';
import '../utils/app_color.dart';

class CustomDropDownList extends GetView<CreateEventControllerImp> {
  const CustomDropDownList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          padding:const EdgeInsets.only(left: 10, right: 10),
          width: 90,
          height: 33,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.black.withOpacity(0.6),width: 0.6)
              )
          ),
          child: DropdownButton(
            isExpanded: true,
            underline: Container(
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     width: 0,
              //     color: Colors.white,
              //   ),
              // ),
            ),

            // borderRadius: BorderRadius.circular(10),
            //icon: Image.asset('assets/images/photo.png'),
            elevation: 16,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
            value:controller. event_Type,
            onChanged: (String? newValue) {
              controller. event_Type = newValue!;
            },
            items:controller. list_Item
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),

      ],
    );
  }
}