import 'package:flutter/material.dart';

class MyColor extends Color {
  //================================ Properties ================================

  //================================ Constructor ===============================
  MyColor.fromRGBO(int r, int g, int b, double opacity)
      : super.fromRGBO(r, g, b, opacity);
  MyColor.fromARGB(int a, int r, int g, int b) : super.fromARGB(a, r, g, b);
  const MyColor(int value) : super(value);
  //================================= Methods ==================================
  Map<String, int> toJson() => {
        'value': value,
      };
  //============================================================================
  /// takes the 'int' value of color and constructs a color with it.
  factory MyColor.fromJson(Map<String, dynamic> jsonColor) =>
      MyColor(jsonColor['value']);
  //============================================================================
}
