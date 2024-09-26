import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Visiteur_Simple/discussion/chat_page.dart';


class AdminUsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Users'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'admin')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          final adminUsers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: adminUsers.length,
            itemBuilder: (context, index) {
              final user = adminUsers[index];
              final firstName = user['firstName'] ?? 'No Name';
              final lastName = user['lastName'] ?? '';
              final role = user['role'] ?? 'No role';

              return ListTile(
                title: Text('$firstName $lastName'),
                subtitle: Text(role),
                onTap: () async {
                  try {
                    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
                    final String adminUserId = user.id;

                    // Sort the IDs to generate a consistent chat room ID
                    List<String> ids = [currentUserId, adminUserId];
                    ids.sort();
                    String chatRoomId = ids.join("_");

                    // Check if the chat room exists, if not create one
                    final chatRoomRef = FirebaseFirestore.instance.collection('chat rooms').doc(chatRoomId);
                    final chatRoomSnapshot = await chatRoomRef.get();

                    if (!chatRoomSnapshot.exists) {
                      await chatRoomRef.set({
                        'users': [currentUserId, adminUserId],
                        'createdAt': Timestamp.now(),
                      });
                    }

                    // Safely navigate after async operation
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            chatRoomId: chatRoomId,
                            adminUserId: adminUserId,
                            adminUserName: '$firstName $lastName',
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error creating chat room: $e')),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
