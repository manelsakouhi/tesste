import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:teste/modeles/photo.dart';

class Partenaire extends StatelessWidget {
  final List _photo= [
    Data(image: "assets/images/BCT.jpg",text: "Banque Centrale Tunisie"),
    Data(image: "assets/images/UTICA.jpg",text: "UTICA"),
    Data(image: "assets/images/UTAP.jpg",text: "UTAP ",),
    Data(image: "assets/images/tunisair.jpg",text: "Tunisair"),
    Data(image: "assets/images/CCIT.png",text: "CCIT"),
   Data(image: "assets/images/CTN.jpg",text: " CTN"),
    Data(image: "assets/images/GIZ.jpg",text: "GIZ"),
    Data(image: "assets/images/GIPP.png",text: "GIPP"),
    //Data(image: "assets/images/pavillon2.jpg",text: "pavillon Tunisia"),
    //Data(image: "assets/images/tunis_dubai.jpg",text: "pavillon Tunisia_dubai"),
       
  ];
   Partenaire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Partners & Sponsors"),
        centerTitle: true,
        elevation: 0,
      ),
      body: GridView.builder(
        itemCount: _photo.length,
        gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4),
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 10,),
              Container(
                width: 200,
                height: 150,
            decoration:  BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(_photo[index].image),
                //fit:BoxFit.cover)
            ),
          ),),
          const SizedBox(height: 10,),
           Text(_photo[index].text),
            ],
          );
        },
      
      
      ),
      );
  }
}