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
                      'Pen Color',
                      style: AppTheme.appTheme.textTheme.subtitle1,
                    ),
                  ),
                  CustomColorPalette(),
                ],
              ),
            ),
            SettingTile(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FittedBox(
                    child: Text(
                      'Pen Color',
                      style: AppTheme.appTheme.textTheme.subtitle1,
                    ),
                  ),
                  CustomColorPalette(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
