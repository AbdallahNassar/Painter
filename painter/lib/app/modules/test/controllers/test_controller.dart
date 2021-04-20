import 'dart:convert';
import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:painter/app/data/models/my_paint.dart';

class TestController extends GetxController {
  //================================ Properties ================================
  var variable = 1.obs;
  void test() {
    try {
      var x = MyPaint();
      var y = x.toJson();
      var z = MyPaint.fromJson(y);
      print(z.runtimeType);
    } catch (e) {
      print(e);
    }
  }
  //============================================================================
}

//  paint = Paint()
//       ..isAntiAlias = true
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.fill
//       ..strokeCap = StrokeCap.round
//       ..color = color;
//
