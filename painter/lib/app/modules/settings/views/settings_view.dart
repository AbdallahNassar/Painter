import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:get/get.dart';
import 'package:painter/app/core/theme/app_theme.dart';
import 'package:painter/app/widgets/custom_app_bar.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'settings_view_title'.tr,
      ),
      body: Center(
        child: TextButton(
          child: Text(
            'Colors',
          ),
          onPressed: () async {
            await Get.dialog(
              Material(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 50.0,
                      ),
                      ColorPicker(
                        pickerColor: controller.strokeColor,
                        onColorChanged: (newColor) {
                          controller.setColor = newColor;
                        },
                        showLabel: true,
                        displayThumbColor: true,
                        pickerAreaBorderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Got it',
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                ),
              ),
              useSafeArea: true,
              barrierDismissible: true,
            );
          },
        ),
      ),
    );
  }
}
