import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/Admin/controller/data_controller.dart';
import 'EventItem.dart';

Widget EventsFeed() {
  DataController dataController = Get.find<DataController>();

  return Obx(() {
    if (dataController.isEventsLoading.value) {
      return Center(child: CircularProgressIndicator());
    } else {
      // Filter events that haven't started yet
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: dataController.filteredEvents.length,
        itemBuilder: (ctx, i) {
          return EventItem(dataController.filteredEvents[i]);
        },
      );
    }
  });
}
