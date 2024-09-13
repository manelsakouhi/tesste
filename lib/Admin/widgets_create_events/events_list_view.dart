import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste/core/constant/approutes.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key});

  // Function to delete a document from Firestore
  Future<void> deleteEvent(String eventId) async {
    try {
      // Reference to the Firestore collection
      final eventDocRef = FirebaseFirestore.instance.collection('events').doc(eventId);
      
      // Delete the document
      await eventDocRef.delete();
      
      // Show a success message
      Get.snackbar(
        'Success',
        'Event deleted successfully.',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } catch (e) {
      print("Error deleting event: $e");
      
      // Show an error message
      Get.snackbar(
        'Error',
        'Failed to delete event: $e',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoute.createEventView);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No events found.'));
          } else {
            final events = snapshot.data!.docs;

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final eventDoc = events[index];
                final eventData = eventDoc.data() as Map<String, dynamic>;
                final eventId = eventDoc.id; // Get the document ID

                // Extract the image URL from the media list
                final mediaList = eventData['media'] as List<dynamic>?;

                String? imageUrl;
                if (mediaList != null) {
                  for (var mediaItem in mediaList) {
                    final mediaMap = mediaItem as Map<String, dynamic>;
                    if (mediaMap['isImage'] == true) {
                      imageUrl = mediaMap['url'] as String?;
                      break; // Found the image URL, no need to continue
                    }
                  }
                }

                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      AppRoute.editEventView,
                      arguments: eventId, // Pass the event ID to the edit page
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: imageUrl != null
                          ? Image.network(
                              imageUrl!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.image, size: 50), // Placeholder icon if no image
                      title: Text(eventData['event_name'] ?? 'No Title'),
                      subtitle: Text(eventData['location'] ?? 'No Location'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.toNamed(
                                AppRoute.editEventView,
                                arguments: eventId, // Pass the event ID to the edit page
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () {
                              // Confirm deletion
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete Event'),
                                    content: const Text('Are you sure you want to delete this event?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Cancel
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Confirm
                                          deleteEvent(eventId);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
