import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ContratDetails.dart'; // Ensure this path is correct

class ContratList extends StatefulWidget {
  @override
  _ContratListState createState() => _ContratListState();
}

class _ContratListState extends State<ContratList> {
  int _selectedIndex = 0; // 0 for waiting, 1 for accepted, 2 for declined

  // List of action filters
  final List<String> _actions = ['waiting', 'accepted', 'declined'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Contrats'),
      ),
      body: Column(
        children: [
          // Toggle Buttons for selecting the list to display
          ToggleButtons(
            isSelected: List.generate(3, (index) => index == _selectedIndex),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('En attente'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Accepté'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Refusé'),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          // StreamBuilder to display the list based on selected action
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Contrat')
                  .where('action', isEqualTo: _actions[_selectedIndex])
                  .snapshots(),
              builder: (context, snapshot) {
                // Handle the waiting state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Chargement des Contrats...'),
                      ],
                    ),
                  );
                }

                // Handle any errors that occurred
                if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                }

                // Handle the case where there's no data
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('Aucun contrat trouvé'));
                }

                final documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final doc = documents[index].data() as Map<String, dynamic>;
                    final name = doc['name'] ?? 'Non défini';
                    final email = doc['email'] ?? 'Non défini';
                    final entreprise = doc['Entreprise'] ?? 'Non défini';
                    final sujet = doc['sujet'] ?? 'Non défini';
                    final documentId = documents[index].id;

                    return ListTile(
                      title: Text(name),
                      subtitle: Text('$entreprise '),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContratDetails(
                              documentId: documentId,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
