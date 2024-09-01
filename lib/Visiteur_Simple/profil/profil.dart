import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:teste/Screens/login.dart';
import 'package:teste/Visiteur_Simple/profil/ProfilClass.dart';
class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}
 
class _ProfilPageState extends State<ProfilPage> {
  final currentUser=FirebaseAuth.instance.currentUser!;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page", textAlign: TextAlign.center,),
        actions: [
          IconButton(
            onPressed: () {
             Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
  );
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        //child: Container(
          padding: const EdgeInsets.all(16),
         // height: size.height,
          //width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Stack(
                children: [
                  const SizedBox(
                    width: 150,
                    child:  CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          ExactAssetImage('assets/images/profil.jpg'),
                    ),
                    ),
                    Positioned(
                      bottom:0 ,
                      right: 0 ,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.amber,
                        ),
                        child: const Icon(
                          LineAwesomeIcons.pencil_alt_solid,
                        ),
                      ),
                    ),
                    
                    ],



              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: size.width * .3,
                child: const Row(
                  children: [
                    Text(
                      'Sakouhi Manel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                currentUser.email!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(.3),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: size.height * .7,
                width: size.width,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileWidget (
                      icon: Icons.person,
                      title: 'My Profile',
                      
                    ),
                    ProfileWidget(
                      icon: Icons.settings,
                      title: 'settings',
                    ),
                    ProfileWidget(

                      icon: Icons.notifications,
                      title: 'notifications',
                    ),
                    // ProfileWidget(icon: Icons.chat, title: 'My Profile',),
                    //ProfileWidget(icon: Icons.person, title: 'My Profile',),
                    ProfileWidget(
                      icon: Icons.logout,
                      title: 'Log Out',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
    
    );
  }
}
