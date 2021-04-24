import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'my_color.dart';
import 'my_offset.dart';
import 'my_paint.dart';

class Painting {
  //================================ Properties ================================
  List<MyOffset> pointsList;
  final PointMode pointMode;
  final double strokeWidth;
  final MyColor color;
  late MyPaint paint;
  //================================ Constructor ===============================
  Painting(
    this.pointsList, {
    this.color = const MyColor(0xffffffff),
    this.pointMode = PointMode.points,
    this.strokeWidth = 5.0,
  }) {
    paint = MyPaint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..color = color;
  }
  //================================== Methods =================================
  Map<String, dynamic> toJson() => {
        'pointsList': _myOffsetListToJson(),
        'pointMode': pointMode.index,
        'strokeWidth': strokeWidth,
        'color': color.toJson(),
        'paint': paint.toJson()
      };
  //============================================================================
  factory Painting.fromJson(Map<String, dynamic> jsonPainting) => Painting(
        // This is equal to
        // 1] var temp = json.decode(jsonPainting['pointsList'])
        // 2] temp.map((element) { MyOffset.fromJson(element);}).toList()
        // The above line results in List<dynamic> so I have to copy it with
        // the following line.
        // 3] var result = List.from(temp);
        List.from(
          json
              .decode(jsonPainting['pointsList'])
              .map((element) => MyOffset.fromJson(element))
              .toList(),
        ),
        color: MyColor.fromJson(jsonPainting['color']),
        strokeWidth: jsonPainting['strokeWidth'],
        pointMode: PointMode.values[jsonPainting['pointMode']],
      );
  //============================================================================
  String _myOffsetListToJson() {
    var temp = pointsList.map((e) => e.toJson()).toList();
    return json.encode(temp);
  }
  //============================================================================

}
