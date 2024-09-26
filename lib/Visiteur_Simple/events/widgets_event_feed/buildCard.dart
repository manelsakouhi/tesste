import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Admin/controller/data_controller.dart';
import '../../../Admin/utils/app_color.dart';

Widget buildCard({String? image, String? text, Function? func, DocumentSnapshot? eventData}) {
  DataController dataController = Get.find<DataController>();
  List joinedUsers = [];
  
  // Safely try to get the joined users
  try {
    joinedUsers = eventData!.get('joined');
  } catch (e) {
    joinedUsers = [];
  }

  List dateInformation = [];
  
  // Safely try to get the event date information
  try {
    dateInformation = eventData!.get('date').toString().split('-');
  } catch (e) {
    dateInformation = [];
  }

  int comments = 0;
  List userLikes = [];
  
  // Safely try to get likes and comments information
  try {
    userLikes = eventData!.get('likes');
  } catch (e) {
    userLikes = [];
  }
  try {
    comments = eventData!.get('comments').length;
  } catch (e) {
    comments = 0;
  }

  List eventSavedByUsers = [];
  
  // Safely try to get saved event information
  try {
    eventSavedByUsers = eventData!.get('saves');
  } catch (e) {
    eventSavedByUsers = [];
  }

  // Define a placeholder image URL for fallback
  String placeholderImage = 'https://www.shutterstock.com/shutterstock/photos/1955339317/display_1500/stock-vector-no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-1955339317.jpg'; // Replace with your actual placeholder image URL
  

  return Container(
    padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(17),
      boxShadow: [
        BoxShadow(
          color: Color(0x393939).withOpacity(0.15),
          spreadRadius: 0.1,
          blurRadius: 2,
          offset: Offset(0, 0), // Position of the shadow
        ),
      ],
    ),
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            func!();
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image?.isNotEmpty == true ? image! : placeholderImage), // Fallback to placeholder
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: Get.width * 0.5,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 41,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xffADD8E6)),
                ),
                child: Text(
                  '${dateInformation.isNotEmpty ? dateInformation[0] : ''}-${dateInformation.length > 1 ? dateInformation[1] : ''}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Text(
                text ?? '',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const Spacer(),
               Row(
          children: [
            const SizedBox(width: 68),
            InkWell(
              onTap: () {
                //dislike
                if (userLikes.contains(FirebaseAuth.instance.currentUser!.uid)) {
                  FirebaseFirestore.instance.collection('events').doc(eventData!.id).set({
                    'likes': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
                  }, SetOptions(merge: true));
                //like
                } else {
                  FirebaseFirestore.instance.collection('events').doc(eventData!.id).set({
                    'likes': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
                  }, SetOptions(merge: true));
                }
              },


              child: Container(
                width: 16,
                  height: 19,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffD24698).withOpacity(0.02),
                    ),
                  ],
                ),
                child: Icon(
                 userLikes.contains(FirebaseAuth.instance.currentUser!.uid) ? Icons.favorite : Icons.favorite_border_outlined,
                  // size: 14,
                  color: userLikes.contains(FirebaseAuth.instance.currentUser!.uid)
                      ? Colors.red
                      : Colors.black,
                ),
              )
            ),
            const SizedBox(width: 10),
            Text(
              '${userLikes.length}',
              style:  TextStyle(
color: AppColors.black,
                // fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            
          ],
        ),
              InkWell(
                onTap: () {
                  if (eventSavedByUsers.contains(FirebaseAuth.instance.currentUser!.uid)) {
                    FirebaseFirestore.instance.collection('events').doc(eventData!.id).set({
                      'saves': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
                    }, SetOptions(merge: true));
                  } else {
                    FirebaseFirestore.instance.collection('events').doc(eventData!.id).set({
                      'saves': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
                    }, SetOptions(merge: true));
                  }
                },
                child: Container(
                  width: 16,
                  height: 19,
                  child: Icon(
                    Icons.bookmark,
                    color: eventSavedByUsers.contains(FirebaseAuth.instance.currentUser!.uid)
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: Get.width * 0.6,
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: joinedUsers.length,
                itemBuilder: (ctx, index) {
                  DocumentSnapshot? user = dataController.allUsers.isNotEmpty
                      ? dataController.allUsers.firstWhere(
                          (e) => e.id == joinedUsers[index],
                          orElse: () => dataController.allUsers.first,
                        )
                      : null;

                  String userImage = '';
                  if (user != null) {
                    try {
                      userImage = user.get('image');
                    } catch (e) {
                      userImage = '';
                    }
                  }

                  return Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      minRadius: 13,
                      backgroundImage: NetworkImage(userImage.isNotEmpty ? userImage : placeholderImage), // Fallback to placeholder
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        //look at message
        // SizedBox(height: Get.height * 0.03),
       
      ],
    ),
  );
}
