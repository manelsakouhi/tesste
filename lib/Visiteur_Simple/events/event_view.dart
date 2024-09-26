import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Admin/controller/data_controller.dart';
import 'widgets_event_view/custom_three.dart';
import 'widgets_event_view/join.dart';
import 'widgets_event_view/custom_4.dart';
import 'widgets_event_view/custom_5.dart';
import 'widgets_event_view/custom_one.dart';
import 'widgets_event_view/custom_two.dart';

class EventPageView extends StatelessWidget {
  final String eventId;  // Event ID to listen to Firestore updates
  final DocumentSnapshot user;  // Current user document

  EventPageView(this.eventId, this.user);

  final DataController dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    // Firestore reference to the event document
    final eventRef = FirebaseFirestore.instance.collection('events').doc(eventId);

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: eventRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for data
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Show an error message if there is an error
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            // Show a message if the document does not exist
            return Center(child: Text('Event not found'));
          }

          final eventData = snapshot.data!;

          // Extract event image URL
          String eventImage = '';
          try {
            List media = eventData.get('media') as List;
            Map mediaItem = media.firstWhere((element) => element['isImage'] == true, orElse: () => {} as Map);
            eventImage = mediaItem['url'] ;
          } catch (e) {
            eventImage = '';
          }

          // Extract tags
          List tags = [];
          try {
            tags = eventData.get('tags') as List;
          } catch (e) {
            tags = [];
          }

          // Create a string of tags
          String tagsCollectively = tags.map((e) => '#$e').join(' ');

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      width: 30,
                      height: 30,
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  CustomOne(eventData, user),
                  const SizedBox(height: 15),
                  custom_2(eventData, user),
                  const SizedBox(height: 10),
                  custom_3(eventData, user),
                  const SizedBox(height: 10),
                  // Use CachedNetworkImage here
                  Container(
                    height: 190,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(eventImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Custom4(eventData, user),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: eventData.get('description') ?? '',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // inviteFriend(),
                      SizedBox(width: 10),
                      Join(eventData),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          tagsCollectively,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Custom5(eventData, user),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
