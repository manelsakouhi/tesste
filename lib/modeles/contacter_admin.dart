import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
    final nameController=TextEditingController();
  final prenController=TextEditingController();
final mailController=TextEditingController();
final adrController=TextEditingController();
  final phoneController=TextEditingController();
  final pswController=TextEditingController();
  
   void vider()
   {
     setState(() {
      nameController.text = "";
      prenController.text="";
      phoneController.text = "";
      adrController.text = "";
      mailController.text="";
      
     });
    }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Contact"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Expanded(
              flex:2,
              child: TextField(
                decoration: const InputDecoration
                (
                  labelText: "Nom",
                  hintText: "Entrez votre nom",
                  //suffixText: "@gmail.com",
                  icon: Icon(Icons.person)
                ), 
                keyboardType: TextInputType.text, //
                controller: nameController,
              ),
            ),
            Expanded(
              flex:2,
              child: TextField(
                decoration:const InputDecoration
                (
                  labelText: "Prenom",
                  hintText: "Entrez votre prenom",
                  //suffixText: "@gmail.com",
                  icon: Icon(Icons.person)
                ), 
                keyboardType: TextInputType.text, //
                controller: prenController,
              ),
            ),
            Expanded(
              flex:2,
              child: TextField(
                decoration: const InputDecoration
                (
                  labelText: "Email",
                  hintText: "Entrez votre Email",
                  suffixText: "@gmail.com",
                  icon: Icon(Icons.mail_lock)
                ), 
                keyboardType: TextInputType.text, //
                controller: mailController,
              ),
            ),
            Expanded(
              flex:2,
              child: TextField(
                decoration:const InputDecoration
                (
                  labelText: "Adresse",
                  hintText: "Entrez votre adresse",
                  //suffixText: "@gmail.com",
                  icon: Icon(Icons.person)
                ), 
                keyboardType: TextInputType.text, //
                controller: adrController,
              ),
            ),
            Expanded(
              flex:2,
              child: TextField(
                decoration: const InputDecoration
                (
                  labelText: "Telephone",
                  hintText: "Entrez votre telephone",
                  icon: Icon(Icons.phone_android)
                ), 
                keyboardType: TextInputType.number, //
                controller: phoneController,
              ),
            ),
           
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Confirm'),
                          content: const Text('Do you confirm'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'No'),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Yes'),
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                        
                      ),
                        child:const Text(
                          "Envoyer",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FilledButton(
                          onPressed: vider,
                          child:const Text(
                            "Vider",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    
                  ],
        ),
        )
          ],
      ),
       ), 
    );
  }
}