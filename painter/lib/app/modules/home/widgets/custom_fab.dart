import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';

class CustomFAB extends GetView<HomeController> {
  //================================= Methods ==================================
  TextStyle _fabTextStyle() => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Nunito',
      );

  //============================================================================
  @override
  Widget build(BuildContext context) {
    // [RotatedBox] to make the [FAB] open horizontaly.
    return RotatedBox(
      quarterTurns: 3,
      child: SpeedDial(
        backgroundColor: Colors.deepPurple.shade900,
        animatedIcon: AnimatedIcons.menu_close,
        child: Icon(Icons.ac_unit),
        animatedIconTheme: IconThemeData(color: Colors.white),
        animationSpeed: 250,
        curve: Curves.fastLinearToSlowEaseIn,
        tooltip: 'Tools',
        children: [
          SpeedDialChild(
            backgroundColor: AppColors.scaffoldBacgroundColor,
            labelStyle: _fabTextStyle(),
            child: RotatedBox(
              quarterTurns: 1,
              child: Obx(
                () => IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    size: 30.0,
                  ),
                  onPressed: controller.isUndoActive ? controller.erase : null,
                ),
              ),
            ),
          ),
          SpeedDialChild(
            backgroundColor: AppColors.scaffoldBacgroundColor,
            labelStyle: _fabTextStyle(),
            child: RotatedBox(
              quarterTurns: 1,
              child: Obx(
                () => IconButton(
                  icon: Icon(
                    Icons.undo,
                    size: 30.0,
                  ),
                  onPressed: controller.isUndoActive ? controller.undo : null,
                ),
              ),
            ),
          ),
          SpeedDialChild(
            backgroundColor: AppColors.scaffoldBacgroundColor,
            labelStyle: _fabTextStyle(),
            child: RotatedBox(
              quarterTurns: 1,
              child: Obx(
                () => IconButton(
                  icon: Icon(
                    Icons.redo,
                    size: 30.0,
                  ),
                  onPressed: controller.isRedoActive ? controller.redo : null,
                ),
              ),
            ),
          ),
          SpeedDialChild(
            backgroundColor: AppColors.scaffoldBacgroundColor,
            labelStyle: _fabTextStyle(),
            child: RotatedBox(
              quarterTurns: 1,
              child: Obx(
                () => IconButton(
                  icon: Icon(
                    Icons.cleaning_services,
                  ),
                  onPressed:
                      controller.isUndoActive ? controller.clearPoints : null,
                ),
              ),
            ),
          ),
          SpeedDialChild(
            backgroundColor: AppColors.scaffoldBacgroundColor,
            labelStyle: _fabTextStyle(),
            child: RotatedBox(
              quarterTurns: 1,
              child: Obx(
                () => IconButton(
                  icon: Icon(Icons.restore),
                  onPressed:
                      controller.isRestoreActive ? controller.restore : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
