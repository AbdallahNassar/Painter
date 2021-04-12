import 'package:flutter/material.dart';

import './app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBacgroundColor,
    primaryTextTheme: TextTheme(
      button: TextStyle(fontSize: 30.0),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.scaffoldBacgroundColor,
      titleTextStyle: TextStyle(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 27.0,
        fontFamily: 'Nunito',
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
  );
}
