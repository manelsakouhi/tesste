import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Admin/controller/data_controller.dart';
import '../../../Admin/widgets_create_events/my_widgets.dart';



class CustomButtonJoin extends GetView<CustomButtonJoin> {
  const CustomButtonJoin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
        Get.put(DataController());

    
    return  SizedBox(
           height: 42,
           width: double.infinity,
           child: elevatedButton(
             onpress: () async {  
             },
             text: 'Join Now'),
         );

         
  }
}
