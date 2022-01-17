import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/data/models/painting.dart';

class MyPainter extends CustomPainter {
  //================================ Properties ================================
  final List<Rx<Painting>> bigList;
  final int dummyValue;
  //================================ Constructor ===============================
  MyPainter({
    required this.bigList,
    required this.dummyValue,
  });
  //============================================================================
  @override
  void paint(Canvas canvas, Size size) {
    for (var myPaint in bigList)
      canvas.drawPoints(myPaint.value.pointMode, myPaint.value.pointsList,
          myPaint.value.paint);
  }

  //============================================================================
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  //============================================================================

}
