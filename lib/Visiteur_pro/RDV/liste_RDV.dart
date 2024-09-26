import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class ListeRDV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('137'.tr),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('rendezvous').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Une erreur est survenue'));
          }

          final rendezvousList = snapshot.data?.docs;

          if (rendezvousList == null || rendezvousList.isEmpty) {
            return Center(child: Text('139'.tr));
          }

          return ListView.builder(
            itemCount: rendezvousList.length,
            itemBuilder: (context, index) {
              final rendezvous = rendezvousList[index];
              final data = rendezvous.data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 5, // Ajoute une ombre pour un effet de profondeur
                child: ListTile(
                  contentPadding: EdgeInsets.all(16), // Ajoute un peu d'espace autour du contenu
                  title: Text(
                    data['name'] ?? 'Nom non défini',
                    style: TextStyle(
                      fontSize: 22, // Augmente la taille de la police pour le titre
                      fontWeight: FontWeight.bold, // Rend le texte en gras
                      color: Colors.blueGrey[800], // Change la couleur du texte pour plus de visibilité
                    ),
                  ),
                  subtitle: Text(
                    
                    'Email: ${data['email'] ?? 'Email non défini'}\n'
                    'Date: ${data['date'] ?? 'Date non définie'}\n'
                    'Heure: ${data['time'] ?? 'Heure non définie'}\n'
                    'État: ${data['action'] ?? 'État non défini'}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // Ajuste la taille de la police des sous-titres
                      color: Colors.grey[700], // Change la couleur du texte pour plus de contraste
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
