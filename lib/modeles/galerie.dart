import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/modeles/photo.dart';

class Photo extends StatelessWidget {
 final List _photo= [
    Data(image: "assets/images/photo.png",text: "124".tr),
    Data(image: "assets/images/artisanat.jpg",text: "125".tr),
    Data(image: "assets/images/Cepex-Amesterdam.jpg",text: "126".tr),
    Data(image: "assets/images/dubai.jpg",text: "127".tr),
    Data(image: "assets/images/expo-dubai.jpg",text: "127".tr),
    Data(image: "assets/images/expo.jpg",text: "124".tr),
    Data(image: "assets/images/italie.jpg",text: "128".tr),
    Data(image: "assets/images/pavillon.jpg",text: "124".tr),
    Data(image: "assets/images/pavillon2.jpg",text: "124".tr),
    Data(image: "assets/images/tunis_dubai.jpg",text: "127".tr),

       
  ];
   Photo({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:  Text("41".tr),
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
              color: Colors.white,
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