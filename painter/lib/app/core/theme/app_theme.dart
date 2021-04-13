import 'package:flutter/material.dart';

import './app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBacgroundColor,
    textTheme: TextTheme(
      button: TextStyle(fontSize: 30.0),
      subtitle1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Nunito',
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.scaffoldBacgroundColor,
      titleTextStyle: TextStyle(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
        fontFamily: 'Nunito',
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
  );
}
