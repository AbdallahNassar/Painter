import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';

class PenTypesItem extends StatelessWidget {
  //================================ Properties ================================
  final _settingsController = Get.find<SettingsController>();
  final String imagePath;
  final PointMode pointMode;
  //================================ Constructor ===============================
  PenTypesItem({
    required this.imagePath,
    required this.pointMode,
  });
  //================================= Methods ==================================

  //============================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _settingsController.setPointMode = pointMode,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            width: 2.0,
            color: Colors.grey,
          ),
        ),
        child: Image.asset(
          imagePath,
        ),
      ),
    );
  }
}
