import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/Screens/login.dart';
import 'package:teste/core/services/services.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        width: double.infinity,
        child: ListView(

          // mainAxisAlignment: MainAxisAlignment.start,
          //  crossAxisAlignment: CrossAxisAlignment.center,

          children: [

           const SizedBox(
              height: 50,
            ),

          Center(
            child:   Text("Welcome to Japon Expo!",style: TextStyle(
                color: Colors.black,
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),),
          ),

          const  SizedBox(
              height: 5,
            ),

           Center(child: const Text("Event Management System",style: TextStyle(fontSize: 16),)),

           const SizedBox(
              height: 50,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Image.asset('assets/images/logo2.jpg' ,height: Get.height *0.50,),
            ),

         const Spacer(),

            Expanded(
              child: Container(
                width: double.infinity,

                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 2
                      )
                    ],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [



                   const Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Text("Expo universelle d’Osaka 2025",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),),
                    ),



                  const  Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Text("EMS is an app where users can leverage their social network to create, discover, share, and monetize events or services.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,

                        ),),
                    ),





                    Padding(
                      padding:const EdgeInsets.only(
                        left: 15,
                        right: 15
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.white,
                        elevation: 2,
                        onPressed: (){
                          MyServices myServices = Get.find();
                          myServices.sharedPreferences.setString("step", "1");
                          Get.to(()=>const LoginPage());
                          },

                        child: const Text("Get Started",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff274560),
                              fontWeight: FontWeight.w500
                          ),),),
                    )

                  ],
                ),
              ),
            ),

          ],

        ),
      ),
    ));
  }
}