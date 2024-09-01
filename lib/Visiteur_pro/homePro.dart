import 'package:flutter/material.dart';
import 'package:teste/Visiteur_pro/Contrats.dart';
import 'package:teste/modeles/AboutExpo.dart';
import 'package:teste/modeles/Maps.dart';
import 'package:teste/Visiteur_pro/RDV.dart';
import 'package:teste/modeles/VisitTunisia.dart';
import 'package:teste/Visiteur_Simple/agenda.dart';
import 'package:teste/modeles/events.dart';
import 'package:teste/modeles/favorite.dart';
import 'package:teste/modeles/galerie.dart';
import 'package:teste/modeles/partenaires.dart';

class HomePro extends StatefulWidget {
  const HomePro({super.key});

  @override
  State<HomePro> createState() => _HomeProState();
}

class _HomeProState extends State<HomePro> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.lightBlueAccent,
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
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Events()),
  );
            },
                child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                
                  color: Colors.purple,
                  
                ),
                child:const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event, size: 50, color: Colors.white,),
                    Text('Events', style: TextStyle(color: Colors.white, fontSize: 30),),
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
                  child:const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, size: 50, color: Colors.white,),
                    Text('favoris', style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,
                  ),
              ),
              InkWell(
                 onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RDV()),
  );
            },
                child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.yellow,),
                  child:const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month, size: 50, color: Colors.white,),
                    Text('My appointments', style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,
                  ),
              ),

              InkWell(
                 onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Contrat()),
  );
            },
                child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.yellow,),
                  child:const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month, size: 50, color: Colors.white,),
                    Text('my contrats', style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,
                  ),
              ),



              InkWell(
                 onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VisitTunis()),
  );
            },
                child: Container(
                          decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,),
                  child:const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.flag, size: 50, color: Colors.white,),
                    Text('Visit Tunisia', style: TextStyle(color: Colors.white, fontSize: 30),),
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
                  color: Colors.orange,),
                  child:const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_seat, size: 50, color: Colors.white,),
                    Text('About Expo', style: TextStyle(color: Colors.white, fontSize: 30),),
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
                  color: Colors.purple,),
                  child:const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_pin, size: 50, color: Colors.white,),
                    Text('Maps', style: TextStyle(color: Colors.white, fontSize: 30),),
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
                  color: Colors.red,),
                  child:const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 50, color: Colors.white,),
                    Text('Partners', style: TextStyle(color: Colors.white, fontSize: 30),),
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
                  color: Colors.yellow,),
                  child:const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_album, size: 50, color: Colors.white,),
                    Text('Gallery', style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                )
                ,
                  ),
              ),
              InkWell(
                 onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Agenda()),
  );
            },
                child: Container(
                   decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,),
                  child:const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month, size: 50, color: Colors.white,),
                    Text('Agenda', style: TextStyle(color: Colors.white, fontSize: 30),),
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