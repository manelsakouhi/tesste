//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/modeles/histoire.dart';
import 'package:teste/modeles/AboutExpo.dart';
import 'package:teste/modeles/Maps.dart';
import 'package:teste/modeles/VisitTunisia.dart';
import 'package:teste/Visiteur_Simple/agenda.dart';
import 'package:teste/modeles/contacter_admin.dart';
import 'package:teste/modeles/favorite.dart';
import 'package:teste/modeles/galerie.dart';
import 'package:teste/modeles/partenaires.dart';
import 'package:teste/Visiteur_Simple/discussion/messageVisiteurSimple.dart';
import 'package:teste/Visiteur_Simple/notification/notification.dart';
import 'package:teste/Visiteur_Simple/profil/profil.dart';
import 'package:teste/Visiteur_Simple/profil/update_profil.dart';
import '../core/constant/approutes.dart';
import '../core/services/services.dart';
import 'Home.dart';
import '../Screens/login.dart';
import 'events/accueil_events.dart';

class Visiteur extends StatefulWidget {
  const Visiteur({super.key});

  @override
  State<Visiteur> createState() => _VisiteurState();
}

class _VisiteurState extends State<Visiteur> {
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
            MaterialPageRoute(builder: (context) => const ProfilPage()),
  );
            },
            ) ,
              ListTile(
                leading:const Icon(Icons.message),
              title: const Text("Message"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatPage(receiverUserEmail: 'email', receiverUserID: 'uid',)
            ),
           );
            },
            ) ,
              ListTile(
              leading:const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Home()),
  );
            },
            ) ,
            ListTile(
            leading:const Icon(Icons.event),
              title: const Text("Events"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>   EventsView() ),
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
              leading:const Icon(Icons.flag),
              title: const Text("Participation History"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  History()),
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
            MaterialPageRoute(builder: (context) => const Agenda()),
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
             Get.offAllNamed(AppRoute.login);
                MyServices myServices = Get.find();
                myServices.sharedPreferences.clear();
                myServices.sharedPreferences.setString("step", "1");
              
            },
            ) ,
          ],
        ),
      ),





// دا كود انهى صفحه بالظبط** aya code 

      appBar: AppBar(
        //title: const Text("Visiteur: Expo Japon Osaka 2025"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  UpdateProfil()),
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
        MaterialPageRoute(builder: (context) => const NotificationPage()),
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
           Home(),
           const ChatPage(receiverUserEmail:'email', receiverUserID: 'uid',),
          
           const Favoris(),
           const ProfilPage(),
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