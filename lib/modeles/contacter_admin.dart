import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Contact extends StatelessWidget {
  const Contact({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:  Text("43".tr),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        
        children: [
          Row(
            
            children: [
              Icon(Icons.phone,),
              
         Text("+216 71 130 320"),
            ],
          ),
         SizedBox(height: 15,),
         Row(
           children: [
             Icon(Icons.place_outlined),
             Text("129".tr),
           ],
         ),
         SizedBox(height: 15,),
         Row(
           children: [
             Icon(Icons.mail),
             Text("contact@tunisiaexpo2025.tn"),
           ],
         ),
          SizedBox(height: 15,),
         Row(
           children: [
             Icon(Icons.web),
             Text("www.tunisiaexpo2025.tn"),
           ],
         ),
        ],
      ), 
    );
  }
}