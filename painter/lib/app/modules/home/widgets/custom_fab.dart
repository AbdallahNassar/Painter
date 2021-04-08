import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
    return SpeedDial(
      backgroundColor: Colors.deepPurple.shade900,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(color: Colors.white),
      animationSpeed: 350,
      curve: Curves.fastLinearToSlowEaseIn,
      tooltip: 'Tools',
      children: [
        SpeedDialChild(
          label: 'UNDO',
          labelStyle: _fabTextStyle(),
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
        SpeedDialChild(
          label: 'Redo',
          labelStyle: _fabTextStyle(),
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
        SpeedDialChild(
          label: 'Clear',
          labelStyle: _fabTextStyle(),
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
        SpeedDialChild(
          label: 'Restore',
          labelStyle: _fabTextStyle(),
          child: Obx(
            () => IconButton(
              icon: Icon(Icons.restore),
              onPressed: controller.isRestoreActive ? controller.restore : null,
            ),
          ),
        ),
      ],
    );
  }
}
