import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Visiteur_Simple/discussion/chat_page.dart';

import 'package:firebase_auth/firebase_auth.dart';

class MessagesToAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Who Sent Messages'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('chat rooms')
            .where('users', arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No messages found.'));
          }

          final chatRooms = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              final chatRoom = chatRooms[index];
              final List<dynamic> users = chatRoom['users'];
              String otherUserId = users.firstWhere(
                  (userId) => userId != FirebaseAuth.instance.currentUser!.uid);

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('users').doc(otherUserId).get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return ListTile(
                      title: Text('Loading user...'),
                    );
                  }

                  final user = userSnapshot.data!;
                  return ListTile(
                    title: Text('${user['firstName']} ${user['lastName']}' ?? 'No Name'),
                    subtitle: Text(user['email'] ?? 'No Email'),
                    onTap: () {
                      // Navigate to chat with the user
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            chatRoomId: chatRoom.id,
                            adminUserId: otherUserId,
                            adminUserName: '${user['firstName']} ${user['lastName']}',
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
