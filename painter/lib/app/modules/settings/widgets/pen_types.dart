import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';
import '';

class PenTypes extends StatelessWidget {
  //================================ Properties ================================
  final settingsController = Get.find<SettingsController>();
  //================================ Constructor ===============================

  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Spacer(),
        Expanded(
          flex: 10,
          child: PenTypesItem(
            imagePath: 'assets/images/lines.png',
            pointMode: PointMode.lines,
          ),
        ),
        Spacer(),
        Expanded(
          flex: 10,
          child: PenTypesItem(
            imagePath: 'assets/images/points.png',
            pointMode: PointMode.points,
          ),
        ),
        Spacer(),
        Expanded(
          flex: 10,
          child: PenTypesItem(
            imagePath: 'assets/images/polygons.png',
            pointMode: PointMode.polygon,
          ),
        ),
        Spacer(),
      ],
    );
  }
}
