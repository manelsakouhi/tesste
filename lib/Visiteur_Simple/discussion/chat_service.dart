import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste/modeles/message.dart';
import 'package:flutter/material.dart';


class ChatService extends ChangeNotifier {
  //get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//send message
Future<void> sendMessage(String receiverId, String message)async
{
  //get current user info
  final String currentUserId=_firebaseAuth.currentUser!.uid;
  final String currentUserEmail=_firebaseAuth.currentUser!.email.toString();
  final Timestamp timestamp = Timestamp.now();

  //create a new message
  Message newMessage =Message(
    receiverId: receiverId, 
    senderEmail: currentUserEmail, 
    senderId: currentUserId, 
    timestamp: timestamp, 
    message: message);

  //construct chat room id from current user id and receiver id(sorted to ensure uniquement)
List<String> ids=[currentUserId,receiverId];
ids.sort(); // sort the ids(this ensure the chat room id is always the same for any pair of people )
String chatRoomId=ids.join("_");// combine the ids into a single string to use as a chatroomId
 
  //add new message to database

  await _firestore.
  collection('chat rooms')
  .doc(chatRoomId).
  collection('message')
  .add(newMessage.toMap());
}


//get message
Stream<QuerySnapshot> getMessages(String userId, String otherUserId)
{
  //construct chat room id from user ids(sorted to ensure it matches the id used when sending message )
  List<String> ids =[userId,otherUserId];
  ids.sort();
  String chatroomId=ids.join("_");

  return _firestore
  .collection('chat room')
  .doc(chatroomId)
  .collection('messages')
  .orderBy('timestamp', descending: false)
  .snapshots();

}


}