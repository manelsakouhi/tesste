import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomOne extends StatefulWidget {
  final DocumentSnapshot eventData;
  final DocumentSnapshot user;

  CustomOne(this.eventData, this.user);

  @override
  State<CustomOne> createState() => _CustomOneState();
}

class _CustomOneState extends State<CustomOne> {
  @override
  Widget build(BuildContext context) {
    // Get the user image
    String image = '';
    try {
      image = widget.user.get('image') ?? '';
    } catch (e) {
      image = '';
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

    // Get user names and location
    String firstName = '';
    String lastName = '';
    String location = '';
    try {
      firstName = widget.user.get('firstName') ?? '';
      lastName = widget.user.get('lastName') ?? '';
      location = widget.user.get('location') ?? '';
    } catch (e) {
      firstName = '';
      lastName = '';
      location = '';
    }

    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.blue,
          backgroundImage: image.isNotEmpty
              ? CachedNetworkImageProvider(image)
              : null,
          child: image.isEmpty
              ? Center(
                  child: Text(
                    firstName.isNotEmpty ? firstName[0] : '',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              : null,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$firstName $lastName',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 2),
            Text(
              location,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Text(
                widget.eventData.get('event') ?? '',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    );
  }
}
