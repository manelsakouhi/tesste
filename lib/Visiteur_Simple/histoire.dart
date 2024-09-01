import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("About Expo"),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        
          child: Column(
            children: [
             const Text("Participation in Expos", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromARGB(255, 10, 131, 231)),),
               const Text("Present since the Great Exhibition of 1851 in London, Tunisia has regularly participated in both World and Specialised Expos. At Specialised Expo 2012 Yeosu, its pavilion was rewarded with the Silver Award in its category for the theme development."),
                Image.asset("assets/images/london.jpg",
                width: double.infinity,
                height: double.infinity,),
              const  Padding(padding: EdgeInsets.only(top: 10)), 
      
               
      
            ],
            
            ),
            
            
          ),
      
      
      
      
    );
  }
}