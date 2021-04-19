import 'dart:ui';

import 'package:flutter/material.dart';

class MyPaint {
  //================================ Properties ================================
  List<Offset> pointsList;
  final PointMode pointMode;
  final double strokeWidth;
  final Color color;
  late Paint paint;
  //================================ Constructor ===============================
  MyPaint(
    this.pointsList, {
    this.color = const Color(0xff000000),
    this.pointMode = PointMode.points,
    this.strokeWidth = 5.0,
  }) {
    paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..color = color;
  }
  //============================================================================
}
