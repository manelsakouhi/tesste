import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'liste_contrat.dart';

class Contrat extends StatefulWidget {
  @override
  _ContratState createState() => _ContratState();
}

class _ContratState extends State<Contrat> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
   final _entrepriseController = TextEditingController();
  final _sujetController = TextEditingController();


 

  

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final entreprise = _entrepriseController.text;
      final sujet = _sujetController.text;
      final email = _emailController.text;
     

      // Affiche une boîte de dialogue avec les informations
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('157'.tr),
            content: Text(
              'Nom: $name \n Entreprise: $entreprise \n Email: $email \n Sujet: $sujet\n',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('150'.tr),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance.collection('Contrat').add({
                    'name': name,
                    'Entreprise':entreprise,
                    'email': email,
                    'sujet':sujet,
                    
                    'action': "waiting",
                  });
                  Navigator.of(context).pop();
                  _nameController.clear();
                  _emailController.clear();
                  _entrepriseController.clear();
                  _sujetController.clear();
                 
                },
                child: Text('151'.tr),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Couleur de fond
                  onPrimary: Colors.white, // Couleur du texte
                  elevation: 5, // Ombre pour effet 3D
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('158'.tr),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'list') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeContrat()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'list',
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.list),
                      SizedBox(width: 8),
                      Text('159'.tr),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration:  InputDecoration(
                  labelText: '16'.tr,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
               TextFormField(
                controller: _entrepriseController,
                decoration:  InputDecoration(
                  labelText: '160'.tr,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.work),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer votre nom d'entreprise";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration:  InputDecoration(
                  labelText: '7'.tr,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return '22'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
               TextFormField(
                controller: _sujetController,
                decoration:  InputDecoration(
                  labelText: '161'.tr,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.subject),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer votre sujet";
                  }
                  return null;
                },
              ),
             
              SizedBox(height: 10),
              /* Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _selectDate(context),
                      icon: Icon(Icons.calendar_today),
                      label: Text(
                        _selectedDate != null
                            ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                            : 'Choisir la date',
                      ),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black, // Couleur du texte
                        side: BorderSide(color: Colors.blueGrey[300]!), // Bordure
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _selectTime(context),
                      icon: Icon(Icons.access_time),
                      label: Text(
                        _selectedTime != null
                            ? _selectedTime!.format(context)
                            : 'Choisir l\'heure',
                      ),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black, // Couleur du texte
                        side: BorderSide(color: Colors.blueGrey[300]!), // Bordure
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ), */
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('156'.tr),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Couleur de fond
                    onPrimary: Colors.white, // Couleur du texte
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5, // Ombre pour effet 3D
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
