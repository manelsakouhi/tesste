import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teste/Admin/utils/app_color.dart';

import '../../core/constant/approutes.dart';
import '../../core/services/services.dart';

class UpdateProfil extends StatefulWidget {
  const UpdateProfil({super.key});

  @override
  _UpdateProfilState createState() => _UpdateProfilState();
}

class _UpdateProfilState extends State<UpdateProfil> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  File? _imageFile;
  final picker = ImagePicker();
  bool _isLoading = false;
  String? _errorMessage;
  String _imageUrl = ''; // Initialize _imageUrl as an empty string

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  //final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data()!;
        _firstNameController.text = userData['firstName'] ?? '';
        _lastNameController.text = userData['lastName'] ?? '';
        _locationController.text = userData['location'] ?? '';
       // _emailController.text = userData['email'] ?? '';
        _imageUrl = userData['image'] ?? ''; // Set the image URL

        if (_imageUrl.isNotEmpty) {
          setState(() {
            _imageFile = null; // Ensure local image file is not set
          });
        }
      } else {
        _errorMessage = 'No data available';
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch user data: $e';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to pick image: $e';
      });
    }
  }

  Future<void> _showImageSourceDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('51'.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
              child:  Text('50'.tr),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
              child:  Text('41'.tr),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String location = _locationController.text;
   // String email = _emailController.text;

    String? imageUrl;

    try {
      if (_imageFile != null) {
        // Upload image to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/${currentUser.uid}');
        final uploadTask = storageRef.putFile(_imageFile!);
        final snapshot = await uploadTask.whenComplete(() => {});
        imageUrl = await snapshot.ref.getDownloadURL();
      } else {
        imageUrl =
            _imageUrl; // Keep the existing image URL if no new image is selected
      }

      // Update user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        'firstName': firstName,
        'lastName': lastName,
        'location': location,
       // 'email': email,
        if (imageUrl != null) 'image': imageUrl,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );

      // Refresh page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const UpdateProfil()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to update profile: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Update user data to mark as deleted
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({
        'states': 'deleted', // Set a 'status' field to 'deleted'
        'message': 'Profile marked as deleted by you'
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile marked as deleted by you')),
      );

      // Sign out the user
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(AppRoute.login);
      MyServices myServices = Get.find();
      myServices.sharedPreferences.clear();
      myServices.sharedPreferences.setString("step", "1");
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to delete profile: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title:  Text("52".tr, textAlign: TextAlign.center),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 63,
                  backgroundColor: AppColors.primaryColor,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : (_imageUrl.isNotEmpty
                            ? NetworkImage(_imageUrl) as ImageProvider
                            : null),
                    child: _imageFile == null && _imageUrl.isEmpty
                        ? Center(
                            child: Text(
                              _firstNameController.text.isNotEmpty
                                  ? _firstNameController.text[0]
                                  : '',
                              style:
                                  TextStyle(fontSize: 40, color: Colors.white),
                            ),
                          )
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primaryColor,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: _showImageSourceDialog,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            if (_isLoading) ...[
              Center(child: CircularProgressIndicator()),
            ] else if (_errorMessage != null) ...[
              Center(
                  child: Text(_errorMessage!,
                      style: TextStyle(color: Colors.red))),
            ],
            Form(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _firstNameController,
                    decoration:  InputDecoration(
                      label: Text("16".tr),
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _lastNameController,
                    decoration:  InputDecoration(
                      label: Text("17".tr),
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _locationController,
                    decoration:  InputDecoration(
                      label: Text("53".tr),
                      prefixIcon: Icon(Icons.location_on),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                 /*  TextFormField(
                    controller: _emailController,
                    decoration:  InputDecoration(
                      label: Text("7".tr),
                      prefixIcon: Icon(Icons.mail),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), */
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child:  Text("54".tr,
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                 
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}