//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/Admin/homeAdmin.dart';
import 'package:teste/Admin/RDV/listeRDV.dart';
import 'package:teste/Admin/Notification/notification.dart';
import 'package:teste/Admin/Profile/profil_admin.dart';
import 'package:teste/core/constant/approutes.dart';
import 'package:teste/core/services/services.dart';
import 'package:teste/modeles/galerie.dart';
import 'package:teste/modeles/partenaires.dart';


import '../Screens/login.dart';

import 'Contart/ContratList.dart';
import 'Contart/ContratDetails.dart';
import 'RDV/users_list_view.dart';
import 'chat/AllUsersPage.dart';
import 'widgets_create_events/events_list_view.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
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
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
  );
            },
            ) ,

              ListTile(
              leading:const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeAdmin()),
  );
            },
            ) ,
            ListTile(
            leading:const Icon(Icons.event),
              title: const Text("Events"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  const EventsListView() ),
  );
            },
            ) ,

     

            ListTile(
              leading:const Icon(Icons.calendar_month),
              title: const Text("Users"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>const  UsersListView()),
  );
            },
            ) ,
             ListTile(
              leading:const Icon(Icons.calendar_month),
              title: const Text(" RDV"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  RendezvousList()),
  );
            },
            ) ,
             ListTile(
              leading:const Icon(Icons.calendar_month),
              title: const Text("Partenariat"),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>   ContratList()),
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







      appBar: AppBar(
        //title: const Text("Visiteur: Expo Japon Osaka 2025"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
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
        MaterialPageRoute(builder: (context) => const Notif()),
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
                      
          //ajouter les pages 
          const HomeAdmin(),
            RendezvousList(),
            AllUsersPage(),
           const EventsListView(),
          const ProfileScreen(),

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
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label:"RDV"),
           BottomNavigationBarItem(icon: Icon(Icons.message), label:"chat"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label:"Events"),
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
        builder: (context) => const LoginPage(),
      ),
    );
  }
}