import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/core/shared/defult_button.dart';

import '../../core/constant/approutes.dart';
import '../../core/services/services.dart';
import '../../localization/changelocal.dart';

abstract class SettingsController extends LocalController {
  deleteAccount();

}

class SettingsControllerImp extends SettingsController {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool _isLoading = false;
  String? _errorMessage;


  @override
  deleteAccount() async {
    _isLoading = true;
    _errorMessage = null;
    update();

    try {
      // Update user data to mark as deleted
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({
        'states': 'deleted', // Set a 'status' field to 'deleted'
        'message': 'Profile marked as deleted by you'
      });

     
      Get.defaultDialog(
          title: "Worrning",
          middleText: "Are you shue to delete your account ?",
          actions: [
            CustomDefultButton(
              text: "confirm",
              onPressed: () async {
                // Sign out the user
                await FirebaseAuth.instance.signOut();
                Get.offAllNamed(AppRoute.login);
                MyServices myServices = Get.find();
                myServices.sharedPreferences.clear();
                myServices.sharedPreferences.setString("step", "1");
              },
            ),
            CustomDefultButton(text: "cancel", onPressed: () {
              Get.back();
            },)
          ]);
    } catch (e) {
      _errorMessage = 'Failed to delete profile: $e';
      update(); //function ta3 l getxController == hya nafsha setstate tab3 stf
    } finally {
      _isLoading = false;
    }
  }
  
  @override
  var selectedLocale = Locale('en', 'US').obs;

  
 
}
