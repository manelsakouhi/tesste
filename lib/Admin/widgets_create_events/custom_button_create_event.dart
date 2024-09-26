import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/create_event_controller.dart';
import '../controller/data_controller.dart';
import 'my_widgets.dart';

class CustomButtonCreateEvent extends GetView<CreateEventControllerImp> {
  const CustomButtonCreateEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return Obx(() => controller.isCreatingEvent.value
       ? const Center(
            child: CircularProgressIndicator(),
         )
       : SizedBox(
           height: 42,
           width: double.infinity,
           child: elevatedButton(
             onpress: () async {
               if (!controller.formKey.currentState!.validate()) {
                 return;
               }

               if (controller.media.isEmpty) {
                 Get.snackbar('Oops', "Media is required.",
                   colorText: Colors.white,
                   backgroundColor: Colors.blue
                 );
                 return;
               }

               if (controller.tagsController.text.isEmpty) {
                 Get.snackbar('Oops', "Tags are required.",
                   colorText: Colors.white,
                   backgroundColor: Colors.blue
                 );
                 return;
               }

               controller.isCreatingEvent(true);
               DataController dataController = Get.find();

               try {
                 // Handle media uploads
                 if (controller.media.isNotEmpty) {
                   for (int i = 0; i < controller.media.length; i++) {
                     if (controller.media[i].isVideo!) {
                       String thumbnailUrl = await dataController.uploadThumbnailToFirebase(controller.media[i].thumbnail!);
                       String videoUrl = await dataController.uploadImageToFirebase(controller.media[i].video!);

                       controller.mediaUrls.add({
                         'url': videoUrl,
                         'thumbnail': thumbnailUrl,
                         'isImage': false
                       });
                     } else {
                       String imageUrl = await dataController.uploadImageToFirebase(controller.media[i].image!);
                       controller.mediaUrls.add({
                         'url': imageUrl,
                         'isImage': true
                       });
                     }
                   }
                 }

                 // Split tags
                 List<String> tags = controller.tagsController.text.split(',');

                 // Prepare event data
                 Map<String, dynamic> eventData = {
                   'event': controller.event_Type,
                   'event_name': controller.titleController.text,
                   'location': controller.locationController.text,
                   'date': '${controller.date!.day}-${controller.date!.month}-${controller.date!.year}',
                   'start_time': controller.startTimeController.text,
                   'end_time': controller.endTimeController.text,
                   'max_entries': int.parse(controller.maxEntries.text),
                   'description': controller.descriptionController.text,
                  // 'who_can_invite': controller.accessModifier,
                   'joined': [FirebaseAuth.instance.currentUser!.uid],
                   'media': controller.mediaUrls,
                   'uid': FirebaseAuth.instance.currentUser!.uid,
                   'theme': tags,
                   'inviter': [FirebaseAuth.instance.currentUser!.uid]
                 };

                 // Save event to Firebase
                 await dataController.createEvent(eventData).then((value) {
                   print("Event created successfully");
                   controller.isCreatingEvent(false);
                   controller.resetControllers();
                 }).catchError((error) {
                   print("Failed to create event: $error");
                   Get.snackbar('Error', "Failed to create event. Try again later.",
                     colorText: Colors.white,
                     backgroundColor: Colors.red);
                   controller.isCreatingEvent(false);
                 });

               } catch (e) {
                 print("Error occurred: $e");
                 Get.snackbar('Error', "An error occurred while creating the event.",
                   colorText: Colors.white,
                   backgroundColor: Colors.red);
                 controller.isCreatingEvent(false);
               }
             },
             text: 'Create Event'),
         ));
  }
}
