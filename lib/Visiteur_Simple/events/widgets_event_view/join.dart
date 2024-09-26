import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date/time formatting and parsing
import 'package:firebase_auth/firebase_auth.dart';

class Join extends StatefulWidget {
  final DocumentSnapshot eventData;

  Join(this.eventData);

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isJoined = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkIfJoined();
  }

  Future<void> _checkIfJoined() async {
    String userId = _auth.currentUser!.uid;
    List<String> joined = List<String>.from(widget.eventData['joined'] ?? []);

    setState(() {
      _isJoined = joined.contains(userId);
    });
  }

  Future<void> _toggleJoinStatus() async {
    String userId = _auth.currentUser!.uid;
    String eventId = widget.eventData.id;

    DocumentReference eventRef = _firestore.collection('events').doc(eventId);
    DocumentSnapshot eventSnapshot;

    try {
      // Show loading indicator
      setState(() {
        _isLoading = true;
      });

      // Fetch event data
      eventSnapshot = await eventRef.get();
      if (!eventSnapshot.exists) {
        throw Exception("Event does not exist.");
      }

      // Get the event data from the snapshot
      Map<String, dynamic> eventData =
          eventSnapshot.data() as Map<String, dynamic>;
      List<String> joined = List<String>.from(eventData['joined'] ?? []);
      int maxEntries = eventData['max_entries'] ?? 0;
      String dateStr = eventData['date'] ?? ''; // The date field from Firestore

      // Check if the event date has passed
      DateTime eventDate;
      try {
        eventDate = DateFormat('dd-MM-yyyy')
            .parse(dateStr); // Parse date from Firestore
        // Set a time to compare, e.g., start of the day
        eventDate = DateTime(eventDate.year, eventDate.month, eventDate.day);
      } catch (e) {
        throw Exception('Invalid event date format.');
      }

      DateTime now = DateTime.now();
      if (now.isAfter(eventDate) && _isJoined) {
        // Can't join or unjoin after the event has started
        throw Exception(
            'The event has already started. You cannot change your status.');
      }

      if (_isJoined) {
        // Unjoin
        joined.remove(userId);
        await eventRef.update({'joined': joined});
        setState(() {
          _isJoined = false;
        });
        _showDialog('71'.tr, '72'.tr);
      } else {
        // Join
        if (joined.length >= maxEntries) {
          throw Exception('74'.tr);
        }
        if (joined.contains(userId)) {
          throw Exception('You have already joined this event.');
        }
        joined.add(userId);
        await eventRef.update({'joined': joined});
        setState(() {
          _isJoined = true;
        });
        _showDialog('71'.tr, '73'.tr);
      }
    } catch (e) {
      _showDialog('Error', 'An error occurred: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('70'.tr),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: _isLoading ? null : _toggleJoinStatus,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0.1,
                blurRadius: 60,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(13),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : Text(
                    _isJoined ? '59'.tr : '58'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
