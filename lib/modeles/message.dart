import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String receiverId;
  final String senderEmail; // Email du visiteur ou de l'utilisateur
  final String senderId; // ID de l'utilisateur ou ID temporaire pour les visiteurs
  final Timestamp timestamp;
  final String message;

  Message({
    required this.receiverId,
    required this.senderEmail,
    required this.senderId,
    required this.timestamp,
    required this.message,
  });

  // Convertir le message en map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'receiverId': receiverId,
      'senderEmail': senderEmail,
      'senderId': senderId,
      'timestamp': timestamp,
      'message': message,
    };
  }

  // Convertir un map en message
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      receiverId: map['receiverId'],
      senderEmail: map['senderEmail'],
      senderId: map['senderId'],
      timestamp: map['timestamp'],
      message: map['message'],
    );
  }
}
