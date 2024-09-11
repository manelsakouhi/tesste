

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';  //https://pub.dev/packages/nb_utils

class History extends StatefulWidget {
  static String tag = '/History';

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  Color appDividerColor = Color.fromARGB(255, 225, 12, 12);

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  var mData = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title:const Text("Participation History"),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
         
        padding: EdgeInsets.all(16),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           const Center(
              child: Text(
                "Participation in Expos",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),),
            const SizedBox(height: 10,),
         const   Text(style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20, color:Colors.black),
              "Present since the Great Exhibition of 1851 in London, Tunisia has regularly participated in both World and Specialised Expos. At Specialised Expo 2012 Yeosu, its pavilion was rewarded with the Silver Award in its category for the theme development."),
            const SizedBox(height: 20,),
            Image.asset('assets/images/expo1851.jpg'),
            const SizedBox(height: 10,), 
          const  Divider(
          height: 50,
          color: Colors.black,
          
          thickness: 3,
          indent : 10,
          endIndent : 10,       
       ),

  const SizedBox(height: 10,), 

            Text(
              "Expo 2020 Dubai",
              style: boldTextStyle(),
            ).paddingOnly(bottom: 3),
            Text(
              " Inspiring Youth, Promising Future",
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
            Center(
              child: Image.asset(
                'assets/images/expo-dubai-2020.jpg'
              ),
            ),
            Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "Expo 2015 Milan",
              style: boldTextStyle(),
            ).paddingOnly(bottom: 2),
            Text(
              "Tunisia, Naturally Generous",
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
            Center(
              child: Image.asset(
                'assets/images/expo-milano-2015.jpg'
            
              ),
            ),
          const  Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "Specialised Expo - Expo 2012 Yeosu",
              style: boldTextStyle(),
            ).paddingOnly(bottom: 2),
            Text(
              "Enthusiastic City, Connected City",
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
            Center(
              child: Image.asset(
                'assets/images/2012.jpg'
            
              ),
            ),
            Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "Expo 2010 Shanghai",
              style: boldTextStyle(),
            ).paddingOnly(bottom: 16),
            Text(
              "Enthusiastic City, Connected City",
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
            Image.asset(
                'assets/images/expo-2010.jpg'
            
              ).center(),
            Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "Expo 2008 Zaragoza",
              style: boldTextStyle(),
            ).paddingOnly(bottom: 16),
            Text(
              "Managing Water at the Desert’s Edge",
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
             Image.asset(
                'assets/images/expo-2008.jpg'
            
              ).center(),
               Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "Expo 2005 Aichi",
              style: boldTextStyle(),
            ).paddingOnly(bottom: 16),
            Text(
              "Peace and Sustainable Development",
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
             Image.asset(
                'assets/images/Expo_2005.png'
            
              ).center(),
                        Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "Expo 2000 Hannover",
              style: boldTextStyle(),
            ).paddingOnly(bottom: 16),
            Text(
              "The fight against the desert",
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
             Image.asset(
                'assets/images/Expo-2000.jpg'
            
              ).center(),
          ],
        ),
      ),
    );
  }
}