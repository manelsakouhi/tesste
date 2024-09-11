import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teste/Admin/RDV/listeRDV.dart';

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
//b dh7ak m3a okhty dhahkny ibnaha
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
            title: Text('Confirmation du Rendez-vous'),
            content: Text(
              'Nom: $name\nEmail: $email\nDate: $date\nHeure: $time',
            ),
            actions: <Widget>[
               TextButton(
                onPressed: ()async {
                  Navigator.of(context).pop();
                  
                },
                child: Text('cancel'),
              ),
              TextButton(
                onPressed: ()async {
                
                  await FirebaseFirestore.instance.collection('rendezvous').add({
        'name': name,
        'email': email,
        'date': date,
        'time': time,
        'action' :"waiting",
      }
      );
        Navigator.of(context).pop();
          _nameController.text = "";
           _emailController.text = "";
           _selectedDate = null ;
           _selectedTime = null ;

                },
                child: Text('OK'),
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
        title: Text('Formulaire de Rendez-vous'),
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
                decoration: const InputDecoration(
                  labelText: 'Nom',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text(
                        _selectedDate != null
                            ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                            : 'Choisir la date',
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: Text(
                        _selectedTime != null
                            ? _selectedTime!.format(context)
                            : 'Choisir l\'heure',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Soumettre'),
                  


                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}