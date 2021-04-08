import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:painter/app/core/utils/values/constants.dart';
import 'package:painter/app/modules/home/widgets/custom_fab.dart';
import 'package:painter/app/theme/app_theme.dart';
import 'package:painter/app/modules/home/widgets/my_painter.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================

    //==========================================================================
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appTheme.appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text(
          Constants.appTitle,
          style: AppTheme.appTheme.appBarTheme.titleTextStyle,
        ),
        actionsIconTheme: AppTheme.appTheme.appBarTheme.actionsIconTheme,
        elevation: 1.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onPanStart: (details) {
            // to only draw in it's specified area [respect appbar and bottom]
            if (details.localPosition.direction > 0.0) {
              controller.addPoint = details.localPosition;
              // controller.addPoint = details.localPosition;
              // controller.addPoint = details.localPosition.translate(3.0, 3.0);
            }
          },
          onPanUpdate: (details) {
            if (details.localPosition.direction > 0.0) {
              // controller.addPoint = details.globalPosition;
              controller.addPoint = details.localPosition;
            }
          },
          onPanEnd: (_) => controller.addEqualizingPoint(),
          onPanCancel: () => print('enDD'),
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
      floatingActionButton: CustomFAB(),
    );
  }
}
