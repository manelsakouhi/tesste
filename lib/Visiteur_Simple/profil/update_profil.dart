import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:teste/Visiteur_Simple/profil/profil.dart';

class UpdateProfil extends StatelessWidget {
  const UpdateProfil({super.key});

  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
    return  Scaffold(
       appBar: AppBar(
        title: const Text(" Edit Profile ", textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: size.height,
          width: size.width,
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
                          LineAwesomeIcons.camera_retro_solid,
                        ),
                      ),
                    ),
                    
                    ],



              ),
           const SizedBox(height: 50,),
           Form(child: Column(
            children: [
               const SizedBox(
                 height: 20,
                        ),
              TextFormField(
                decoration:const InputDecoration(label: Text("Name"),
                prefixIcon: Icon(Icons.person_outline_rounded),
                   focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black),
                            ),
              ),),
               const SizedBox(
                height: 20,
                        ),
              TextFormField(
                decoration:const InputDecoration(label: Text("SurName"),
                prefixIcon: Icon(Icons.person_outline_rounded),
                 focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black),
                            ),),
                
              ),
               const SizedBox(
                  height: 20,
                        ),              
              TextFormField(
                decoration:const InputDecoration(label: Text("Email"),
                prefixIcon: Icon(Icons.mail),
                   focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black),
                            ),),
                
              ),
              const SizedBox(
                height: 20,
                        ),
              TextFormField(
                decoration:const InputDecoration(label: Text("password"),
                prefixIcon: Icon(Icons.fingerprint),
                 focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black),
                            ),),
                
              ),
               const SizedBox(
                 height: 30,
                        ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
              Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilPage()),
  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              side: BorderSide.none,shape: const StadiumBorder()
            ),
                 child: const Text("Edit Profile", style: TextStyle(color: Colors.black),),
            ),
            ),
           const  SizedBox(
              height: 30,
            ),
            //botton pour deconnecter
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
              Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilPage()),
  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: BorderSide.none,shape: const StadiumBorder()
            ),
                 child: const Text("Delete my account", style: TextStyle(color: Colors.white),),
            ),
            ),           
            ],
           ))
            ],
          ),
          ),
          ),
    );
  }
}