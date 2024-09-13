import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';  // Import the intl package

import '../../modeles/event_media-model.dart';
import 'data_controller.dart';

abstract class EditEventController extends GetxController {
  Future<void> loadEventData(String eventId);
  void initalData();
  void updataEvent();
}

class EditEventControllerImp extends EditEventController {
  late String eventId;

  DateTime? date;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController maxEntries = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);
  String event_Type = 'Public';
  List<String> list_Item = ['Public', 'Private'];

  String accessModifier = 'Closed';
  List<String> close_list = ['Closed', 'Open'];

  var isCreatingEvent = false.obs;
  List<EventMediaModel> media = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    eventId = Get.arguments;
    loadEventData(eventId);
    super.onInit();
  }

  @override
  Future<void> loadEventData(String eventId) async {
    try {
      final dataController = Get.find<DataController>();
      var eventData = await dataController.getEventData(eventId);

      titleController.text = eventData['event_name'] ?? '';
      locationController.text = eventData['location'] ?? '';
      startTimeController.text = eventData['start_time'] ?? '';
      endTimeController.text = eventData['end_time'] ?? '';
      maxEntries.text = eventData['max_entries']?.toString() ?? '';
      tagsController.text = (eventData['theme'] as List<dynamic>?)?.join(', ') ?? '';
      descriptionController.text = eventData['description'] ?? '';
      
      // Parse the date with the correct format
      final dateFormat = DateFormat('d-M-yyyy');
      date = dateFormat.parse(eventData['date'] ?? dateFormat.format(DateTime.now()));
      dateController.text = dateFormat.format(date!);

      media.clear();
      if (eventData['media'] != null) {
        media.addAll(
          (eventData['media'] as List<dynamic>)
              .map((mediaItem) => EventMediaModel.fromMap(mediaItem as Map<String, dynamic>))
              .toList(),
        );
      }
      update();
    } catch (e) {
      print("Error loading event data: $e");
    }
  }

  @override
  void initalData() {
    // TODO: implement initalData
    throw UnimplementedError();
  }

  @override
  void updataEvent() {
    // TODO: implement updataEvent
    throw UnimplementedError();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      date = DateTime(picked.year, picked.month, picked.day, date?.hour ?? 0, date?.minute ?? 0, date?.second ?? 0);
      dateController.text = DateFormat('d-M-yyyy').format(date!);
      update();
    }
  }

  Future<void> startTimeMethod(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null) {
      startTime = picked;
      startTimeController.text =
          '${startTime.hourOfPeriod > 9 ? "" : '0'}${startTime.hour > 12 ? '${startTime.hour - 12}' : startTime.hour}:${startTime.minute > 9 ? startTime.minute : '0${startTime.minute}'} ${startTime.hour > 12 ? 'PM' : 'AM'}';
      update();
    }
  }

  Future<void> endTimeMethod(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (picked != null) {
      endTime = picked;
      endTimeController.text =
          '${endTime.hourOfPeriod > 9 ? "" : "0"}${endTime.hour > 9 ? "" : "0"}${endTime.hour > 12 ? '${endTime.hour - 12}' : endTime.hour}:${endTime.minute > 9 ? endTime.minute : '0${endTime.minute}'} ${endTime.hour > 12 ? 'PM' : 'AM'}';
      update();
    }
  }

  Future<void> mediaDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Media Type"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  imageDialog(context, true);
                },
                icon: const Icon(Icons.image),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  imageDialog(context, false);
                },
                icon: const Icon(Icons.slow_motion_video_outlined),
              ),
            ],
          ),
        );
      },
    );
  }

  RxList<Map<String, dynamic>> mediaUrls = <Map<String, dynamic>>[].obs;

  void imageDialog(BuildContext context, bool image) {
    showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Media Source"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  if (image) {
                    getImageDialog(ImageSource.gallery);
                  } else {
                    getVideoDialog(ImageSource.gallery);
                  }
                },
                icon: const Icon(Icons.image),
              ),
              IconButton(
                onPressed: () {
                  if (image) {
                    getImageDialog(ImageSource.camera);
                  } else {
                    getVideoDialog(ImageSource.camera);
                  }
                },
                icon: const Icon(Icons.camera_alt),
              ),
            ],
          ),
        );
      },
      context: context,
    );
  }

  Future<void> getImageDialog(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      media.add(EventMediaModel(
        image: File(image.path),
        video: null,
        isVideo: false
      ));
      update();
      Get.back();
    }
  }

  Future<void> getVideoDialog(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(source: source);

    if (video != null) {
      Uint8List? uint8list = await VideoThumbnail.thumbnailData(
        video: video.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );

      media.add(EventMediaModel(
        thumbnail: uint8list!,
        video: File(video.path),
        isVideo: true
      ));
      update();
      Get.back();
    }
  }
}
