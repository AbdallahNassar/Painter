import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:painter/app/core/utils/values/constants.dart';

class MyPainter extends CustomPainter {
  //================================ Properties ================================
  final List<Offset> pointsList;
  final PointMode pointMode;
  final double strokeWidth;
  final Color color;
  final Paint _paint = Paint()
    ..strokeWidth = Constants.lineStrokeWidth
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;
  //================================ Constructor ===============================
  MyPainter({
    required this.pointsList,
    required this.pointMode,
    required this.strokeWidth,
    required this.color,
  });
  //============================================================================
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPoints(PointMode.points, pointsList, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
