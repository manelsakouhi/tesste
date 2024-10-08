import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/modeles/histoire.dart';
import 'package:teste/modeles/AboutExpo.dart';
import 'package:teste/modeles/Maps.dart';
import 'package:teste/modeles/VisitTunisia.dart';
import 'package:teste/modeles/favorite.dart';
import 'package:teste/modeles/galerie.dart';
import 'package:teste/modeles/partenaires.dart';

import 'events/accueil_events.dart';

class Home extends StatelessWidget {
  //  DocumentSnapshot eventData,user;

  // Home(this.eventData,this.user);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //appBar: AppBar(backgroundColor: Colors.blueGrey,),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, //px
              childAspectRatio:7/8,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
               ),
            children: [
              InkWell(
                onTap: () {
                  Get.to(EventsView());
             
            },
                child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                
                  color: Colors.purple,
                  
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.event, size: 50, color: Colors.white,),
                    Text('35'.tr, style:const TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,),
              ),
              InkWell(
                 onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Favoris()),
  );
            },
                child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, size: 50, color: Colors.white,),
                    Text('36'.tr, style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,
                  ),
              ),
              InkWell(
                 onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  VisitTunis()),
  );
            },
                child: Container(
                          decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(Icons.flag, size: 50, color: Colors.white,),
                    Text('45'.tr, style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,),
              ),   
              InkWell(
                 onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  History()),
  );
            },
                child: Container(
                          decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber,),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history_edu_outlined, size: 50, color: Colors.white,),
                    Text('38'.tr, style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,),
              ),



              InkWell(
                 onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Expo()),
  );
            },
                child: Container(
                   decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 38, 0, 255),),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_seat, size: 50, color: Colors.white,),
                    Text('39'.tr, style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,
                  ),
              ),
              InkWell(
                 onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Maps()),
  );
            },
                child: Container(
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:  Colors.yellowAccent),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_pin, size: 50, color: Colors.white,),
                    Text('42'.tr, style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,
                  ),
              ),
              InkWell(
                 onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Partenaire()),
  );
            },
                child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepOrangeAccent,),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 50, color: Colors.white,),
                    Text('40'.tr
                    , style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,
                  ),
              ),
              InkWell(
                 onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Photo()),
  );
            },
                child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 59, 245, 255),),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_album, size: 50, color: Colors.white,),
                    Text('41'.tr, style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,
                  ),
              ),
             
            ], 
          ),
        ),
      ),
    );
  }
}