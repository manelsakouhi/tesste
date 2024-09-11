import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Admin/controller/data_controller.dart';

class Custom5 extends StatefulWidget {
  final DocumentSnapshot eventData;
  final DocumentSnapshot user;

  Custom5(this.eventData, this.user);

  @override
  State<Custom5> createState() => _Custom5State();
}

class _Custom5State extends State<Custom5> {
  final DataController dataController = Get.find<DataController>();
  late final String currentUserId;
  late final Stream<DocumentSnapshot> eventStream;

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
    eventStream = FirebaseFirestore.instance.collection('events').doc(widget.eventData.id).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: eventStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Event not found'));
        }

        final eventData = snapshot.data!;
        final userLikes = List<String>.from(eventData.get('likes') ?? []);
        final eventSavedByUsers = List<String>.from(eventData.get('saves') ?? []);
        final likes = userLikes.length;
        // final comments = List.from(eventData.get('comments') ?? []).length ;
        final comments = 0;

        final isLiked = userLikes.contains(currentUserId);
        final isSaved = eventSavedByUsers.contains(currentUserId);

        return Row(
          children: [
            GestureDetector(
              onTap: () async {
                if (isLiked) {
                  await FirebaseFirestore.instance.collection('events').doc(widget.eventData.id).update({
                    'likes': FieldValue.arrayRemove([currentUserId]),
                  });
                } else {
                  await FirebaseFirestore.instance.collection('events').doc(widget.eventData.id).update({
                    'likes': FieldValue.arrayUnion([currentUserId]),
                  });
                }
              },
              child: Icon(
                Icons.favorite,
                color: isLiked ? Colors.red : Colors.black,
              ),
            ),
            SizedBox(width: 10),
            Text(
              likes.toString(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            // SizedBox(width: 10),
            // Icon(Icons.message),
            // SizedBox(width: 10),
            // Text(
            //   comments.toString(),
            //   style: TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // SizedBox(width: 10),
            // Icon(Icons.send),
            Spacer(),
            InkWell(
              onTap: () async {
                if (isSaved) {
                  await FirebaseFirestore.instance.collection('events').doc(widget.eventData.id).update({
                    'saves': FieldValue.arrayRemove([currentUserId]),
                  });
                } else {
                  await FirebaseFirestore.instance.collection('events').doc(widget.eventData.id).update({
                    'saves': FieldValue.arrayUnion([currentUserId]),
                  });
                }
              },
              child: Icon(
                Icons.bookmark,
                color: isSaved ? Colors.red : Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
