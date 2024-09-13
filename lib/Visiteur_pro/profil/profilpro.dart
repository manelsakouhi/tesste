import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Admin/controller/data_controller.dart';
import '../../Admin/utils/app_color.dart';
import '../../core/shared/ProfilClass.dart';
import '../../core/constant/approutes.dart';
import '../../core/services/services.dart';

class ProfilPagepro extends StatefulWidget {
  const ProfilPagepro({super.key});

  @override
  State<ProfilPagepro> createState() => _ProfilPageproState();
}

class _ProfilPageproState extends State<ProfilPagepro> {
 final currentUser = FirebaseAuth.instance.currentUser!;
  bool isNotEditable = true;

  @override
  Widget build(BuildContext context) {
    Get.put(DataController());

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page", textAlign: TextAlign.center),
        actions: [
          IconButton(
            onPressed: () async{
               await FirebaseAuth.instance.signOut();
             Get.offAllNamed(AppRoute.login);
                          MyServices myServices = Get.find();
                          myServices.sharedPreferences.clear();
                          myServices.sharedPreferences.setString("step", "1");
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ), 
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('No data available'));
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;
            String firstName = userData['firstName'] ?? '';
            String lastName = userData['lastName'] ?? '';
            String location = userData['location'] ?? '';
            String imageUrl = userData['image'] ?? ''; 

          
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 63,
                      backgroundColor: AppColors.primaryColor,

                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        backgroundImage: imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl) as ImageProvider
                            : null,
                        child: imageUrl.isEmpty
                            ? Center(
                                child: Text(
                                  firstName.isNotEmpty ? firstName[0] : '',
                                  style: const TextStyle(fontSize: 40, color: Colors.white),
                                ),
                              )
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.updateProfilPro);
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primaryColor
                          ,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.edit , color: AppColors.primaryColor,)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '$firstName $lastName',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(
                  location,
                  style: TextStyle(color: Colors.black.withOpacity(.7)),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: size.height * .7,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileWidget(
                        onTap: () {
                          Get.toNamed(AppRoute.updateProfilPro);
                        },
                        icon: Icons.person,
                        title: 'My Profile',
                      ),
                      ProfileWidget(
                        onTap: () {
                          Get.toNamed(AppRoute.settingsView);
                        },
                        icon: Icons.settings,
                        title: 'Settings',
                      ),
                      ProfileWidget(
                        onTap: () {},
                        icon: Icons.notifications,
                        title: 'Notifications',
                      ),
                      ProfileWidget(
                        onTap: () async{
                           await FirebaseAuth.instance.signOut();
                          Get.offAllNamed(AppRoute.login);
                          MyServices myServices = Get.find();
                          myServices.sharedPreferences.clear();
                          myServices.sharedPreferences.setString("step", "1");
                        },
                        icon: Icons.logout,
                        title: 'Log Out',
                      ),
                    ],
                  ),
                ),
                
              ],
            );
          },
        ),
      ),
    );
  }
}
