import 'package:flutter/material.dart';
import 'package:teste/Admin/utils/app_color.dart';


ThemeData themeEnglish = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        // fontFamily: "Alkatra",
        color: AppColors.primaryColor),
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.primaryColor),
    elevation: 0,
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),

  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: AppColors.primaryColor),
  // useMaterial3: true,
  // primarySwatch: AppColor.primaryColor,
  // fontFamily: "Almarai",
  // textTheme: const TextTheme(
  //     displayLarge: TextStyle(
  //         fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.black),
  //     displayMedium: TextStyle(
  //         fontWeight: FontWeight.bold, fontSize: 26, color: AppColors.black),
  //     bodyMedium: TextStyle(
  //         height: 2,
  //         color: AppColors.grey,
  //         fontWeight: FontWeight.bold,
  //         fontSize: 12)),
);

ThemeData themeJaponais = ThemeData(
  // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  useMaterial3: true,
  // primarySwatch: AppColor.primaryColor,
  // fontFamily: "Almarai",
  scaffoldBackgroundColor: Colors.white,
  // textTheme: const TextTheme(
  //   displayLarge: TextStyle(
  //       fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.black),
  //   displayMedium: TextStyle(
  //       fontWeight: FontWeight.bold, fontSize: 26, color: AppColors.black),
  //   bodyMedium: TextStyle(
  //       height: 2,
  //       color: AppColors.grey,
  //       fontWeight: FontWeight.bold,
  //       fontSize: 12),
  // ),
);
