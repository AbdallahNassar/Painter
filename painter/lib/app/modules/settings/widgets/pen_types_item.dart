import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/core/theme/app_colors.dart';
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
    return Obx(
      () => Expanded(
        flex: _settingsController.pointsMode == pointMode ? 12 : 10,
        child: GestureDetector(
          onTap: () {
            _settingsController.setPointMode = pointMode;
            // _settingsController.pointsMode == pointMode
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn,
            decoration: BoxDecoration(
              gradient: _settingsController.pointsMode == pointMode
                  ? LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                      ],
                      stops: [
                        0.15,
                        0.17,
                        0.9,
                      ],
                    )
                  : null,
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage(imagePath),
              ),
              border: Border.all(
                // the condition check will be done here and I won't save
                // it in a variable as it needs to be here for 'OBX' works
                width: _settingsController.pointsMode == pointMode ? 7.0 : 2.0,
                color: _settingsController.pointsMode == pointMode
                    ? AppColors.black
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
