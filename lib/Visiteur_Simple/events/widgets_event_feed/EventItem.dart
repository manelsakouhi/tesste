import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:teste/Visiteur_Simple/events/event_view.dart';
import 'package:teste/Visiteur_Simple/events/widgets_event_feed/buildCard.dart';
import 'package:teste/Visiteur_Simple/profil/profil.dart';

import '../../../Admin/controller/data_controller.dart';

Widget EventItem(DocumentSnapshot event) {
  DataController dataController = Get.find<DataController>();

  // Safely get the user matching the event's 'uid'
  DocumentSnapshot? user;
  try {
    user = dataController.allUsers.firstWhere(
      (e) => event.get('uid') == e.id, 
      orElse: () => null as DocumentSnapshot
    );
  } catch (e) {
    user = null;
  }

  // Safely get the user image
  String image = '';
  if (user != null && user.data() != null) {
    try {
      image = user.get('image') ?? '';
    } catch (e) {
      image = '';
    }
  }

  // Safely get the event image
  String eventImage = '';
  try {
    List media = event.get('media') as List;
    Map? mediaItem = media.firstWhere((element) => element['isImage'] == true, orElse: () => null);
    eventImage = mediaItem != null ? mediaItem['url'] : '';
  } catch (e) {
    eventImage = '';
  }

  // Safely get user 'first' and 'last' names
  String firstName = '';
  String lastName = '';
  if (user != null && user.data() != null) {
    try {
      firstName = user.get('firstName') ?? '';
      lastName = user.get('lastName') ?? '';
    } catch (e) {
      firstName = '';
      lastName = '';
    }
  }

  return Column(
    children: [
      Row(
        children: [
          InkWell(
            onTap: () {
              // Get.to(() => const ProfilPage());
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              backgroundImage: image.isNotEmpty
                  ? CachedNetworkImageProvider(image)
                  : null,
              child: image == ""
                  ? Center(
                      child: Text(
                        firstName.isNotEmpty ? firstName[0] : '',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  : null,
            ),
          ),
          SizedBox(width: 12),
          Text(
            '$firstName $lastName',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ],
      ),
      SizedBox(height: Get.height * 0.01),
      buildCard(
        image: eventImage,
        text: event.get('event_name'),
        eventData: event,
        func: () {
          Get.to(() => EventPageView(event.id, user!));
        },
      ),
      SizedBox(height: 15),
    ],
  );
}
