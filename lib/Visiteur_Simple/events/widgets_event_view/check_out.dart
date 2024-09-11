import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teste/Visiteur_Simple/events/widgets_event_view/join.dart';

import '../../../Admin/utils/app_color.dart';
import '../../../Admin/widgets_create_events/my_widgets.dart';
import 'CustomButtonJoin.dart';



class CheckOutView extends StatefulWidget {
  DocumentSnapshot? eventDoc;

  CheckOutView(this.eventDoc);
  

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  TextEditingController NameController = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  
  int selectedRadio = 0;
 
  void setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );
  }

String eventImage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
 
    try{
      List media = widget.eventDoc!.get('media') as List;
      Map mediaItem = media.firstWhere((element) => element['isImage'] == true) as Map;
      eventImage = mediaItem['url'];
    }catch(e){
      eventImage = '';
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: Get.height,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    
                    flex: 1,
                    child: Container(
                      width: 27,
                      height: 27,
                      padding:const EdgeInsets.all(5),
                      decoration:const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/circle.png'),
                        ),
                      ),
                      child: Image.asset('assets/images/bi_x-lg.png'),
                      
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: myText(
                        text: "Let's Join ",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(''),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 1,
                      color: Color(0xff393939).withOpacity(0.15),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(eventImage),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                myText(
                                  text: widget.eventDoc!.get('event_name'),
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                myText(
                                  text: 'may 15',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 11.67,
                                height: 15,
                                child: Image.asset(
                                  ('assets/images/location.png'),
                                 fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              myText(
                                text: widget.eventDoc!.get('location'),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          myText(
                            text: widget.eventDoc!.get('date'),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              const SizedBox(
                 height: 20,
                        ),
              TextFormField(
                controller: NameController,
                decoration:const InputDecoration(label: Text("Name"),
              
                prefixIcon: Icon(Icons.person_outline_rounded),
                   focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black),
                            ),
              ),),
              
               const SizedBox(
                height: 20,
                        ),
              TextFormField(
                controller: username,

                decoration:const InputDecoration(label: Text("SurName"),
                prefixIcon: Icon(Icons.person_outline_rounded),
                 focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black),
                            ),),
                
              ),
               const SizedBox(
                  height: 20,
                        ),              
              TextFormField(
                controller: mailController,
                decoration:const InputDecoration(label: Text("Email"),
                prefixIcon: Icon(Icons.mail),
                   focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black),
                            ),),
                
              ),
              const SizedBox(
                height: 20,
                        ),
              TextFormField(
                controller: phoneController,
                decoration:const InputDecoration(label: Text("Number phone"),
                prefixIcon: Icon(Icons.phone),
                   focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black),
                            ),),
                
              ),
            const  SizedBox(
                height: 60,
              ),
              const CustomButtonJoin(),
             
            ],
          ),
        ),
      ),
    );
  }
}

