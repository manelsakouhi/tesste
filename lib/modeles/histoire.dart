

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: Text("38".tr),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
         
        padding: EdgeInsets.all(16),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                "108".tr,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),),
            const SizedBox(height: 10,),
            Text(style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20, color:Colors.black),
              "109".tr),
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
              "110".tr,
              style: boldTextStyle(),
            ).paddingOnly(bottom: 3),
            Text(
              "111".tr,
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
            Center(
              child: Image.asset(
                'assets/images/expo-dubai-2020.jpg'
              ),
            ),
            Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "112".tr,
              style: boldTextStyle(),
            ).paddingOnly(bottom: 2),
            Text(
              "113".tr,
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
            Center(
              child: Image.asset(
                'assets/images/expo-milano-2015.jpg'
            
              ),
            ),
          const  Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "114".tr,
              style: boldTextStyle(),
            ).paddingOnly(bottom: 2),
            Text(
              "115".tr,
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
            Center(
              child: Image.asset(
                'assets/images/2012.jpg'
            
              ),
            ),
            Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "116".tr,
              style: boldTextStyle(),
            ).paddingOnly(bottom: 16),
            Text(
              "117".tr,
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
            Image.asset(
                'assets/images/expo-2010.jpg'
            
              ).center(),
            Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "118".tr,
              style: boldTextStyle(),
            ).paddingOnly(bottom: 16),
            Text(
              "119".tr,
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
             Image.asset(
                'assets/images/expo-2008.jpg'
            
              ).center(),
               Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "120".tr,
              style: boldTextStyle(),
            ).paddingOnly(bottom: 16),
            Text(
              "121".tr,
              style: secondaryTextStyle(),
            ).paddingOnly(bottom: 16),
             Image.asset(
                'assets/images/Expo_2005.png'
            
              ).center(),
                        Divider(thickness: 3,color: Colors.black).paddingOnly(top: 16, bottom: 16),
            Text(
              "122".tr,
              style: boldTextStyle(),
            ).paddingOnly(bottom: 16),
            Text(
              "123".tr,
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