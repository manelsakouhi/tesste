import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContratDetails extends StatefulWidget {
  final String documentId;

  const ContratDetails({super.key, required this.documentId});

  @override
  _ContratDetailsState createState() => _ContratDetailsState();
}

class _ContratDetailsState extends State<ContratDetails> {
  bool _isLoading = false; // To track the loading state
  late final DocumentReference documentRef;

  @override
  void initState() {
    super.initState();
    // Initialize documentRef here
    documentRef = FirebaseFirestore.instance.collection('Contrat').doc(widget.documentId);
  }

  Future<void> _updateAction(String newAction) async {
    setState(() {
      _isLoading = true; // Set loading state to true when starting the update
    });

    try {
      await documentRef.update({'action': newAction});
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contrat $newAction')),
      );
    } catch (e) {
      // Handle specific Firestore exceptions if needed
      String errorMessage;
      if (e is FirebaseException) {
        switch (e.code) {
          case 'permission-denied':
            errorMessage = 'Vous n\'avez pas la permission de modifier ce contrat.';
            break;
          case 'not-found':
            errorMessage = 'Le contrat est introuvable.';
            break;
          default:
            errorMessage = 'Une erreur inconnue est survenue.';
        }
      } else {
        errorMessage = 'Une erreur est survenue: ${e.toString()}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state when update completes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Contrat'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: documentRef.snapshots(),
        builder: (context, snapshot) {
          // Handle the waiting state for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Contrat non trouvé'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final name = data['name'] ?? 'Non défini';
          final email = data['email'] ?? 'Non défini';
          final entreprise = data['Entreprise'] ?? 'Non défini';
          final sujet = data['sujet'] ?? 'Non défini';
          final action = data['action'] ?? 'waiting'; // Default to 'waiting' if not defined

          // Check if the action is 'waiting'
          final showButtons = action == 'waiting';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Nom: $name', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text('Email: $email', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text('Entreprise: $entreprise', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text('sujet: $sujet', style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                if (_isLoading)
                  Center(child: CircularProgressIndicator())
                else if (showButtons)
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => _updateAction('accepted'),
                          child: Text('Accept'),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            primary: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                          onPressed: () => _updateAction('declined'),
                          child: Text('Decline'),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            primary: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
