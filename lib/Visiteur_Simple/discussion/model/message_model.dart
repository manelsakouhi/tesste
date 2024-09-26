// models/message.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String receiverId;
  final String senderEmail;
  final String senderId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.receiverId,
    required this.senderEmail,
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'receiverId': receiverId,
      'senderEmail': senderEmail,
      'senderId': senderId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
