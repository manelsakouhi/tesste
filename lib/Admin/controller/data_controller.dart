import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;

class DataController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  DocumentSnapshot? myDocument;

  var allUsers = <DocumentSnapshot>[].obs;
  var filteredUsers = <DocumentSnapshot>[].obs;
  var allEvents = <DocumentSnapshot>[].obs;
  var filteredEvents = <DocumentSnapshot>[].obs;
  var joinedEvents = <DocumentSnapshot>[].obs;

  var isEventsLoading = false.obs;
  var isUsersLoading = false.obs;

  // Search query
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getMyDocument();
    getUsers();
    getEvents();
  }

  getMyDocument() {
    FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid)
        .snapshots().listen((event) {
          myDocument = event;
    });
  }

  getUsers() {
    isUsersLoading(true);
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      allUsers.value = event.docs;
      filteredUsers.value.assignAll(allUsers);
      isUsersLoading(false);
    });
  }

  getEvents() {
    isEventsLoading(true);
    FirebaseFirestore.instance.collection('events').snapshots().listen((event) {
      allEvents.assignAll(event.docs);
      filteredEvents.assignAll(event.docs);

      joinedEvents.value = allEvents.where((e) {
        List joinedIds = e.get('joined');
        return joinedIds.contains(FirebaseAuth.instance.currentUser!.uid);
      }).toList();

      isEventsLoading(false);
    });
  }

  // Fetch event data by eventId
  Future<Map<String, dynamic>> getEventData(String eventId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('events').doc(eventId).get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception('Event not found');
      }
    } catch (e) {
      print("Error fetching event data: $e");
      throw e; // Propagate the error to handle it elsewhere
    }
  }

  // Update search query and filter events
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterEvents();
  }

  // Filter events based on the search query
   void filterEvents() {
    String query = searchQuery.value.toLowerCase();
    filteredEvents.value = allEvents.where((event) {
      String eventName = event.get('event_name').toLowerCase();
      bool matchesName = eventName.contains(query);

      // Parse the date
      DateTime now = DateTime.now();
      String dateStr = event.get('date');
      DateTime eventDate;

      try {
        eventDate = DateFormat('dd-MM-yyyy').parse(dateStr);
      } catch (e) {
        // Handle parsing error (e.g., log it or default to a specific date)
        eventDate = DateTime.now().subtract(Duration(days: 1)); // Example fallback
      }

      bool isUpcoming = eventDate.isAfter(now);

      return matchesName && isUpcoming;
    }).toList();
  }

  Future<String> uploadImageToFirebase(File file) async {
    String fileUrl = '';
    String fileName = Path.basename(file.path);
    var reference = FirebaseStorage.instance.ref().child('myfiles/$fileName');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      fileUrl = value;
    });
    print("Url $fileUrl");
    return fileUrl;
  }

  Future<String> uploadThumbnailToFirebase(Uint8List file) async {
    String fileUrl = '';
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference = FirebaseStorage.instance.ref().child('myfiles/$fileName.jpg');
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      fileUrl = value;
    });
    print("Thumbnail $fileUrl");
    return fileUrl;
  }

  Future<bool> createEvent(Map<String, dynamic> eventData) async {
    bool isCompleted = false;
    await FirebaseFirestore.instance.collection('events')
        .add(eventData)
        .then((value) {
      isCompleted = true;
      Get.snackbar('Event Uploaded', 'Event is uploaded successfully.',
          colorText: Colors.white, backgroundColor: Colors.blue);
    }).catchError((e) {
      isCompleted = false;
    });
    return isCompleted;
  }

  // Send message to Firebase (existing method)
  var isMessageSending = true.obs;
  sendMessageToFirebase({
    Map<String, dynamic>? data,
    String? lastMessage,
    String? groupId
  }) async {
    isMessageSending(true);
    await FirebaseFirestore.instance.collection('chats').doc(groupId).collection('chatroom').add(data!);
    await FirebaseFirestore.instance.collection('chats').doc(groupId).set({
      'lastMessage': lastMessage,
      'groupId': groupId,
      'group': groupId!.split('-'),
    }, SetOptions(merge: true));
    isMessageSending(false);
  }

  // Create notification (existing method)
  createNotification(String recUid) {
    FirebaseFirestore.instance.collection('notifications').doc(recUid).collection('myNotifications').add({
      'message': "Send you a message.",
      'image': myDocument!.get('image'),
      'name': myDocument!.get('firstName') + " " + myDocument!.get('lastName'),
      'time': DateTime.now()
    });
  }

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> updateEvent(String eventId, Map<String, dynamic> eventData) async {
    try {
      final eventRef = _firestore.collection('events').doc(eventId);

      await eventRef.update(eventData);

      print("Event updated successfully");
    } catch (e) {
      print("Error updating event: $e");
      throw e; // Rethrow to handle in the UI
    }
  }
}
