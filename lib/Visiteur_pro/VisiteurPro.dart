//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste/Visiteur_pro/Contrats.dart';
import 'package:teste/Visiteur_pro/agendaPro.dart';
import 'package:teste/Visiteur_pro/homePro.dart';
import 'package:teste/Visiteur_pro/messagePro.dart';
import 'package:teste/Visiteur_pro/notification.dart';
import 'package:teste/Visiteur_pro/profilpro.dart';
import 'package:teste/modeles/AboutExpo.dart';
import 'package:teste/modeles/Maps.dart';
import 'package:teste/Visiteur_pro/RDV.dart';
import 'package:teste/modeles/VisitTunisia.dart';
import 'package:teste/modeles/contacter_admin.dart';
import 'package:teste/modeles/events.dart';
import 'package:teste/modeles/favorite.dart';
import 'package:teste/modeles/galerie.dart';
import 'package:teste/modeles/partenaires.dart';

import '../Screens/login.dart';

class VisiteurPro extends StatefulWidget {
  const VisiteurPro({super.key});

  @override
  State<VisiteurPro> createState() => _VisiteurProState();
}

class _VisiteurProState extends State<VisiteurPro> {
    final currentUser=FirebaseAuth.instance.currentUser!;
   

  int _currentIndex=0;
setCurrentIndex(int index)
{
  setState(() {
    _currentIndex = index;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
           const UserAccountsDrawerHeader(
              accountName:  Text('Manel Sakouhi'), 
              accountEmail:  Text('manelsakouhi@gmail.com'),
              currentAccountPicture: CircleAvatar(
              ),
               decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              ),

              ListTile(
                leading:const Icon(Icons.person),
              title: const Text("Profils"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilPagePro()),
  );
            },
            ) ,
              ListTile(
                leading:const Icon(Icons.message),
              title: const Text("Message"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MessagePro()),
  );
            },
            ) ,
              ListTile(
              leading:const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePro()),
  );
            },
            ) ,
            ListTile(
            leading:const Icon(Icons.event),
              title: const Text("Events"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Events()),
  );
            },
            ) ,
             ListTile(
              leading:const Icon(Icons.calendar_month),
              title: const Text("My RDV"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RDV()),
  );
            },
            ) ,
             ListTile(
              leading:const Icon(Icons.calendar_month),
              title: const Text("Partenariat"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Contrat()),
  );
            },
            ) ,
             ListTile(
            leading:const Icon(Icons.favorite),
              title: const Text("Favoris"),
              
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Favoris()),
  );
            },
            ) ,
             ListTile(
              leading:const Icon(Icons.flag),
              title: const Text("Visit Tunisia"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VisitTunis()),
  );
            },
            ) ,
             ListTile(
              leading:const Icon(Icons.event_seat),
              title: const Text("About Expo"),
             onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Expo()),
  );
            },
            ) ,
             ListTile(
            leading:const Icon(Icons.person),
              title: const Text("Partners"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Partenaire()),
  );
            },
            ) ,
             ListTile(
              leading:const Icon(Icons.photo_album),
              title: const Text("Gallery"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Photo()),
  );
            },
            ) ,
             ListTile(
            leading:const Icon(Icons.calendar_month),
              title: const Text("Agenda"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AgendaPro()),
  );
            },
            ) ,
             ListTile(
            leading:const Icon(Icons.location_pin),
              title: const Text("Maps"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Maps()),
  );
            },
            ) ,
             ListTile(
            leading:const Icon(Icons.contact_mail),
              title: const Text("Contact"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Contact()),
  );
            },
            ) ,
             ListTile(
            leading:const Icon(Icons.logout, color: Colors.red,),
              title: const Text("Log Out",style:TextStyle(color: Colors.red)),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
  );
            },
            ) ,
          ],
        ),
      ),







      appBar: AppBar(
        //title: const Text("Visiteur: Expo Japon Osaka 2025"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilPagePro()),
  );
            },
          
            icon: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NotificationPro()),
  );
            },
          
            icon: const Icon(
              Icons.notifications,
               color: Colors.grey,
            ),
          )
        ],
      ),
     
        body: [
           
          //ajouter les pages de navigator side
          const HomePro(),
           const MessagePro(),
           const RDV(),
           const Favoris(),
          const ProfilPagePro(),
          ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setCurrentIndex(index),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 20,
        unselectedFontSize: 14,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label:"Home"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label:"Message"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label:"RDV"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_sharp), label:"Favoris"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label:"Profil"),
        ]),
       
        
    );
  }




















  Future<void> logout(BuildContext context) async  {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
     Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}