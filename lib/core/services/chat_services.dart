// services/chat_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste/modeles/message.dart';
import 'package:flutter/material.dart';

const String adminEmail = 'manelkhalid@gmail.com';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send a message to the specified receiver
  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
      receiverId: receiverId,
      senderEmail: currentUserEmail,
      senderId: currentUserId,
      timestamp: timestamp,
      message: message,
    );

    // Build the chat room ID
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // Add the message to Firestore
    await _firestore
        .collection('chat rooms')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());
  }

  // Get messages between the current user and another user
  Stream<QuerySnapshot> getMessages(String otherUserId) {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat rooms')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .handleError((error) {
          if (error.toString().contains('requires an index')) {
            // Handle index error
            print('Index required: Please create the index in Firebase Console.');
          }
        });
  }
}
