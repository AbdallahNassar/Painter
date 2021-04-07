import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:painter/app/core/utils/values/constants.dart';

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
        actions: [
          Tooltip(
            message: 'REDO',
            child: IconButton(
              icon: Icon(
                Icons.undo,
                size: 30.0,
              ),
              onPressed: controller.redo,
            ),
          ),
          Tooltip(
            message: 'UNDO',
            child: IconButton(
              icon: Icon(
                Icons.redo,
                size: 30.0,
              ),
              onPressed: controller.undo,
            ),
          ),
        ],
        actionsIconTheme: AppTheme.appTheme.appBarTheme.actionsIconTheme,
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
