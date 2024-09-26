

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Admin/controller/data_controller.dart';
import '../../../Admin/utils/app_color.dart';
import '../../../modeles/ticket_model.dart';



List<AustinYogaWork> austin = [
    AustinYogaWork(rangeText: '7-8', title: 'CONCERN'),
    AustinYogaWork(rangeText: '8-9', title: 'VINYASA'),
    AustinYogaWork(rangeText: '9-10', title: 'MEDITATION'),
  ];
  List<String> imageList = [
    'assets/#1.png',
    'assets/#2.png',
    'assets/#3.png',
    'assets/#1.png',
  ];
  








  EventsIJoined() {


    DataController dataController = Get.find<DataController>();

    DocumentSnapshot myUser  = dataController.allUsers.firstWhere((e)=> e.id == FirebaseAuth.instance.currentUser!.uid);


    String userImage = '';
    String userName = '';

    try{
      userImage = myUser.get('image');
    }catch(e){
      userImage = '';
    }

    try{
      userName = '${myUser.get('firstName')} ${myUser.get('lastName')}';
    }catch(e){
      userName = '';
    }


    return Column(
      children: [
       
        
        Container(
           
          child: Column(
            children: [
              // Row(
              //   children: [
              //     CircleAvatar(
              //       backgroundImage: NetworkImage(userImage),
              //       radius: 20,
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Text(
              //       userName,
              //       style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ],
              // ),
              Divider(
                color: Color(0xff918F8F).withOpacity(0.2),
              ),
             Obx(()=> dataController.isEventsLoading.value? Center(child: CircularProgressIndicator(),) :  ListView.builder(
                itemCount: dataController.joinedEvents.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {


                    String name = dataController.joinedEvents[i].get('event_name');

                    String date = dataController.joinedEvents[i].get('date');

                    date = date.split('-')[0] + '-' + date.split('-')[1];



                     List joinedUsers = [];

    try{
      joinedUsers = dataController.joinedEvents[i].get('joined');
    }catch(e){
      joinedUsers = [];
    }


                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 41, height: 24,
                              alignment: Alignment.center,
                              // padding: EdgeInsets.symmetric(
                              //     horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Color(0xffADD8E6),
                                ),
                              ),
                              child: Text(
                                date,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.06,
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      

                        Container(
                
                width: Get.width*0.6,
                height: 50,
                child: ListView.builder(itemBuilder: (ctx,index){


                    DocumentSnapshot user = dataController.allUsers.firstWhere((e)=> e.id == joinedUsers[index]);

                    String image = '';

                    try{
                      image = user.get('image');
                    }catch(e){
                      image = '';
                    }



                return Container(
                  margin: EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                minRadius: 13,
                backgroundImage: NetworkImage(image),
              ),
                );
              },itemCount: joinedUsers.length,scrollDirection: Axis.horizontal,)
              ),


                    ],
                  );
                },
              ),
             ),
             
            
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }