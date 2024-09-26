import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatefulWidget {
  final String chatRoomId;
  final String adminUserId;
  final String adminUserName;

  ChatPage({
    required this.chatRoomId,
    required this.adminUserId,
    required this.adminUserName,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late Stream<QuerySnapshot> _messagesStream;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Types de réclamations
  final List<String> _claimTypes = [
    "Problème technique",
    "Demande d'information",
    "Réclamation sur un event",
    "Autre"
  ];

  @override
  void initState() {
    super.initState();
    _messagesStream = FirebaseFirestore.instance
        .collection('chat rooms')
        .doc(widget.chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void _sendMessage(String messageText) async {
    if (messageText.isNotEmpty) {
      final String senderId = _auth.currentUser!.uid;
      final String senderEmail = _auth.currentUser!.email!;

      await FirebaseFirestore.instance
          .collection('chat rooms')
          .doc(widget.chatRoomId)
          .collection('messages')
          .add({
        'message': messageText,
        'senderId': senderId,
        'senderEmail': senderEmail,
        'receiverId': widget.adminUserId,
        'timestamp': Timestamp.now(),
      });

      _messageController.clear();
    }
  }

  void _sendClaimMessage(String claimType) {
    _sendMessage(claimType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.adminUserName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No messages yet.'));
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final bool isMe = message['senderId'] == _auth.currentUser!.uid;

                    return _buildMessageBubble(
                      message['message'],
                      isMe,
                      message['timestamp'].toDate(),
                    );
                  },
                );
              },
            ),
          ),
          _buildClaimButtons(),  // Updated claim buttons
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildClaimButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView( // Allow horizontal scrolling
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _claimTypes.map((claimType) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add horizontal padding
              child: ElevatedButton(
                onPressed: () => _sendClaimMessage(claimType),
                child: Text(claimType),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Enter your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _sendMessage(_messageController.text),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String message, bool isMe, DateTime timestamp) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[300] : Colors.grey[300],
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(
              _formatTimestamp(timestamp),
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.black54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
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
