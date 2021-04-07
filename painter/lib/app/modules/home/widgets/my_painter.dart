import 'dart:ui';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  //================================ Properties ================================
  final List<Offset> pointsList;
  final PointMode pointMode;
  final double strokeWidth;
  final Color color;
  late final Paint _paint;
  //================================ Constructor ===============================
  MyPainter({
    required this.pointsList,
    required this.pointMode,
    required this.strokeWidth,
    required this.color,
  }) {
    _paint = Paint()
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = color;
  }
  //============================================================================
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPoints(PointMode.points, pointsList, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
