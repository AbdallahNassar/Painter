import 'package:flutter/material.dart';

import './app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBacgroundColor,
    primaryTextTheme: TextTheme(
      button: TextStyle(fontSize: 30.0),
      headline6: TextStyle(
        color: Colors.deepPurple.shade900,
        fontWeight: FontWeight.bold,
        fontSize: 27.0,
        fontFamily: 'Nunito',
      ),
    ),
    // appBarTheme: AppBarTheme(
    //   backgroundColor: AppColors.scaffoldBacgroundColor,
    //   iconTheme: IconThemeData(
    //     color: Colors.black,
    //   ),
    //   actionsIconTheme: IconThemeData(color: Colors.black),
    // ),
  );
}
