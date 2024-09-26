//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/Visiteur_Simple/discussion/listview_users_view.dart';
import 'package:teste/modeles/agenda.dart';
import 'package:teste/modeles/histoire.dart';
import 'package:teste/modeles/AboutExpo.dart';
import 'package:teste/modeles/Maps.dart';
import 'package:teste/modeles/contacter_admin.dart';
import 'package:teste/modeles/favorite.dart';
import 'package:teste/modeles/galerie.dart';
import 'package:teste/modeles/partenaires.dart';
import 'package:teste/notification/notification.dart';
import 'package:teste/Visiteur_Simple/profil/profil.dart';
import '../Admin/controller/data_controller.dart';
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
  final currentUser=FirebaseAuth.instance.currentUser!;
  int _currentIndex=0;
setCurrentIndex(int index)
{
  setState(() {
    _currentIndex = index;
  });
}

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(DataController(),permanent: true);
        FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      
     // LocalNotificationService.display(message);
    });

  //LocalNotificationService.storeToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const UserAccountsDrawerHeader(
                    accountName: Text('Loading...'),
                    accountEmail: Text('Loading...'),
                    currentAccountPicture: CircleAvatar(),
                    decoration: BoxDecoration(color: Colors.blueAccent),
                  );
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return const UserAccountsDrawerHeader(
                    accountName: Text('Error'),
                    accountEmail: Text('Error loading data'),
                    currentAccountPicture: CircleAvatar(),
                    decoration: BoxDecoration(color: Colors.redAccent),
                  );
                }

                final userData = snapshot.data!;
                final firstName = userData['firstName'] ?? 'Unknown';
                final lastName = userData['lastName'] ?? '';
                final email = userData['email'] ?? 'No email';
                final imageUrl = userData['image'] ?? '';

                return UserAccountsDrawerHeader(
                  accountName: Text('$firstName $lastName'),
                  accountEmail: Text(email),
                  currentAccountPicture: imageUrl.isEmpty
                      ? CircleAvatar(
                          child: Text(
                            firstName[0].toUpperCase(),
                            style: TextStyle(fontSize: 40.0),
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(imageUrl),
                        ),
                  decoration: BoxDecoration(color: Colors.blueAccent),
                );
              },
            ),

              ListTile(
                leading: Icon(Icons.person),
              title:  Text("32".tr),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilPage()),
  );
            },
            ) ,
              ListTile(
                leading:const Icon(Icons.message),
              title:  Text('33'.tr),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>AdminUsersPage()
            ),
           );
            },
            ) ,
              ListTile(
              leading:const Icon(Icons.home),
              title:  Text('34'.tr),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Home()),
  );
            },
            ) ,
            ListTile(
            leading:const Icon(Icons.event),
              title: Text('35'.tr),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>   EventsView() ),
  );
            },
            ) ,

             ListTile(
            leading:const Icon(Icons.favorite),
              title: Text('36'.tr),
              
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Favoris()),
  );
            },
            ) ,
             
             ListTile(
              leading:const Icon(Icons.calendar_month),
              title: Text('37'.tr),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AgendaPage()),
  );
            },
            ) ,

    



             ListTile(
              leading:const Icon(Icons.history_edu_outlined),
              title: Text('38'.tr),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  History()),
  );
            },
            ) ,
             ListTile(
              leading:const Icon(Icons.event_seat),
              title: Text('39'.tr),
             onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Expo()),
  );
            },
            ) ,
             ListTile(
            leading:const Icon(Icons.person),
              title: Text('40'.tr),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Partenaire()),
  );
            },
            ) ,
             ListTile(
              leading:const Icon(Icons.photo_album),
              title: Text('41'.tr),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Photo()),
  );
            },
            ) ,
             
             ListTile(
            leading:const Icon(Icons.location_pin),
              title: Text('42'.tr),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Maps()),
  );
            },
            ) ,
             ListTile(
            leading:const Icon(Icons.contact_mail),
              title: Text('43'.tr),
              onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Contact()),
  );
            },
            ) ,








             ListTile(
            leading:const Icon(Icons.logout, color: Colors.red,),
              title:  Text('44'.tr,style:TextStyle(color: Colors.red)),
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
        MaterialPageRoute(builder: (context) => const ProfilPage()),
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
          //  const ChatPage(receiverUserEmail:'email', receiverUserID: 'uid',),
          AdminUsersPage(),
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

        items:  [
          BottomNavigationBarItem(icon:const Icon(Icons.home), label:'34'.tr),
          BottomNavigationBarItem(icon:const Icon(Icons.message), label:"33".tr),
          BottomNavigationBarItem(icon:const Icon(Icons.favorite_sharp), label:"36".tr),
          BottomNavigationBarItem(icon:const Icon(Icons.person), label:"32".tr),
         
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