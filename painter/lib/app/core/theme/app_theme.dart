import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './app_colors.dart';

class AppTheme {
  // TO prevent normal instanciation.
  AppTheme._();

  static final appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    textTheme: TextTheme(
      button: TextStyle(fontSize: Get.height * 0.04 * Get.textScaleFactor),
      subtitle1: TextStyle(
        fontSize: Get.height * 0.03 * Get.textScaleFactor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Nunito',
      ),
      headline3: TextStyle(
        fontSize: Get.height * 0.055 * Get.textScaleFactor,
        color: AppColors.white,
        fontFamily: 'Nunito',
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.scaffoldBackgroundColor,
    ),
  );
}
