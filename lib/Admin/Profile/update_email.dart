// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class UpdateEmailPage extends StatefulWidget {
//   @override
//   _UpdateEmailPageState createState() => _UpdateEmailPageState();
// }

// class _UpdateEmailPageState extends State<UpdateEmailPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _newEmailController = TextEditingController();
//   String? _errorMessage;

//   // Update email and send verification email to the new email
//   Future<void> _updateEmail() async {
//     try {
//       User? user = _auth.currentUser;
//       String newEmail = _newEmailController.text.trim();

//       if (user == null) {
//         throw FirebaseAuthException(
//           code: "no-current-user",
//           message: "No user is currently signed in.",
//         );
//       }

//       // Update the email to the new email
//       await user.updateEmail(newEmail);

//       // Send verification email to the new email
//       await user.sendEmailVerification();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Verification email sent to $newEmail")),
//       );

//       // Optionally, update email in Firestore if needed
//       await _firestore.collection('users').doc(user.uid).update({
//         'email': newEmail,
//       });

//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _errorMessage = e.message;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = "An unexpected error occurred.";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Update Email"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _newEmailController,
//               decoration: InputDecoration(
//                 labelText: "New Email",
//                 errorText: _errorMessage,
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _updateEmail,
//               child: Text("Update Email & Send Verification"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
