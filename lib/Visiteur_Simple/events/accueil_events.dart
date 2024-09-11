import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Admin/controller/data_controller.dart';
import 'widgets_event_feed/EventsFeed.dart';
import 'widgets_event_feed/EventsIJoined.dart';

class EventsView extends StatefulWidget {
  @override
  _EventsViewState createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  DataController dataController = Get.find<DataController>();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      dataController.updateSearchQuery(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),

      ),
      //backgroundColor: Colors.black.withOpacity(0.03),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "What's Going on Today",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: Get.height * 0.02),
                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search events...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                // Events Feed
                EventsFeed(),
                Obx(() => dataController.isUsersLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : EventsIJoined()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
