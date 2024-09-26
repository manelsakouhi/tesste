import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Visiteur_Simple/discussion/chat_page.dart';



class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .doc(userId) // Get notifications for the current user
            .collection('myNotifications')
            .orderBy('timestamp', descending: true) // Order by timestamp
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No notifications yet.'));
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index].data() as Map<String, dynamic>; // Cast to Map
              final message = notification['message'] ?? 'No message'; // Use a default message
              final senderEmail = notification['senderEmail'] ?? 'Unknown'; // Default sender email
              final senderName = notification['senderName'] ?? 'Unknown';
              
              final chatRoomId = notification['chatRoomId']; // Ensure this exists
              // final receiverId = notification.containsKey('receiverId') ? notification['receiverId'] : null; // Check if receiverId exists
              final receiverId = notification['senderId'] ; 
              final timestamp = notification['timestamp'].toDate();

              return _buildNotificationTile(context, message, senderName, timestamp, chatRoomId, receiverId);
            },
          );
        },
      ),
    );
  }

  Widget _buildNotificationTile(BuildContext context, String message, String senderName, DateTime timestamp, String chatRoomId, String? receiverId) {
    return ListTile(
      title:Text('From: $senderName') ,
      subtitle:Text("$message \n${_formatTimestamp(timestamp)}") ,
      trailing: Icon(Icons.notifications),
      onTap: () {
       
        if (receiverId != null) { // Only navigate if receiverId exists
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                chatRoomId: chatRoomId, // Pass the chatRoomId
                adminUserId: receiverId, // Assuming receiverId is the adminUserId
                adminUserName: senderName, // You can pass the senderEmail as the name
              ),
            ),
          );
        } else {
          // Handle case where receiverId is missing (optional)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Receiver ID not found.')),
          );
        }
      },
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    if (timestamp.year == now.year && timestamp.month == now.month && timestamp.day == now.day) {
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.month}/${timestamp.day}/${timestamp.year}';
    }
  }
}
