import 'package:flutter/material.dart';

import './app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBacgroundColor,
    textTheme: TextTheme(
      headline4: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.deepPurple.shade900,
        fontWeight: FontWeight.bold,
        fontSize: 27.0,
        fontFamily: 'Nunito',
      ),
      backgroundColor: AppColors.scaffoldBacgroundColor,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
  );
}
