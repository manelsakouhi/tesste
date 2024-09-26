import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'liste_RDV.dart'; // Assurez-vous que ce chemin est correct

class RendezvousForm extends StatefulWidget {
  @override
  _RendezvousFormState createState() => _RendezvousFormState();
}

class _RendezvousFormState extends State<RendezvousForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final date = _selectedDate != null
          ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
          : 'Non défini';
      final time = _selectedTime != null
          ? _selectedTime!.format(context)
          : 'Non défini';

      // Affiche une boîte de dialogue avec les informations
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('140'.tr),
            content: Text(
              'Nom: $name\nEmail: $email\nDate: $date\nHeure: $time',
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
                  await FirebaseFirestore.instance.collection('rendezvous').add({
                    'name': name,
                    'email': email,
                    'date': date,
                    'time': time,
                    'action': "waiting",
                  });
                  Navigator.of(context).pop();
                  _nameController.clear();
                  _emailController.clear();
                  setState(() {
                    _selectedDate = null;
                    _selectedTime = null;
                  });
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
        title: Text('152'.tr),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'list') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeRDV()),
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
                      Text('153'.tr),
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
                    return '22.tr';
                  }
                  return null;
                },
              ),
              
             
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _selectDate(context),
                      icon: Icon(Icons.calendar_today),
                      label: Text(
                        _selectedDate != null
                            ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                            : '154'.tr,
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
                            : '155'.tr,
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
              ),
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
