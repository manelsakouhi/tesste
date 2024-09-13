// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../modeles/event_media-model.dart';

// abstract class EditEventController extends GetxController {}

// class EditEventControllerImp extends EditEventController {
//   final Map<String, dynamic> eventData;

//   EditEventControllerImp(this.eventData) {
//     _initializeFields();
//   }

//   DateTime? date;
//   TextEditingController dateController = TextEditingController();
//   TextEditingController timeController = TextEditingController();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController locationController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController tagsController = TextEditingController();
//   TextEditingController maxEntries = TextEditingController();
//   TextEditingController endTimeController = TextEditingController();
//   TextEditingController startTimeController = TextEditingController();
//   TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
//   TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);

//   var isCreatingEvent = false.obs;
//   List<EventMediaModel> media = [];

//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   void _initializeFields() {
//     date = DateTime.parse(eventData['date'] ?? DateTime.now().toIso8601String());

//     dateController.text = '${date!.day}-${date!.month}-${date!.year}';
//     timeController.text = '${date!.hour}:${date!.minute}:${date!.second}';
//     titleController.text = eventData['event_name'] ?? '';
//     locationController.text = eventData['location'] ?? '';
//     startTimeController.text = eventData['start_time'] ?? '';
//     endTimeController.text = eventData['end_time'] ?? '';
//     maxEntries.text = eventData['max_entries']?.toString() ?? '';
//     descriptionController.text = eventData['description'] ?? '';
//     tagsController.text = eventData['theme']?.join(', ') ?? '';
//     startTime = TimeOfDay(
//         hour: int.parse(eventData['start_time']?.split(':')[0] ?? '0'),
//         minute: int.parse(eventData['start_time']?.split(':')[1] ?? '0'));
//     endTime = TimeOfDay(
//         hour: int.parse(eventData['end_time']?.split(':')[0] ?? '0'),
//         minute: int.parse(eventData['end_time']?.split(':')[1] ?? '0'));

//     final mediaList = eventData['media'] as List<dynamic>?;
//     if (mediaList != null) {
//       media = mediaList.map((item) {
//         final mediaMap = item as Map<String, dynamic>;
//         if (mediaMap['isVideo'] == true) {
//           return EventMediaModel(
//               thumbnail: mediaMap['thumbnail'] != null
//                   ? Uint8List.fromList(List<int>.from(mediaMap['thumbnail']))
//                   : null,
//               video: File(mediaMap['url']),
//               isVideo: true);
//         } else {
//           return EventMediaModel(
//               image: File(mediaMap['url']),
//               video: null,
//               isVideo: false);
//         }
//       }).toList();
//     }
//   }

//  void updateEvent() async {
//   if (formKey.currentState?.validate() ?? false) {
//     try {
//       await FirebaseFirestore.instance.collection('events').doc(eventData['uid']).update({
//         'event': eventData['event'], // Update this field as needed
//         'event_name': titleController.text,
//         'location': locationController.text,
//         'date': '${date!.day}-${date!.month}-${date!.year}',
//         'start_time': startTimeController.text,
//         'end_time': endTimeController.text,
//         'max_entries': int.parse(maxEntries.text),
//         'description': descriptionController.text,
//         'media': media.map((m) => m.toMap()).toList(), // Using toMap here
//         'theme': tagsController.text.split(', '),
//         'who_can_invite': eventData['who_can_invite'], // Adjust if needed
//       });
//       Get.back(); // Go back after updating
//     } catch (e) {
//       print('Error updating event: $e');
//       Get.snackbar("Error", "Failed to update event: $e",
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }


//   void mediaDialog(BuildContext context) {
//     showDialog(
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Select Media Type"),
//             content: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       imageDialog(context, true);
//                     },
//                     icon: const Icon(Icons.image)),
//                 IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       imageDialog(context, false);
//                     },
//                     icon: const Icon(Icons.slow_motion_video_outlined)),
//               ],
//             ),
//           );
//         },
//         context: context);
//   }

//   void imageDialog(BuildContext context, bool image) {
//     showDialog(
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Media Source"),
//             content: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       if (image) {
//                         getImageDialog(ImageSource.gallery);
//                       } else {
//                         getVideoDialog(ImageSource.gallery);
//                       }
//                     },
//                     icon: const Icon(Icons.image)),
//                 IconButton(
//                     onPressed: () {
//                       if (image) {
//                         getImageDialog(ImageSource.camera);
//                       } else {
//                         getVideoDialog(ImageSource.camera);
//                       }
//                     },
//                     icon: const Icon(Icons.camera_alt)),
//               ],
//             ),
//           );
//         },
//         context: context);
//   }

//   Future<void> getImageDialog(ImageSource source) async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: source);

//     if (image != null) {
//       media.add(EventMediaModel(
//         image: File(image.path),
//         video: null,
//         isVideo: false
//       ));
//       update();
//       Get.back();
//     }
//   }

//   Future<void> getVideoDialog(ImageSource source) async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? video = await _picker.pickVideo(source: source);

//     if (video != null) {
//       Uint8List? uint8list = await VideoThumbnail.thumbnailData(
//         video: video.path,
//         imageFormat: ImageFormat.JPEG,
//         quality: 75,
//       );

//       media.add(EventMediaModel(
//         thumbnail: uint8list!,
//         video: File(video.path),
//         isVideo: true
//       ));
//       update();
//       Get.back();
//     }
//   }
// }
