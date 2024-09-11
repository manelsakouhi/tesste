import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.image,
    required this.createdAt,
    required this.documentId,
    required this.location,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String image;
  final String location;
  final Timestamp createdAt;
  final String documentId;

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String _userState = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserState();
  }

  Future<void> _fetchUserState() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(widget.documentId).get();
      if (doc.exists) {
        setState(() {
          _userState = doc.get('states') ?? '';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user state: $e')),
      );
    }
  }

  void _disableAccount() {
  final reasonController = TextEditingController();
  bool isProcessing = false;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text('Reason for Deactivation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: reasonController,
              decoration: InputDecoration(hintText: 'Enter reason for deactivating this user'),
              maxLines: 3,
            ),
            if (isProcessing) ...[
              SizedBox(height: 20),
              Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final reason = reasonController.text.trim();
              if (reason.isNotEmpty) {
                setState(() {
                  isProcessing = true;
                });

                try {
                  await FirebaseFirestore.instance.collection('users').doc(widget.documentId).update({
                    'states': 'notActive',
                    'message': reason,
                  });

                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User has been disabled successfully')),
                  );
                  _fetchUserState(); // Refresh user state
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to disable user: $e')),
                  );
                } finally {
                  setState(() {
                    isProcessing = false;
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter a reason for deactivation')),
                );
                setState(() {
                  isProcessing = false; // Stop the loading indicator if no reason is provided
                });
              }
            },
            child: Text('Disable'),
          ),
        ],
      ),
    ),
  );
}


  void _activateAccount() async {
    bool isProcessing = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Activate Account'),
          content: isProcessing
              ? Center(child: CircularProgressIndicator())
              : Text('Are you sure you want to activate this account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  isProcessing = true;
                });

                try {
                  await FirebaseFirestore.instance.collection('users').doc(widget.documentId).update({
                    'states': 'active',
                  });

                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User has been activated successfully')),
                  );
                  _fetchUserState(); // Refresh user state
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to activate user: $e')),
                  );
                } finally {
                  setState(() {
                    isProcessing = false;
                  });
                }
              },
              child: Text('Activate'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provide default values if data is missing
    final displayName = "${widget.firstName} ${widget.lastName}".trim().isNotEmpty ? "${widget.firstName} ${widget.lastName}" : 'Nom non défini';
    final displayEmail = widget.email.isNotEmpty ? widget.email : 'Email non disponible';
    final displayRole = widget.role.isNotEmpty ? widget.role : 'Rôle non défini';
    final displayCreatedAt = widget.createdAt.toDate().toLocal().toString(); // Format the Timestamp

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("User Details"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            // User Avatar
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: widget.image.isNotEmpty
                    ? NetworkImage(widget.image)
                    : null,
                child: widget.image.isEmpty
                    ? Text(
                        displayName.isNotEmpty ? displayName[0] : '?',
                        style: const TextStyle(fontSize: 40, color: Colors.white),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            
            // User Details
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Name',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      displayName,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      displayEmail,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Location',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.location.isNotEmpty ? widget.location : "Non défini",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Role',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      displayRole,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Created At',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      displayCreatedAt,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),

                    // Conditional Button
                    if (_userState == 'active') ...[
                      // Disable Account Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _disableAccount,
                              child: const Text('Disable Account'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red, // Set the button color to red for disable action
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else if (_userState == 'notActive') ...[
                      // Activate Account Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _activateAccount,
                              child: const Text('Activate Account'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green, // Set the button color to green for activate action
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
