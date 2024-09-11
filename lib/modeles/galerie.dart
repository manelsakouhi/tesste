import 'package:flutter/material.dart';
import 'package:teste/modeles/photo.dart';

class Photo extends StatelessWidget {
 final List _photo= [
    Data(image: "assets/images/photo.png",text: "pavillon Tunisia"),
    Data(image: "assets/images/artisanat.jpg",text: "Artisanat"),
    Data(image: "assets/images/Cepex-Amesterdam.jpg",text: "pavillon Tunisia_Amesterdam"),
    Data(image: "assets/images/dubai.jpg",text: "pavillon Tunisia_dubai"),
    Data(image: "assets/images/expo-dubai.jpg",text: "pavillon Tunisia_dubai"),
    Data(image: "assets/images/expo.jpg",text: "pavillon Tunisia"),
    Data(image: "assets/images/italie.jpg",text: "pavillon Tunisia_italie"),
    Data(image: "assets/images/pavillon.jpg",text: "pavillon Tunisia"),
    Data(image: "assets/images/pavillon2.jpg",text: "pavillon Tunisia"),
    Data(image: "assets/images/tunis_dubai.jpg",text: "pavillon Tunisia_dubai"),

       
  ];
   Photo({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Gallery"),
        centerTitle: true,
        elevation: 0,
      ),
      body: GridView.builder(
        itemCount: _photo.length,
        gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
            decoration:  BoxDecoration(
              color: Colors.pink,
              image: DecorationImage(
                image: AssetImage(_photo[index].image),
                fit:BoxFit.cover)
            ),
          ),
          const SizedBox(height: 10,),
           Text(_photo[index].text),
            ],
          );
        },
      
      
      ),
      );
    
  }
}