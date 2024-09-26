import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class ListeContrat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('162'.tr),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Contrat').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Une erreur est survenue'));
          }

          final contartList = snapshot.data?.docs;

          if (contartList == null || contartList.isEmpty) {
            return Center(child: Text('Aucun demande trouvé'));
          }

          return ListView.builder(
            itemCount: contartList.length,
            itemBuilder: (context, index) {
              final contart = contartList[index];
              final data = contart.data() as Map<String, dynamic>;

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
                    'Entreprise: ${data['Entreprise'] ?? 'Entreprise non défini'}\n'
                    'Email: ${data['email'] ?? 'Email non défini'}\n'
                    'Sujet: ${data['sujet'] ?? 'Sujet non défini'}\n'
                    
                    
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
