import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/Admin/widgets_create_events/description_andInvite_section.dart';

import '../../controller/edit_event_controller_test.dart';
import '../../widgets_create_events/my_widgets.dart';
import 'description_andInvite_section.dart';
import 'edit_description.dart';



class EditCustomTextFormList extends GetView<EditEventControllerImp> {
  const EditCustomTextFormList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context) ;
    return Column(
      children: [
        myTextField(
            // bool: false,
            icon: 'assets/images/photo.png',
            text: 'Event Name',
            controller: controller.titleController,
            validator: (String input) {
              if (input.isEmpty) {
                Get.snackbar('Opps', "Event name is required.",
                    colorText: Colors.white, backgroundColor: Colors.blue);
                return '';
              }

              if (input.length < 3) {
                Get.snackbar('Opps', "Event name is should be 3+ characters.",
                    colorText: Colors.white, backgroundColor: Colors.blue);
                return '';
              }
              return null;
            }),
     const SizedBox(
                  height: 20,
                ),
                myTextField(
                    // bool: false,
                    icon: 'assets/images/photo.png',
                    text: 'Location',
                    controller:controller. locationController,
                    validator: (String input) {
                      if (input.isEmpty) {
                        Get.snackbar('Opps', "Location is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }

                      if (input.length < 3) {
                        Get.snackbar('Opps', "Location is Invalid.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                      return null;
                    }),
     const  SizedBox(
                  height: 20,
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconTitleContainer(
                      isReadOnly: true,
                      path: 'assets/images/photo.png',
                      text: 'Date',
                      controller:controller. dateController,
                      validator: (input) {
                        if (controller. date == null) {
                          Get.snackbar('Opps', "Date is required.",
                              colorText: Colors.white,
                              backgroundColor: Colors.blue);
                          return '';
                        }
                        return null;
                      },
                      onPress: () {
                       controller. selectDate(context);
                      },
                    ),
                    iconTitleContainer(
                        path: 'assets/images/photo.png',
                        text: 'Max Entries',
                        controller:controller. maxEntries,
                        type: TextInputType.number,
                        onPress: () {},
                        validator: (String input) {
                          if (input.isEmpty) {
                            Get.snackbar('Opps', "Entries is required.",
                                colorText: Colors.white,
                                backgroundColor: Colors.blue);
                            return '';
                          }
                          return null;
                        }),
                  ],
                ),
               const SizedBox(
                  height: 20,
                ),

                 iconTitleContainer(
               
                    path: 'assets/images/photo.png',
                    text: 'Enter event theme ',
                    width: double.infinity,
                    controller:controller. tagsController,
                    type: TextInputType.text,
                    onPress: () {},
                    validator: (String input) {
                      if (input.isEmpty) {
                        Get.snackbar('Opps', "Entries is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                      return null;
                    }),

              
                 

                
                const  SizedBox(
                  height: 20,
                ),
      Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconTitleContainer(
                     
                        path: 'assets/images/photo.png',
                        text: 'Start Time',
                        controller:controller. startTimeController,
                        isReadOnly: true,
                        validator: (input) {},
                        onPress: () {
                         controller. startTimeMethod(context);
                        }),
                    iconTitleContainer(
                    
                        path: 'assets/images/photo.png',
                        text: 'End Time',
                        isReadOnly: true,
                        controller: controller.endTimeController,
                        validator: (input) {},
                        onPress: () {
                         controller. endTimeMethod(context);
                        }),
                  ],
                ),
              const  SizedBox(
                  height: 20,
                ),
      
      ],
    );
  }
}
