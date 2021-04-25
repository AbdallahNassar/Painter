import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:get/get.dart';
import 'package:painter/app/core/theme/app_theme.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';

class ColorpickerView extends GetView<SettingsController> {
  //================================ Properties ================================

  //================================= Methods ==================================
  Widget _buildSizedBox(_mediaQuery) {
    return SizedBox(
      height: _mediaQuery.orientation == Orientation.portrait
          ? _mediaQuery.size.height * 0.07
          : _mediaQuery.size.width * 0.05,
    );
  }

  //============================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          children: [
            _buildSizedBox(_mediaQuery),
            Obx(
              () => Text(
                'color_picker_title'.tr,
                style: AppTheme.appTheme.textTheme.headline3!.copyWith(
                  color: controller.strokeColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ColorPicker(
                pickerColor: controller.strokeColor,
                onColorChanged: (newColor) {
                  controller.setColor(newColor.value);
                },
                showLabel: true,
                displayThumbColor: true,
                pickerAreaBorderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: Obx(
                () => Text(
                  'Got it',
                  style: AppTheme.appTheme.textTheme.subtitle1!.copyWith(
                    color: controller.strokeColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
