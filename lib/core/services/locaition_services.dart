// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:location/location.dart';
// import 'package:teste/Admin/utils/app_color.dart';

// class LocationServices {
//   Location location = Location();

//   Future<void> checkAndRequestLocationService() async {
//     var isServiceEnabled = await location.serviceEnabled();
//     if (!isServiceEnabled) {
//       isServiceEnabled = await location.requestService();
//       if (!isServiceEnabled) {
//         throw LocationServiceException("Location Service is not enabled");
//       }
//     }
//     // return true;
//   }

//   Future<void> checkAndRequestLocationPermission() async {
//     var permissionStatus = await location.hasPermission();
//     if (permissionStatus == PermissionStatus.deniedForever) {
//       throw LocationPermissionException();
//     }
//     if (permissionStatus == PermissionStatus.denied) {
//       permissionStatus = await location.requestPermission();
//       if (permissionStatus != PermissionStatus.granted) {
//         throw LocationPermissionException();
//       }
//     }
//   }

//   void getRealTimeLocationData(void Function(LocationData)? onData) async {
//     await checkAndRequestLocationService();
//     await checkAndRequestLocationPermission();
//     location.onLocationChanged.listen(onData);
//   }

//   Future<LocationData> getLocation() async {
//     await checkAndRequestLocationService();
//     await checkAndRequestLocationPermission();
//     return await location.getLocation();
//   }

//   Future<bool> firstLoginCheckAndRequestLocationService() async {
//     try {
//       var isServiceEnabled = await location.serviceEnabled();
//       if (!isServiceEnabled) {
//         isServiceEnabled = await location.requestService();
//         if (!isServiceEnabled) {
//           Get.defaultDialog(
//             title: "خطأ في خدمة الموقع",
//             middleText: "برجاء تفعيل خدمة الموقع حتى تتمكن من استخدام التطبيق",
//             textConfirm: "موافق",
//             buttonColor: AppColors.primaryColor,
//             confirmTextColor: Colors.white,
//             titleStyle: TextStyle(
//                 color: AppColors.primaryColor, fontWeight: FontWeight.bold),
//             onConfirm: () {
//               Get.back(); // Close the dialog
//               // firstLoginCheckAndRequestLocationService();
//             },
//           );
//           return false;
//         }
//       }
//       return true; // Return true if no exception occurs
//     } catch (e) {
//       print("Error checking and requesting location service: $e");
//       return false; // Return false if an exception occurs
//     }
//   }

//   Future<bool> firstLoginCheckAndRequestLocationPermission() async {
//     try {
//       var permissionStatus = await location.hasPermission();
//       if (permissionStatus == PermissionStatus.deniedForever) {
//         Get.defaultDialog(
//           title: "خطأ في إذن الموقع",
//           middleText:
//               "لقد قمت برفض إذن الموقع بشكل دائم\n برجاء تفعيل الخدمة مرة اخرى حتى تتمكن من استخدام التطبيق.",
//           textConfirm: "موافق",
//           buttonColor: AppColors.primaryColor,
//           confirmTextColor: Colors.white,
//           titleStyle: TextStyle(
//               color: AppColors.primaryColor, fontWeight: FontWeight.bold),
//           onConfirm: () {
//             Get.back(); // Close the dialog
//           },
//         );
//         return false;
//       }
//       if (permissionStatus == PermissionStatus.denied) {
//         permissionStatus = await location.requestPermission();
//         if (permissionStatus != PermissionStatus.granted) {
//           Get.defaultDialog(
//             title: "خطأ في إذن الموقع",
//             middleText:
//                 "لقد قمت برفض إذن الموقع \n برجاء تفعيل الخدمة مرة اخرى حتى تتمكن من استخدام التطبيق.",
//             textConfirm: "موافق",
//             buttonColor: AppColors.primaryColor,
//             confirmTextColor: Colors.white,
//             titleStyle: TextStyle(
//                 color: AppColors.primaryColor, fontWeight: FontWeight.bold),
//             onConfirm: () {
//               Get.back(); // Close the dialog
//             },
//           );
//           return false;
//         }
//       }
//       return true; // Return true if no exception occurs
//     } catch (e) {
//       print("Error checking and requesting location permission: $e");
//       return false; // Return false if an exception occurs
//     }
//   }
// }

// class LocationServiceException implements Exception {
//   final String message;

//   LocationServiceException(this.message);
// }

// class LocationPermissionException implements Exception {
//   final String message = "Location Permission is denied";
// }
