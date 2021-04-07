import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:painter/app/modules/widgets/my_painter.dart';
import 'package:painter/app/theme/app_theme.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    print(_mediaQuery.size.width);
    print(_mediaQuery.size.height);
    //==========================================================================
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Painter',
          style: AppTheme.appTheme.textTheme.headline4,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: GestureDetector(
          onPanStart: (details) {
            // to only draw in it's specified area [respect appbar and bottom]
            if (details.localPosition.direction > 0.0)
              controller.addPoint = details.localPosition;
          },
          onPanUpdate: (details) {
            if (details.localPosition.direction > 0.0)
              controller.addPoint = details.localPosition;
          },
          onPanDown: (details) {
            if (details.localPosition.direction > 0.0)
              controller.addPoint = details.localPosition;
          },
          child: Obx(
            () => CustomPaint(
              painter: MyPainter(
                pointsList: controller.pointsList,
                pointMode: controller.pointsMode,
                strokeWidth: controller.strokeWidth,
                color: controller.color,
              ),
              // take all the available space
              size: Size.infinite,
              isComplex: true,
              willChange: false,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.clearPoints,
        child: Icon(Icons.cleaning_services),
      ),
    );
  }
}
