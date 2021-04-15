import 'dart:ui';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  //================================ Properties ================================
  final List<Offset> bigList;
  final PointMode pointMode;
  final double strokeWidth;
  final Color color;
  late final Paint _paint;
  //================================ Constructor ===============================
  MyPainter({
    required this.bigList,
    required this.pointMode,
    required this.strokeWidth,
    required this.color,
  }) {
    _paint = Paint()
      // making antiAlias 'false' will vastly improve performance when there are
      // thousands of points to paint
      ..isAntiAlias = false
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..color = color;
  }
  //============================================================================
  @override
  void paint(Canvas canvas, Size size) {
    print('painting the big list');
    // for (var pointsList in bigList)
    canvas.drawPoints(pointMode, bigList, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
