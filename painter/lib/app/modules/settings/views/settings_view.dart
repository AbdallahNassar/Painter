import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:get/get.dart';
import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/core/theme/app_theme.dart';
import 'package:painter/app/modules/settings/widgets/custom_color_picker.dart';
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
              child: Obx(
                () => CustomSlider(
                  text: 'pen_size'.tr,
                  value: controller.strokeWidth,
                  maxValue: 20.0,
                  onChanged: (newVal) => controller.setStrokeWidth = newVal,
                ),
              ),
            ),
            SettingTile(
              child: Obx(
                () => CustomSlider(
                  text: 'eraser_size'.tr,
                  value: controller.minDeleteDistance,
                  maxValue: 80.0,
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

class CustomSlider extends StatelessWidget {
  //================================ Properties ================================
  final String text;
  final double value;
  final double maxValue;
  final Function onChanged;
  //================================ Constructor ===============================
  const CustomSlider({
    required this.text,
    required this.value,
    required this.onChanged,
    required this.maxValue,
  });
  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: AppTheme.appTheme.textTheme.subtitle1,
          ),
        ),
        Slider.adaptive(
          value: value,
          onChanged: (newSize) => onChanged(newSize),
          max: maxValue,
          activeColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}
