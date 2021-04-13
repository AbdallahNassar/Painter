import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/modules/colorpicker/views/colorpicker_view.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';
import 'package:painter/app/routes/app_pages.dart';

class CustomColorPalette extends StatelessWidget {
  //================================ Properties ================================
  final settingsController = Get.find<SettingsController>();
  //============================================================================
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: OpenContainer(
        closedElevation: 0,
        openBuilder: (context, closedContainer) {
          return ColorpickerView();
        },
        closedBuilder: (context, openContainer) {
          return Obx(
            () => CircleAvatar(
              backgroundColor: settingsController.strokeColor,
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        closedColor: settingsController.strokeColor,
        closedShape: CircleBorder(),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          AppColors.scaffoldBacgroundColor,
        ),
      ),
      onPressed: null,
    );
  }
}
