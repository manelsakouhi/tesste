import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Expo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("39".tr),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // Change to a color that matches your theme
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Center(
                child: Text(
                  "130".tr,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent, // Change to match your theme
                  ),
                ),
              ),
              const SizedBox(height: 16),
               Text("131".tr,
                
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              Image.asset(
                "assets/images/Expo_jp.jpg",
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Divider(
                height: 40,
                color: Colors.green,
                thickness: 2,
              ),
              SizedBox(height: 16),
              Center(
                child:  Text(
                  "132".tr,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent, // Change to match your theme
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "133".tr,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Image.asset(
                "assets/images/theme.png",
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Divider(
                height: 40,
                color: Colors.green,
                thickness: 2,
              ),
              SizedBox(height: 16),
              Center(
                child:  Text(
                  "134".tr,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent, // Change to match your theme
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "135".tr,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Image.asset(
                "assets/images/mascot.png",
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
