import 'dart:ui';

import 'my_color.dart';

class MyPaint extends Paint {
  //================================ Properties ================================
  final bool isAntiAlias;
  final double strokeWidth;
  final PaintingStyle style;
  final StrokeCap strokeCap;
  final MyColor color;
  //================================ Constructor ===============================
  MyPaint({
    this.isAntiAlias = true,
    this.strokeWidth = 5.0,
    this.style = PaintingStyle.fill,
    this.strokeCap = StrokeCap.round,
    this.color = const MyColor(0xff000000),
  }) : super();
  //================================= Methods ==================================
  Map<String, dynamic> toJson() => {
        'isAntiAlias': true,
        'strokeWidth': 5.0,
        'style': PaintingStyle.fill.index,
        'strokeCap': StrokeCap.round.index,
        'color': color.toJson(),
      };
  //============================================================================
  factory MyPaint.fromJson(Map<String, dynamic> jsonPaint) => MyPaint(
        color: MyColor.fromJson(jsonPaint['color']),
        isAntiAlias: jsonPaint['isAntiAlias'],
        strokeCap: StrokeCap.values[jsonPaint['strokeCap']],
        style: PaintingStyle.values[jsonPaint['style']],
        strokeWidth: jsonPaint['strokeWidth'],
      );
  //============================================================================
}
