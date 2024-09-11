import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../Admin/controller/data_controller.dart';

class Custom4 extends StatefulWidget {
  final DocumentSnapshot eventData;
  final DocumentSnapshot user;

  Custom4(this.eventData, this.user);

  @override
  State<Custom4> createState() => _Custom4State();
}

class _Custom4State extends State<Custom4> {
  DataController dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    // Get the user image
    String userImage = '';
    try {
      userImage = widget.user.get('image') ?? '';
    } catch (e) {
      userImage = '';
    }

    // Get the event image
    String eventImage = '';
    try {
      List media = widget.eventData.get('media') as List;
      Map mediaItem = media.firstWhere(
        (element) => element['isImage'] == true,
        orElse: () => {} as Map,
      );
      eventImage = mediaItem['url'] ?? '';
    } catch (e) {
      eventImage = '';
    }

    // Get the list of joined users
    List joinedUsers = [];
    try {
      joinedUsers = widget.eventData.get('joined') as List;
    } catch (e) {
      joinedUsers = [];
    }

    return Container(
      child: Row(
        children: [
          Container(
            width: Get.width * 0.6,
            height: 50,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                DocumentSnapshot user = dataController.allUsers.firstWhere(
                  (e) => e.id == joinedUsers[index],
                  orElse: () => null as DocumentSnapshot,
                );

                String image = '';
                String firstName = '';
                if (user != null) {
                  try {
                    image = user.get('image') ?? '';
                    firstName = user.get('firstName') ?? '';
                  } catch (e) {
                    image = '';
                    firstName = '';
                  }
                }

                return Container(
                  margin: EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    minRadius: 13,
                    backgroundColor: Colors.blue,
                    backgroundImage: image.isNotEmpty
                        ? CachedNetworkImageProvider(image)
                        : null,
                    child: image.isEmpty
                        ? Center(
                            child: Text(
                              firstName.isNotEmpty ? firstName[0] : '',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )
                        : null,
                  ),
                );
              },
              itemCount: joinedUsers.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${widget.eventData.get('max_entries')} spots left!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
