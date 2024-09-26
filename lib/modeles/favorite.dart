import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Visiteur_Simple/events/event_view.dart';

class Favoris extends StatefulWidget {
  const Favoris({super.key});

  @override
  State<Favoris> createState() => _FavorisState();
}

class _FavorisState extends State<Favoris> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  late final Stream<List<DocumentSnapshot>> savedEventsStream;
  late final Future<DocumentSnapshot> userDocumentFuture;

  @override
  void initState() {
    super.initState();
    savedEventsStream = FirebaseFirestore.instance
        .collection('events')
        .where('saves', arrayContains: currentUserId)
        .snapshots()
        .map((snapshot) => snapshot.docs);

    // Fetch the current user's document snapshot
    userDocumentFuture = FirebaseFirestore.instance.collection('users').doc(currentUserId).get();
  }

  Future<void> _toggleSave(DocumentSnapshot eventData) async {
    final eventId = eventData.id;

    try {
      if (eventData['saves'].contains(currentUserId)) {
        await FirebaseFirestore.instance.collection('events').doc(eventId).update({
          'saves': FieldValue.arrayRemove([currentUserId])
        });
      } else {
        await FirebaseFirestore.instance.collection('events').doc(eventId).update({
          'saves': FieldValue.arrayUnion([currentUserId])
        });
      }
    } catch (e) {
      print('Error updating saves: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("36".tr),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: userDocumentFuture,
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (userSnapshot.hasError) {
            return Center(child: Text('Error: ${userSnapshot.error}'));
          }

          if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
            return Center(child: Text('User not found.'));
          }

          final userDocument = userSnapshot.data!;

          return StreamBuilder<List<DocumentSnapshot>>(
            stream: savedEventsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No saved events.'));
              }

              final events = snapshot.data!;

              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final eventData = events[index];
                  final event = eventData.data() as Map<String, dynamic>;
                  final eventName = event['event_name'] ?? 'No Name';
                  final location = event['location'] ?? 'Unknown Location';
                  final date = event['date'] ?? 'No Date';
                  final media = (event['media'] as List<dynamic>?) ?? [];
                  final eventImage = media.isNotEmpty && media[0]['isImage'] == true
                      ? media[0]['url']
                      : '';

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: eventImage.isNotEmpty
                          ? Image.network(eventImage, width: 80, fit: BoxFit.cover)
                          : Icon(Icons.event, size: 80),
                      title: Text(
                        eventName,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '$location\nDate: $date',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          event['saves'].contains(currentUserId)
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: event['saves'].contains(currentUserId)
                              ? Colors.red
                              : Colors.black,
                        ),
                        onPressed: () => _toggleSave(eventData),
                      ),
                      onTap: () {
                        // Navigate to EventPageView
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventPageView(
                              eventData.id,
                              userDocument,
                            ),
                          ),
                        );
                      },
                    ),
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
