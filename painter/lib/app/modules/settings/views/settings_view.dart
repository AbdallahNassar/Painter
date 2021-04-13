import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:get/get.dart';
import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/core/theme/app_theme.dart';
import 'package:painter/app/modules/settings/widgets/custom_color_picker.dart';
import 'package:painter/app/modules/settings/widgets/custom_slider.dart';
import 'package:painter/app/modules/settings/widgets/pen_types.dart';
import 'package:painter/app/modules/settings/widgets/setting_tile.dart';
import 'package:painter/app/widgets/custom_app_bar.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'settings_view_title'.tr,
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingTile(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FittedBox(
                    child: Text(
                      'pen_color'.tr,
                      style: AppTheme.appTheme.textTheme.subtitle1,
                    ),
                  ),
                  CustomColorPalette(),
                ],
              ),
            ),
            SettingTile(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'pen_type'.tr,
                        style: AppTheme.appTheme.textTheme.subtitle1,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: PenTypes(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
            SettingTile(
              child: Obx(
                () => CustomSlider(
                  text: 'pen_size'.tr,
                  value: controller.strokeWidth,
                  maxValue: controller.maxPenSize,
                  minValue: controller.minPenSize - 1,
                  onChanged: (newVal) => controller.setStrokeWidth = newVal,
                ),
              ),
            ),
            SettingTile(
              child: Obx(
                () => CustomSlider(
                  text: 'eraser_size'.tr,
                  value: controller.eraserSize,
                  minValue: controller.minEraserSize - 1,
                  maxValue: controller.maxEraserSize,
                  onChanged: (newVal) => controller.setEraserSize = newVal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
