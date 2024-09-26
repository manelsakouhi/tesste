import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Visiteur_Simple/discussion/chat_page.dart';


class AllUsersPage extends StatelessWidget {
  // Function to get users who have sent messages
  Future<List<QueryDocumentSnapshot>> _getUsersWhoSentMessages() async {
    // Get non-admin users
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isNotEqualTo: 'admin')
        .get();

    List<String> userIds = [];

    for (var user in userSnapshot.docs) {
      String userId = user.id;

      // Check if this user has sent any messages in the 'messages' sub-collection of 'chat rooms'
      QuerySnapshot messageSnapshot = await FirebaseFirestore.instance
          .collection('chat rooms') // Main collection
          .where('users', arrayContains: userId) // Adjust this to your needs
          .get();

      for (var room in messageSnapshot.docs) {
        QuerySnapshot messages = await room.reference
            .collection('messages')
            .where('senderId', isEqualTo: userId)
            .limit(1) // We only care if at least one message exists
            .get();

        if (messages.docs.isNotEmpty) {
          userIds.add(userId); // Add this user to the list if they have sent a message
        }
      }
    }

 

    // Fetch users who have sent messages
    if (userIds.isNotEmpty) {
      return (await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, whereIn: userIds)
          .get()).docs; // Return the list of documents directly
    } else {
      return []; // Return an empty list if no users have sent messages
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Messages'),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _getUsersWhoSentMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found who sent messages.'));
          }

          final users = snapshot.data!; // Now this is a list of user documents

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              String userId = user.id; // Ensure userId is valid
              String userName = '${user['firstName']} ${user['lastName']}';
              String role = user['role'] ?? 'No role';

              return ListTile(
                title: Text(userName.isNotEmpty ? userName : 'No Name'),
                subtitle: Text(role),
                onTap: () {
                  // Get current user's ID
                  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

                  if (currentUserId != null && userId.isNotEmpty) {
                    // Generate unique chatRoomId by sorting the user IDs
                    List<String> ids = [currentUserId, userId];
                    ids.sort(); // Sorting ensures consistency in room creation
                    String chatRoomId = ids.join("_");

                    // Navigate to ChatPage and pass chatRoomId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          chatRoomId: chatRoomId, // Pass the generated chatRoomId
                          adminUserId: userId,
                          adminUserName: userName,
                        ),
                      ),
                    );
                  } else {
                    // Handle case where userId is empty or current user is not authenticated
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid user ID or not authenticated')),
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
